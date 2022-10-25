//
//  LocationCoordinate2D.h
//  IDEAKit
//
//  Created by Harry on 2022/10/25.
//
//  Mail: miniwing.hz@gmail.com
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LocationCoordinate2D : NSObject

@property (nonatomic, assign)                CLLocationDegrees                     latitude;
@property (nonatomic, assign)                CLLocationDegrees                     longitude;

@end

@interface LocationCoordinate2D ()

+ (instancetype)locationCoordinate2D:(CLLocationCoordinate2D)aLocationCoordinate2DX;
+ (instancetype)locationCoordinate2DWithLatitude:(CLLocationDegrees)aLatitude longitude:(CLLocationDegrees)aLongitude;

@end

NS_ASSUME_NONNULL_END
