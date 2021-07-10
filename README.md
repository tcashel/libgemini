# libgemini

[![language][badge.language]][language]
[![license][badge.license]][license]

Attempt to create a C++ library for Gemini Exchange's API: [Gemini's Documentation](https://docs.gemini.com/rest-api/).

## Building

If this is your first check out you need to build [`liblifthttp`](https://github.com/jbaldwin/liblifthttp) first, then make a build

```bash
make liblift
make
```

See the [`makefile`](/makefile) for more of the make commands.

## Dependencies

This project uses the following:
- [`liblifthttp`](https://github.com/jbaldwin/liblifthttp) to to handel HTTP requests.
- [`rapidjson`](https://github.com/Tencent/rapidjson) for json support.

## Project plan

- [ ] Set up some basic Unit testing and unit test along the way
- [ ] Build out basic public api(no auth) functionality
  - [ ] Easy way to switch between sandbox api url and production
  - [ ] try to build in rate limit protection, across one session

## Support

File bugs and feature requests using [GitHub Issues](https://github.com/tcashel/libgemini/issues)

Copyright © 2021, Tripp Cashel

[badge.language]: https://img.shields.io/badge/language-C%2B%2B17-yellow.svg
[badge.license]: https://img.shields.io/badge/license-Apache--2.0-blue

[language]: https://en.wikipedia.org/wiki/C%2B%2B17
[license]: https://en.wikipedia.org/wiki/Apache_License