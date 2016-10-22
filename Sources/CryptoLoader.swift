/*
 * ==---------------------------------------------------------------------------------==
 *
 *  File            :   CryptoLoader.swift
 *  Project         :   CryptoLoader
 *  Author          :   ALEXIS AUBRY RADANOVIC
 *
 *  License         :   The MIT License (MIT)
 *
 * ==---------------------------------------------------------------------------------==
 *
 *	The MIT License (MIT)
 *	Copyright (c) 2016 ALEXIS AUBRY RADANOVIC
 *
 *	Permission is hereby granted, free of charge, to any person obtaining a copy of
 *	this software and associated documentation files (the "Software"), to deal in
 *	the Software without restriction, including without limitation the rights to
 *	use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 *	the Software, and to permit persons to whom the Software is furnished to do so,
 *	subject to the following conditions:
 *
 *	The above copyright notice and this permission notice shall be included in all
 *	copies or substantial portions of the Software.
 *
 *	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 *	FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 *	COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 *	IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 *	CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 * ==---------------------------------------------------------------------------------==
 */

import CLibreSSL

///
/// A type that can load components of the OpenSSL library.
///

public struct CryptoLoader {
    
    // MARK: - Types
    
    ///
    /// An enumeration of components of the OpenSSL library that are not automatically loaded.
    ///
    
    public enum Component {
        
        ///
        /// The SSL library.
        ///
        
        case sslLibrary
        
        ///
        /// The OpenSSL digests.
        ///
        
        case digests
        
        ///
        /// The OpenSSL ciphers.
        ///
        
        case ciphers
        
        ///
        /// The error descriptions for the Crypto APIs.
        ///
        
        case cryptoErrorStrings
        
        ///
        /// The error descriptions for the SSL APIs.
        ///
        
        case sslErrorStrings
        
        ///
        /// Loads the receiver.
        ///
        
        fileprivate func load() {
            
            switch self {
            case .sslLibrary: SSL_library_init()
            case .digests: OpenSSL_add_all_digests()
            case .ciphers: OpenSSL_add_all_ciphers()
            case .cryptoErrorStrings: ERR_load_crypto_strings()
            case .sslErrorStrings: ERR_load_SSL_strings()
            }
            
        }
        
    }
    
    // MARK: - Properties
    
    ///
    /// The components that are loaded.
    ///
    
    private static var loadedComponents = Array<Component>()
    
    // MARK: - Loading
    
    ///
    /// Loads OpenSSL components if they are not already loaded.
    ///
    /// - parameter components: The components to load.
    ///
    
    public static func load(_ components: Component...) {
        
        let notLoadedComponents = components.filter { !(loadedComponents.contains($0)) }
        
        notLoadedComponents.forEach {
            $0.load()
            loadedComponents.append($0)
        }
        
    }
    
}
