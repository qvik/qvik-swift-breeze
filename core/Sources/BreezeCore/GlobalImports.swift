//
//  GlobalImports.swift
//
//  Created by Olof Thorén on 2021-08-20.
//

//NOTE: this is a work in progress and you should not do this. 1: It is done on every file. 2: @_exported is private and might change or dissapear.

//Conditionally import combine on iOS and CombineX on linux/Android
#if canImport(Combine)
    @_exported import Combine
#else
    @_exported import OpenCombine
#endif

//Conditionally import Foundation networking
#if canImport(FoundationNetworking)
    @_exported import FoundationNetworking
#else
    @_exported import Foundation
#endif
