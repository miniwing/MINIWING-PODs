//
//  String+Extension.swift
//  IDEASwift
//
//  Created by Harry on 2021/10/19.
//

import Foundation

extension String {
   
   public var isBlank: Bool {
      let trimmedStr = self.trimmingCharacters(in: .whitespacesAndNewlines)
      return trimmedStr.isEmpty
   }
   
   public var localized: String {
      return NSLocalizedString(self, comment: "")
   }

   public func localized(bundle: Bundle!) -> String {
      
      return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
   }

   public func localized(_ aClass: AnyClass, in aName: String) -> String {
      
      return NSLocalizedString(self, tableName: nil, bundle: Bundle.bundle(for: aClass, with: aName) ?? Bundle.main, value: "", comment: "")
   }
   
   public func isEmpty() -> Bool {
      return (self == "")
   }
   
   public func isNumber() -> Bool {
      //        return NSPredicate(format: "SELF MATCHES ^[0-9]+$").evaluate(with: self)
      let pattern = "^[0-9]+$"
      if NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: self) {
         return true
      }
      return false
   }
   
}

