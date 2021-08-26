# Questions

During this project I stumbled upon a few things I'd like answers to.

* Why does Swift need to compile Curl into Foundation?
https://github.com/apple/swift-corelibs-foundation/blob/84d6a68f05793f55c1a3aecf553c74fe2fae2ae9/Foundation/URLSession/libcurl/EasyHandle.swift#L187-L200

* How does threads work in Swift + Android?
It seems they both share the same "main" thread - but setting up Swift on another thread makes DispatchQueue.main not run on "main" anymore. Setting it up normally makes it deadlock. This is a problem.