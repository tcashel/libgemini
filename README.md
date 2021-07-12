# libgemini

[![language][badge.language]][language]
[![license][badge.license]][license]

Attempt to create a C++ library for Gemini Exchange's API: [Gemini's Documentation](https://docs.gemini.com/rest-api/).

## Building

If this is your first check out you need to make sure [`liblifthttp`][liblifthttp] and [`simdjson`][simdjson] git submodules are correctly checked out first, then make a build

```bash
make
```

See the [`makefile`](/makefile) for more of make commands.

## Dependencies

This project uses the following:
- [`liblifthttp`][liblifthttp] to to handel HTTP requests.
- [`simdjson`][simdjson] for json support.

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
  - inputing orders, one-off price queries etc..
  - should be somewhat lightweight
- one instance per session, could be easier if this is just a wrapper for a request or task that gets passed to the engine.

#### Engine Class (name tbd)

- what if there are 2 rates to enforce? PublicAPI vs PrivateAPI? 
  - Engine that implements ratelimit and loops over Request class instances, each which could have thier own rate limit.
  - easier to just have one enginer per session so it's only dealing with 1 rate.
- the rate limiter should always reserve a spot for 1 high priority order, ie: **cancel all orders**, **sell** etc.. This is most easily accomplised by reducing allowed rate set in Request class and allowing 1 type of order to ignore the rate limit.

#### Order Status / Market data / Event Class (name tbd)
- uses [Gemini's webhook](https://docs.gemini.com/websocket-api/#two-factor-authentication) API. 
- Need to read more

## Support

File bugs and feature requests using [GitHub Issues](https://github.com/tcashel/libgemini/issues)

Copyright © 2021, Tripp Cashel

[badge.language]: https://img.shields.io/badge/language-C%2B%2B17-yellow.svg
[badge.license]: https://img.shields.io/badge/license-Apache--2.0-blue

[language]: https://en.wikipedia.org/wiki/C%2B%2B17
[license]: https://en.wikipedia.org/wiki/Apache_License
[liblifthttp]: https://github.com/jbaldwin/liblifthttp
[simdjson]: https://github.com/simdjson/simdjson