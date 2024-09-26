//
//  NSArray+Hash.m
//  IDEAWKKit
//
//  Created by Tang Qiao on 12-2-4.
//  Copyright (c) 2012年 blog.devtang.com. All rights reserved.
//

#import "NSArray+Hash.h"

@implementation NSArray(Hash)

- (NSUInteger)hash {
   
    // Based upon standard hash algorithm ~ https://stackoverflow.com/a/4393493/337735
    NSUInteger  nHash      = 1;
    NSUInteger  nPrime     = 31;
   
    // Fast enumeration has an unstable ordering, so explicitly sort the keys
    // https://stackoverflow.com/a/8529761/337735
    for (id stObject in self) {
       
        // okay, so copying Java's hashCode a bit:
        // http://docs.oracle.com/javase/6/docs/api/java/util/Map.Entry.html#hashCode()
        nHash = nPrime * nHash + [stObject hash];
       
    } /* End for () */
   
    return nHash;
}

@end

