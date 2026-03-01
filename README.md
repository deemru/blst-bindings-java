# blst-bindings-java

[![Maven Central](https://img.shields.io/maven-central/v/io.github.deemru/blst-bindings-java.svg)](https://search.maven.org/artifact/io.github.deemru/blst-bindings-java)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

[blst-bindings-java](https://github.com/deemru/blst-bindings-java) provides a thin Java package for [supranational/blst](https://github.com/supranational/blst) — SWIG-generated wrappers only, no bundled native libraries. The native library is built from source on the target system giving full control over CPU optimizations, compiler flags, and security patches.

## Why

The [Waves node](https://github.com/wavesplatform/Waves) requires BLS12-381 operations. Existing Maven packages bundle pre-built native libraries that crash on older CPUs without BMI2/ADX (e.g. Intel Atom). This package ships only Java wrappers — the native library is built from source on the target machine, so it always matches the CPU.

## Build & Install

```bash
bash build.sh
```

Missing dependencies (`swig`, `gcc`, `g++`, `default-jdk`) are installed automatically via `apt-get`.

## Testing

```bash
bash build.sh
bash verify.sh
```

Expected output:

```
BLS12-381 keygen: OK
BLS12-381 sign:   OK
BLS12-381 verify: OK
```

CI:
- All tests run in GitHub Actions on every push and on tag releases.

## Requirements

- Linux (amd64)
- Java 11 or higher

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Author

**Dmitrii Pichulin** ([@deemru](https://github.com/deemru))

## Related Projects

- [supranational/blst](https://github.com/supranational/blst) - Upstream BLS12-381 library

## Links

- [GitHub Repository](https://github.com/deemru/blst-bindings-java)
- [Maven Central](https://search.maven.org/artifact/io.github.deemru/blst-bindings-java)
- [Issue Tracker](https://github.com/deemru/blst-bindings-java/issues)
