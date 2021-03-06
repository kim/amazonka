# Amazonka

[![Build Status](https://travis-ci.org/brendanhay/amazonka.svg?branch=develop)](https://travis-ci.org/brendanhay/amazonka)
[![Hackage Version](https://img.shields.io/hackage/v/amazonka.svg)](http://hackage.haskell.org/package/amazonka)

* [Description](#description)
* [Organisation](#organisation)
* [Usage](#usage)
    * [Credentials](#credentials)
    * [Type Signatures](#type-signatures)
    * [Sending Requests](#sending-requests)
    * [Retries](#retries)
    * [Waiters](#waiters)
    * [Pagination](#pagination)
    * [Presigned URLs](#presigned-urls)
    * [Asynchronous Actions](#asynchronous-actions)
* [Contribute](#contribute)
* [Licence](#licence)

## Description

A comprehensive Amazon Web Services SDK for Haskell supporting all of the
publicly available services.

Parts of the code contained in this repository are auto-generated and
auto-magically kept up to date with Amazon's latest service APIs.

An introductory blog post detailing some of the motivation and design decisions
can be found [here](http://brendanhay.nz/amazonka-comprehensive-haskell-aws-client.html).

Haddock documentation which is in sync with the `develop` branch
can be found [here](http://brendanhay.nz/amazonka).

## Organisation

This repository is organised into the following directory structure:

* [`amazonka`](amazonka): Monad transformer and send/receive/paginate/presign logic.
* `amazonka-*`: Each of the individually supported Amazon Web Service libraries.
* `amazonka-*/examples`: An example project for the parent service which can be loaded using `make install && make repl`.
* [`core`](core): The `amazonka-core` library upon which each of the services depends.
* [`gen`](gen): Code, templates, and assets for the `amazonka-gen` executable.
* [`script`](script): Scripts to manage the release and life-cycle of the service libraries.
* [`share`](share): Makefile plumbing common to all service libraries


## Usage

You will typically add an `amazonka` dependency in your project's cabal file,
and any additional services you wish to use.

For example the `build-depends` section of a cabal file which utilises EC2 and
S3 might look like:

```
build-depends:
      amazonka
    , amazonka-ec2
    , amazonka-s3
    , base
```

### Credentials

Credentials can either be specified explicitly, or obtained from the underlying
environment in a [number of ways](http://brendanhay.nz/amazonka/amazonka-core/Network-AWS-Auth.html).

Usually the most convenient is to use `Discover`, which will attempt to read the `AWS_ACCESS_KEY`
and `AWS_SECRET_KEY` variables from the environment. If either of these variables
are not set, `amazonka` will then attempt to retrieve IAM profile information from
`http://169.254.169.254`.

This allows you to seamlessly move between development environments (where you specify or set the keys)
and production EC2 instances (which have an IAM role + profile assigned).

### Type Signatures

Type families are used to associate requests with their respective error,
signing algorithm, and response type.

If you are not familiar with type families, the easiest way to translate
signatures or type errors is:

```haskell
type Response a = Either (ServiceError (Er (Sv a))) (Rs a)
```

Translated: the `Left` branch is the error type of the service
to which the request is being sent, `a` being the request in the above alias.

The `Right` branch is the successful response associated with `a`.

For EC2's `DescribeInstances` operation the reduced type would be:

```haskell
type Response DescribeInstances = Either (ServiceError EC2Error) DescribeInstancesResponse
```

Every operation's response type is typically the operation name suffixed by `Response`,
with the exception being responses shared by multiple operations.

### Sending Requests

There are two separate styles of sending requests in `amazonka`. The explicit
parameter passing from [`Network.AWS`](amazonka/src/Network/AWS.hs), or the
Monad Transformer stack in [`Control.Monad.Trans.AWS`](amazonka/src/Control/Monad/Trans/AWS.hs).

For the parameter passing style, you send a typical request by:

```haskell
import Network.AWS
import Network.AWS.EC2

main = do
    e <- getEnv Ireland Discover
    r <- send e describeInstances
    ...
```

The main purposes of the Monad Transformer stack is to carry around the `Env`
state, manage the resource cleanup safely using `ResourceT`, and encapsulate
manageable errors using `ExceptT` to allow conveniently chaining successful requests.

A trivial example of using the `AWST` transformer is:

```haskell
import Control.Monad.Trans.AWS
import Network.AWS.EC2

main = do
    e <- getEnv Ireland Discover
    runAWST env $ do
        x <- send describeInstances
        y <- send describeTags
        ...
```

If either of the responses to `send` are failures, the first will cause the
computation to exit and the `Either` result of `runAWST` will contain the error
in the `Left` case, or the result of the entire monadic computation in the `Right` case.

The `*Catch` variants in `Control.Monad.Trans.AWS` are used when you wish to handle
any specific service errors related to the sent request without exiting the computation.

### Pagination

Pagination is supported by requests which are an instance of [`AWSPager`](http://brendanhay.nz/amazonka/amazonka-core/Network-AWS-Types.html#t:AWSPager).

The `paginate` method returns a conduit `Source` which will seamlessly return pages
of results based on the initial (or default) parameters to the first request, stopping
when the service signals there are no more results.

> `AWSRequest` is a super-class of `AWSPager`, so you can typically `send` a request
> such as `DescribeAutoScalingGroups` instead of fully paginating it.
> This can be a convenient way to obtain only the first page of results without
> using any conduit operators.

### Retries

Various services support some form of rudimentary or exotic retry logic.

Usually it is some form of exponential back _on_, with general server errors,
rate limit exceeded errors, or service unavailable errors handled in the common cases.

The `Network.AWS.<ServiceName>.Types` module contains the retry specification
for each respective service.

Additionally, the library will retry basic HTTP errors. This and other retry logic
can be overriden in the environment available to the request functions.

### Waiters

Waiters are used to poll for remote conditions in the face of eventually consistent
API operations. The `Wait` specifications can be found in the `Network.AWS.<ServiceName>.Waiters`
namespace for services that support it. These specifications can be used in conjunction
with the `await` variants.

For example, if you issued a DynamoDB `DeleteTable` operation, and then wished
to wait for confirmation that the table has been deleted:

```haskell
await tableNotExists (describeTable "table-name")
```

This will attempt the `DescribeTable` operation a maximum of 25 times,
with 20 seconds of delay between each attempt, until the `Wait` criteria
succeeds, fails, or exceptionally exits.

See each individual service for more information on what waiters are supported.

### Presigned URLs

Presigned URLs can be generated for services which are an instance of [`AWSPresigner`](http://brendanhay.nz/amazonka/amazonka-core/Network-AWS-Types.html#t:AWSPresigner).

The `presign` and `presignURL` methods re used to specify the request to sign
and the time window in which the request (or raw URL) will be valid.

### Asynchronous Actions

`AWST` is an instance of `MonadControl`, which allows actions to be run asynchronously
with the use of `async` and `wait` from the [`lifted-async`](http://hackage.haskell.org/package/lifted-async) package.


## Contribute

For any problems, comments, or feedback please create an issue [here on GitHub](https://github.com/brendanhay/amazonka/issues).


## Licence

Amazonka is released under the [Mozilla Public License Version 2.0](http://www.mozilla.org/MPL/).

Parts of the code are derived from AWS service descriptions, licensed under Apache 2.0.
Source files subject to this contain an additional licensing clause in their header.
