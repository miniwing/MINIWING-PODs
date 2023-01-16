//
//  String+Extension.swift
//  IDEASwift
//
//  Created by Harry on 2021/10/19.
//

import Foundation

extension Bundle {
      
//   public static func dateToolsBundle(for aClass: AnyClass) -> Bundle {
//     let assetPath = Bundle(for: aClass).resourcePath!
//     return Bundle(path: NSString(string: assetPath).appendingPathComponent("DateTools.bundle"))!
//   }

   public static func bundle(for aClass: AnyClass, with aName: String) -> Bundle? {

      var stBunel = Bundle(for: aClass)
      var szPath  = stBunel.path(forResource: aName, ofType: "bundle")
      
      return Bundle.init(path: szPath!)
   }
//
//   public static func LocalizedStrings(_ string: String, _ bundle:String, _ table:String = bundle) -> String {
//
//      return NSLocalizedString(string, tableName: table, bundle: bundle, value: "", comment: "")
//   }
}

