//
//  IDEAUIRouter.m
//  IDEAUIRouter
//
//  Created by limboy on 12/9/14.
//  Copyright (c) 2014 juangua. All rights reserved.
//

#import "IDEAUIRouter.h"
#import <objc/runtime.h>

static NSString * const IDEA_ROUTER_WILDCARD_CHARACTER = @"~";

NSString *const IDEAUIRouterParameterURL        = @"IDEAUIRouterParameterURL";
NSString *const IDEAUIRouterParameterCompletion = @"IDEAUIRouterParameterCompletion";
NSString *const IDEAUIRouterParameterUserInfo   = @"IDEAUIRouterParameterUserInfo";

@interface IDEAUIRouter ()
/**
 *  保存了所有已注册的 URL
 *  结构类似 @{@"beauty": @{@":id": {@"_", [block copy]}}}
 */
@property (nonatomic) NSMutableDictionary *routes;

@end

@implementation IDEAUIRouter

+ (instancetype)sharedIsntance {
   
   static IDEAUIRouter     *g_INSTANCE    = nil;
   static dispatch_once_t   stOnceToken;
   dispatch_once(&stOnceToken, ^(void) {
      
      g_INSTANCE = [[self alloc] init];
   });
   return g_INSTANCE;
}

+ (void)registerURLPattern:(NSString *)aURLPattern toHandler:(IDEAUIRouterHandler)aHandler {
   
   [[self sharedIsntance] addURLPattern:aURLPattern andHandler:aHandler];
   
   return;
}

+ (void)openURL:(NSString *)aURL {
   
   [self openURL:aURL completion:nil];
}

+ (void)openURL:(NSString *)aURL completion:(IDEAUIRouterCompletion)aCompletion {
   
   [self openURL:aURL withUserInfo:nil completion:aCompletion];
}

