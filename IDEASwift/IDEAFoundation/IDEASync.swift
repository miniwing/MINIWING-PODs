//
//  IDEAQueue.swift
//  IDEASwift
//
//  Created by Harry on 2021/10/19.
//

import Foundation

public class Sync {
   
   public class func synced(_ lock: Any, closure: () -> ()) {
      
      objc_sync_enter(lock)
      
      defer { objc_sync_exit(lock) }
      
      closure()
      
      return
   }
   
   public class func syncedReturn(_ lock: Any, closure: () -> (Any?)) -> Any? {
      
      objc_sync_enter(lock)
      
      defer { objc_sync_exit(lock) }
      
      return closure()
   }
}
