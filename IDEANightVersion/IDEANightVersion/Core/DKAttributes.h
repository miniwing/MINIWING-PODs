//
//  DKAttributes.h
//  IDEANightVersion
//
//  Created by Harry on 2020/1/7.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NSString DKThemeVersion;

typedef NSDictionary * (^DKAttributesPicker)(DKThemeVersion *aThemeVersion);

@interface DKAttributes : NSObject

+ (DKAttributesPicker)pickerWithNormalAttributes:(NSDictionary *)aNormalAttributes nightAttributes:(NSDictionary *)aNightAttributes;

@end
