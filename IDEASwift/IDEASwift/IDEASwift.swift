//
//  IDEASwift.swift
//  IDEASwift
//
//  Created by Harry on 2021/10/19.
//

import Foundation

public class IDEASwift {

   #if DEBUG
   public static let Debug : Bool   = true
   public static let Error : Bool   = true
   #else
   public static let Debug : Bool   = false
   public static let Error : Bool   = false
   #endif
}

