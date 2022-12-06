//
//  UIImage+Extension.swift
//  IDEASwift
//
//  Created by Harry on 2021/10/19.
//

import Foundation

extension UIImage {
   
   public static func from(named name: String, in bundle: Bundle?) -> UIImage? {
      
      return UIImage.init(named: name, in: bundle, compatibleWith: nil)
   }
}

