# libgemini

[![language][badge.language]][language]
[![license][badge.license]][license]

Attempt to create a C++ library for Gemini Exchange's API: [Gemini's Documentation](https://docs.gemini.com/rest-api/).

## Checking out

This project use git submodules, `git clone https://github.com/tcashel/libgemini.git` and then run `git submodule update --init --recursive`.

### A Note About the `.vscode` and other Editor specific files

I know I know, it is unclean to commit these but it helps me stay consistent across my dev envs.  Once `libgemini` actually works I will clean these up.

## Building

If this is your first check out you need to make sure [`liblifthttp`][liblifthttp] and [`simdjson`][simdjson] git submodules are correctly checked out first, then make a build

```bash
make
```

See the [`makefile`](/makefile) for more of make commands.

## Dependencies

This project uses the following:

- [`liblifthttp`][liblifthttp] to to handel HTTP requests.
  - As a git submodule
- [`simdjson`][simdjson] for json support.
  - As a git submodule
  - CMake will compile this project base on a git tag int the [`CMakeLists.txt`](/CMakeLists.txt), so the submodule is not necessary to build, but it is convenient to look through the project when using.

## Rough Project plan / Ideas

- [ ] Set up some basic Unit testing and unit test along the way

### Backend classes

Be lazy if you can, just wrappers arround [`liblifthttp`][liblifthttp].
Make an Easy way to switch between sandbox api url and production

#### PublicAPI Class

- [ ] Build out basic public api (no auth) functionality

#### PrivateAPI Class

### User Classes

Goal is for a per session outgoing rate limiter

#### Request/Session class (name tbd)

- interface for creating / managing requests to API
  - inputting orders, one-off price queries etc..
  - should be somewhat lightweight
- one instance per session, could be easier if this is just a wrapper for a request or task that gets passed to the engine.

#### Engine Class (name tbd)

- what if there are 2 rates to enforce? PublicAPI vs PrivateAPI?
  - Engine that implements ratelimit and loops over Request class instances, each which could have their own rate limit.
  - easier to just have one engine per session so it's only dealing with 1 rate.
- the rate limiter should always reserve a spot for 1 high priority order, ie: **cancel all orders**, **sell** etc.. This is most easily accomplished by reducing allowed rate set in Request class and allowing 1 type of order to ignore the rate limit.

#### Order Status / Market data / Event Class (name tbd)

- uses [Gemini's webhook](https://docs.gemini.com/websocket-api/#two-factor-authentication) API.
- Need to read more
- websocket libraries
  - [`cpprestsdk`](https://github.com/microsoft/cpprestsdk)
    - [Web Socket support](https://github.com/microsoft/cpprestsdk/wiki/Web-Socket)
    - Project is in 'maintenance mode' so not the best thing to use, should search for  another option.
    - `$ sudo dnf install cpprest-devel`
  - [`µWebSockets`](https://github.com/uNetworking/uWebSockets)
    - This looks nice!, 63 contributors, ok not great recent activity
    - Apache 2.0 license
    - header only c++17, some use of c++20 in examples
    - does not use cmake, uses make, nbd just add `include_directories(vendor/uWebSockets/src)` to cmake and we should be good since it is header only.

## Support

File bugs and feature requests using [GitHub Issues](https://github.com/tcashel/libgemini/issues)

Copyright © 2021, Tripp Cashel, all rights reserved.

[badge.language]: https://img.shields.io/badge/language-C%2B%2B17-yellow.svg
[badge.license]: https://img.shields.io/badge/license-Apache--2.0-blue

[language]: https://en.wikipedia.org/wiki/C%2B%2B17
[license]: https://en.wikipedia.org/wiki/Apache_License
[liblifthttp]: https://github.com/jbaldwin/liblifthttp
[simdjson]: https://github.com/simdjson/simdjson
