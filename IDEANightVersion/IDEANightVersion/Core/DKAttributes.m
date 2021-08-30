//
//  DKAttributes.m
//  IDEANightVersion
//
//  Created by Harry on 2020/1/7.
//
//  Mail: miniwing.hz@gmail.com
//  TEL : +(852)53054612
//

#import "DKAttributes.h"

#import "DKNightVersionManager.h"
#import "DKColorTable.h"

@implementation DKAttributes

+ (DKAttributesPicker)pickerWithNormalAttributes:(NSDictionary *)aNormalAttributes nightAttributes:(NSDictionary *)nightAttributes {
   return ^(DKThemeVersion *themeVersion) {
      return [themeVersion isEqualToString:DKThemeVersionNormal] ? aNormalAttributes : nightAttributes;
   };
}

+ (DKAttributesPicker)pickerWithAttributes:(NSDictionary *)aAttributes {
    return ^(DKThemeVersion *themeVersion) {
        return aAttributes;
    };
}

@end
