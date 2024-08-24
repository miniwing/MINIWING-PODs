//
//  KeyChainStore.m
//  ContentProvider
//
//  Created by Harry on 2022/3/29.
//
//  Mail: miniwing.hz@gmail.com
//  TEL : +(852)53054612
//

#import <AdSupport/AdSupport.h>

#import "KeyChainStore.h"

@implementation KeyChainStore

+ (void)saveUUID:(NSString *)aUUID withBundleID:(NSString *)aBundleID {
   
   int                            nErr                                     = EFAULT;
   
   NSError                       *stError                                  = nil;
   BOOL                           bSaved                                   = NO;
   
   __TRY;

   //首次执行该方法时，uuid为空
   if (!kStringIsBlank(aUUID)) {
      
      /** 保存用户的密码*/
      bSaved = [YYKeychain setPassword:aUUID
                            forService:[NSString stringWithFormat:@"%@.UUID", aBundleID]
                               account:@"UUID"
                                 error:&stError];
      if (!bSaved || nil != stError) {
         
         LogError((@"保存UUID出错：%@", stError));
         
      } /* End if () */
   
   } /* End if () */

   __CATCH(nErr);
   
   return;
}

+ (void)removeUUIDWithBundleID:(NSString *)aBundleID {
   
   int                            nErr                                     = EFAULT;

   NSError                       *stError                                  = nil;
   YYKeychainItem                *stKeychainItem                           = nil;
   
   __TRY;

   stKeychainItem = [[YYKeychainItem alloc] init];
   stKeychainItem.service  = [NSString stringWithFormat:@"%@.UUID", aBundleID];

   [YYKeychain deleteItem:stKeychainItem error:&stError];
   
   __CATCH(nErr);
   
   return;
}

+ (NSString *)queryUUIDWithBundleID:(NSString *)aBundleID {

   int                            nErr                                     = EFAULT;
   
   NSString                      *szUUID                                   = nil;
   NSError                       *stError                                  = nil;
   
   __TRY;

   szUUID   = [YYKeychain getPasswordForService:[NSString stringWithFormat:@"%@.UUID", aBundleID]
                                        account:@"UUID"
                                          error:&stError];
   
   if (nil != stError) {
      
      szUUID   = nil;
      
   } /* End if () */

   __CATCH(nErr);
   
   return szUUID;
}

@end