+ (void)openURL:(NSString *)aURL withUserInfo:(NSDictionary *)aUserInfo completion:(IDEAUIRouterCompletion)aCompletion {
   
   aURL = [aURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
   NSMutableDictionary *stParameters = [[self sharedIsntance] extractParametersFromURL:aURL];
   
   [stParameters enumerateKeysAndObjectsUsingBlock:^(id aKey, NSString *aObj, BOOL *stop) {
      
      if ([aObj isKindOfClass:[NSString class]]) {
         
         stParameters[aKey] = [aObj stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
      }
   }];
   
   if (stParameters) {
      
      IDEAUIRouterHandler stHandler = stParameters[@"block"];
      if (aCompletion) {
         
         stParameters[IDEAUIRouterParameterCompletion] = aCompletion;
      }
      if (aUserInfo) {
         
         stParameters[IDEAUIRouterParameterUserInfo] = aUserInfo;
      }
      if (stHandler) {
         
         [stParameters removeObjectForKey:@"block"];
         stHandler(aURL, stParameters, aCompletion);
      }
   }
   
   return;
}

+ (BOOL)canOpenURL:(NSString *)aURL {
   
   return [[self sharedIsntance] extractParametersFromURL:aURL] ? YES : NO;
}

+ (NSString *)generateURLWithPattern:(NSString *)aPattern parameters:(NSArray *)aParameters {
   
   NSInteger       nStartIndexOfColon  = 0;
   NSMutableArray *stItems             = [[NSMutableArray alloc] init];
   NSInteger       nParameterIndex     = 0;
   
   for (int H = 0; H < aPattern.length; H++) {
      
      NSString *szCharacter   = [NSString stringWithFormat:@"%c", [aPattern characterAtIndex:H]];
      if ([szCharacter isEqualToString:@":"]) {
         
         nStartIndexOfColon = H;
      }
      
      if (([@[@"/", @"?", @"&"] containsObject:szCharacter] || (H == aPattern.length - 1 && nStartIndexOfColon) ) && nStartIndexOfColon) {
         
         if (H > (nStartIndexOfColon + 1)) {
            
            [stItems addObject:[NSString stringWithFormat:@"%@%@", [aPattern substringWithRange:NSMakeRange(0, nStartIndexOfColon)], aParameters[nParameterIndex++]]];
            aPattern = [aPattern substringFromIndex:H];
            H = 0;
            
         } /* End if () */
         
         nStartIndexOfColon = 0;
         
      } /* End if () */
      
   } /* End for () */
   
   return [stItems componentsJoinedByString:@""];
}

#pragma mark - Utils

- (NSMutableDictionary *)extractParametersFromURL:(NSString *)aURL {
   
   NSMutableDictionary  *stParameters     = [NSMutableDictionary dictionary];
   
   stParameters[IDEAUIRouterParameterURL] = aURL;
   
   NSMutableDictionary  *stSubRoutes      = self.routes;
   NSArray              *stPathComponents = [self pathComponentsFromURL:aURL];
   
   // borrowed from HHRouter(https://github.com/Huohua/HHRouter)
   for (NSString *szPathComponent in stPathComponents) {
      
      BOOL      bFound  = NO;
      
      // 对 key 进行排序，这样可以把 ~ 放到最后
      NSArray  *stSubRoutesKeys  =[stSubRoutes.allKeys sortedArrayUsingComparator:^NSComparisonResult(NSString *aObj1, NSString *aObj2) {
         
         return [aObj1 compare:aObj2];
      }];
      
      for (NSString *szKey in stSubRoutesKeys) {
         
         if ([szKey isEqualToString:szPathComponent] || [szKey isEqualToString:IDEA_ROUTER_WILDCARD_CHARACTER]) {
            
            bFound      = YES;
            stSubRoutes = stSubRoutes[szKey];
            
            break;
         }
         else if ([szKey hasPrefix:@":"]) {
            
            bFound      = YES;
            stSubRoutes = stSubRoutes[szKey];
            stParameters[[szKey substringFromIndex:1]] = szPathComponent;
            
            break;
         }
      }
      // 如果没有找到该 pathComponent 对应的 handler，则以上一层的 handler 作为 fallback
      if (!bFound && !stSubRoutes[@"_"]) {
         
         return nil;
      }
   }
   
   // Extract Params From Query.
   NSArray* pathInfo = [aURL componentsSeparatedByString:@"?"];
   if (pathInfo.count > 1) {
      
      NSString* parametersString = [pathInfo objectAtIndex:1];
      NSArray* paramStringArr = [parametersString componentsSeparatedByString:@"&"];
      for (NSString* paramString in paramStringArr) {
         
         NSArray* paramArr = [paramString componentsSeparatedByString:@"="];
         if (paramArr.count > 1) {
            
            NSString* key = [paramArr objectAtIndex:0];
            NSString* value = [paramArr objectAtIndex:1];
            stParameters[key] = value;
         }
      }
   }
   
   if (stSubRoutes[@"_"]) {
      
      stParameters[@"block"] = [stSubRoutes[@"_"] copy];
      
   } /* End if () */
   
   return stParameters;
}

- (void)addURLPattern:(NSString *)URLPattern andHandler:(IDEAUIRouterHandler)handler {
   
   NSArray              *stPathComponents = [self pathComponentsFromURL:URLPattern];
   
   NSInteger             nIndex           = 0;
   NSMutableDictionary  *stSubRoutes      = self.routes;
   
   while (nIndex < stPathComponents.count) {
      
      NSString *stPathComponent  = stPathComponents[nIndex];
      
      if (![stSubRoutes objectForKey:stPathComponent]) {
         
         stSubRoutes[stPathComponent] = [[NSMutableDictionary alloc] init];
         
      } /* End if () */
      
      stSubRoutes = stSubRoutes[stPathComponent];
      nIndex++;
      
   } /* End while () */
   
   if (handler) {
      
      stSubRoutes[@"_"] = [handler copy];
      
   } /*  End if ()*/
   
   return;
}

- (NSArray*)pathComponentsFromURL:(NSString*)aURL {
   
   NSMutableArray *stPathComponents = [NSMutableArray array];
   
   if ([aURL rangeOfString:@"://"].location != NSNotFound) {
      
      NSArray  *stPathSegments   = [aURL componentsSeparatedByString:@"://"];
      
      // 如果 URL 包含协议，那么把协议作为第一个元素放进去
      [stPathComponents addObject:stPathSegments[0]];
      
      // 如果只有协议，那么放一个占位符
      if ((stPathSegments.count == 2 && ((NSString *)stPathSegments[1]).length) || stPathSegments.count < 2) {
         
         [stPathComponents addObject:IDEA_ROUTER_WILDCARD_CHARACTER];
         
      } /*  End if ()*/
      
      aURL = [aURL substringFromIndex:[aURL rangeOfString:@"://"].location + 3];
      
   } /*  End if ()*/
   
   for (NSString *pathComponent in [[NSURL URLWithString:aURL] pathComponents]) {
      
      if ([pathComponent isEqualToString:@"/"]) {
         
         continue;
         
      } /*  End if ()*/
      
      if ([[pathComponent substringToIndex:1] isEqualToString:@"?"]) {
         
         break;
         
      } /*  End if ()*/
      
      [stPathComponents addObject:pathComponent];
      
   } /*  End for ()*/
   
   return [stPathComponents copy];
}

- (NSMutableDictionary *)routes {
   
   if (!_routes) {
      
      _routes = [[NSMutableDictionary alloc] init];
      
   } /*  End if ()*/
   
   return _routes;
}

@end
