//
//  IDEADisposeBag.m
//  IDEAEventBus
//
//  Created by Harry on 2017/8/2.
//  Copyright © 2017 Harry. All rights reserved.
//

#import "IDEADisposeBag.h"

@interface IDEADisposeBag()

@property (nonatomic, strong) NSMutableArray<id<IDEAEventToken>> * tokens;

@end

@implementation IDEADisposeBag

- (NSMutableArray<id<IDEAEventToken>> *)tokens {
   
   if (!_tokens) {
      
      _tokens = [[NSMutableArray alloc] init];
   }
   
   return _tokens;
}

- (void)addToken:(id<IDEAEventToken>)aToken {
   
   @synchronized(self) {
      
      [self.tokens addObject:aToken];
   }
   
   return;
}

- (void)dealloc{
   
   @synchronized(self) {
      
      for (id<IDEAEventToken> stToken in self.tokens) {
         
         if ([stToken respondsToSelector:@selector(dispose)]) {
            
            [stToken dispose];
         }
      }
   }
   
   __SUPER_DEALLOC;
   
   return;
}

@end
