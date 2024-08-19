//
//  IDEACapsuleButton+Action.m
//  Pods
//
//  Created by Harry on 2024/8/18.
//
//  Mail: miniwing.hz@gmail.com
//  TEL : +(852)53054612
//

#import "IDEACapsuleButton.h"
#import "IDEACapsuleButton+Inner.h"
#import "IDEACapsuleButton+Action.h"

@implementation IDEACapsuleButton (Action)

#if __Debug__
- (IBAction)onAction:(id)aSender {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   __CATCH(nErr);

   return;
}
#endif /* __Debug__ */

- (IBAction)onMore:(id)aSender {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   [self postNotificationName:IDEACapsuleButton.moreNotification object:self];

   __CATCH(nErr);

   return;
}

- (IBAction)onDone:(id)aSender {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   [self postNotificationName:IDEACapsuleButton.doneNotification object:self];

   __CATCH(nErr);

   return;
}

@end
