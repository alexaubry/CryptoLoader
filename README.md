# `import CryptoLoader`

`CryptoLoader` is a small Swift tool that allows you to load components of the OpenSSL library.

## Important

This library is only compatible with Vapor's [CLibreSSL](https://github.com/vapor/CLibreSSL) version 1.

## Installation

This library is only available via the Swift Package Manager. To import it in your project, add this line to your `Package.swift`'s dependencies :

~~~swift
.Package(url: "https://github.com/alexaubry/CryptoLoader", majorVersion: 1)
~~~

## Usage

The library defines a set of components that can be loaded inside of the `CryptoLoader.Component` enum : 

- The SSL Library (equivalent: `SSL_library_init()`)
- The Digests (equivalent: `OpenSSL_add_all_digests()`)
- The Ciphers (equivalent: `OpenSSL_add_all_ciphers()`)
- The libcrypto error strings (equivalent: `ERR_load_crypto_strings()`)
- The libssl error strings (equivalent: `ERR_load_SSL_strings()`)

To load one or multiple components, simply call :

~~~swift
CryptoLoader.load(.sslLibrary) // loads the SSL library
CryptoLoader.load(.digests, .ciphers) // loads digests and ciphers
~~~

When you call the `CryptoLoader.load(_:)` method, the object determines whether each component has been loaded and does re-load it if it's not required.

~~~swift
CryptoLoader.load(.cryptoErrorStrings) // calls ERR_load_crypto_strings()
CryptoLoader.load(.cryptoErrorStrings) // doesn't call ERR_load_crypto_strings()
~~~
