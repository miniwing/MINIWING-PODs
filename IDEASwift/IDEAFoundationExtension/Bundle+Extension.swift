//
//  String+Extension.swift
//  IDEASwift
//
//  Created by Harry on 2021/10/19.
//

import Foundation

extension Bundle {
      
   public static func bundle(for aClass: AnyClass, with aName: String) -> Bundle? {

      var stBunel = Bundle.init(for: aClass)
      var szPath  = stBunel.path(forResource: aName, ofType: "bundle")
      
      return Bundle.init(path: szPath!)
   }
}

