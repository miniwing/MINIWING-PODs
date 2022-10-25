//
//  LocationCoordinate2D.m
//  IDEAKit
//
//  Created by Harry on 2022/10/25.
//
//  Mail: miniwing.hz@gmail.com
//  TEL : +(852)53054612
//

#import "LocationCoordinate2D.h"

@interface LocationCoordinate2D ()

//@property (nonatomic, assign)                CLLocationCoordinate2D                locationCoordinate2D;

@end

@implementation LocationCoordinate2D

- (void)dealloc {

   __LOG_FUNCTION;

   // Custom dealloc

   __SUPER_DEALLOC;

   return;
}

- (instancetype)initWithLatitude:(CLLocationDegrees)aLatitude longitude:(CLLocationDegrees)aLongitude {

   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   self  = [super init];
   
   if (self) {

      self.latitude  = aLatitude;
      self.longitude = aLongitude;

   } /* End if () */
   
   __CATCH(nErr);
   
   return self;
}

+ (instancetype)locationCoordinate2D:(CLLocationCoordinate2D)aLocationCoordinate2D {
   
   return [[LocationCoordinate2D alloc] initWithLatitude:aLocationCoordinate2D.latitude longitude:aLocationCoordinate2D.longitude];
}

+ (instancetype)locationCoordinate2DWithLatitude:(CLLocationDegrees)aLatitude longitude:(CLLocationDegrees)aLongitude {
   
   return [[LocationCoordinate2D alloc] initWithLatitude:aLatitude longitude:aLongitude];
}

@end
