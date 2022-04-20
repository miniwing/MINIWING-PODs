//
//  SearchBarX+Debug.m
//  SearchBarX
//
//  Created by Harry on 2022/3/27.
//
//  Mail: miniwing.hz@gmail.com
//  TEL : +(852)53054612
//

#import "SearchBarX+Debug.h"

#if __Debug__
@implementation SearchBarX (Debug)

@end
#endif /* __Debug__ */

#if __InjectionIII__
#pragma mark - InjectionIII
@implementation SearchBarX (InjectionIII)

- (void)injected {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   __CATCH(nErr);
   
   return;
}

@end
#endif /* __InjectionIII__ */
