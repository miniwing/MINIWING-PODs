//
//  NSData+Extension.m
//  IDEAEventKit
//
//  Created by Harry on 2021/7/21.
//  Copyright © 2021 Harry. All rights reserved.
//
//  Mail: miniwing.hz@gmail.com
//  TEL : +(852)53054612
//

#import <Foundation/Foundation.h>
#import <IDEAEventKit/IDEAEventKitProperty.h>

#import "NSData+EventKit.h"

#import "IDEAEventKit/__pragma_push.h"

// ----------------------------------
// Source code
// ----------------------------------

#pragma mark -

@implementation NSData (EventKit)

@def_prop_dynamic( NSString   *, MD5String );
@def_prop_dynamic( NSData     *, MD5Data );

@def_prop_dynamic( NSString   *, SHA1String );
@def_prop_dynamic( NSData     *, SHA1Data );

@def_prop_dynamic( NSString   *, BASE64Encrypted );

- (NSString *)MD5String {
   
   uint8_t   abyDigest[CC_MD5_DIGEST_LENGTH + 1]   = { 0 };
   
   CC_MD5( [self bytes], (CC_LONG)[self length], abyDigest );
   
   char acTemp[16]   = { 0 };
   char acHex[256]   = { 0 };
   
   for ( CC_LONG H = 0; H < CC_MD5_DIGEST_LENGTH; ++H ) {
      
      sprintf( acTemp, "%02X", abyDigest[H] );
      strcat( (char *)acHex, acTemp );
      
   }  /* End if ( CC_LONG H = 0; H < CC_MD5_DIGEST_LENGTH; ++H ) */
   
   return [NSString stringWithUTF8String:(const char *)acHex];
}

- (NSData *)MD5Data {
   
   uint8_t   abyDigest[CC_MD5_DIGEST_LENGTH + 1]   = { 0 };
   
   CC_MD5( [self bytes], (CC_LONG)[self length], abyDigest );
   
   return [NSData dataWithBytes:abyDigest length:CC_MD5_DIGEST_LENGTH];
}

- (NSString *)SHA1String {
   
   uint8_t  abyDigest[CC_SHA1_DIGEST_LENGTH + 1]  = { 0 };
   
   CC_SHA1( self.bytes, (CC_LONG)self.length, abyDigest );
   
   char acTemp [16]  = { 0 };
   char aHex   [256] = { 0 };
   
   for ( CC_LONG H = 0; H < CC_SHA1_DIGEST_LENGTH; ++H ) {
      
      sprintf( acTemp, "%02X", abyDigest[H] );
      strcat( (char *)aHex, acTemp );
      
   } /* End fo ( CC_LONG H = 0; H < CC_SHA1_DIGEST_LENGTH; ++H ) */
   
   return [NSString stringWithUTF8String:(const char *)aHex];
}

- (NSData *)SHA1Data {
   
   uint8_t  abyDigest[CC_SHA1_DIGEST_LENGTH + 1]  = { 0 };
   
   CC_SHA1( self.bytes, (CC_LONG)self.length, abyDigest );
   
   return [NSData dataWithBytes:abyDigest length:CC_SHA1_DIGEST_LENGTH];
}

- (NSString *)BASE64Encrypted {
   
   static char * __base64EncodingTable = (char *)"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
   
   // copy from THREE20
   
   if ( 0 == [self length] ) {
      
      return @"";
      
   } /* End if () */
   
   char  *pcCharacters  = (char *)malloc((([self length] + 2) / 3) * 4);
   if ( NULL == pcCharacters ) {
      
      return nil;
      
   } /* End if () */
   
   memset(pcCharacters, 0, (([self length] + 2) / 3) * 4);
   
   NSUInteger nLength   = 0;
   NSUInteger H         = 0;
   
   while ( H < [self length] ) {
      
      char   acBuffer[3]   = { 0 };
      short  sBufferLength = 0;
      
      while ( sBufferLength < 3 && H < [self length] ) {
         
         acBuffer[sBufferLength++] = ((char *)[self bytes])[H++];
         
      } /* End while () */
      
      // Encode the bytes in the buffer to four characters,
      // including padding "=" characters if necessary.
      pcCharacters[nLength++] = __base64EncodingTable[(acBuffer[0] & 0xFC) >> 2];
      pcCharacters[nLength++] = __base64EncodingTable[((acBuffer[0] & 0x03) << 4) | ((acBuffer[1] & 0xF0) >> 4)];
      
      if ( sBufferLength > 1 ) {
         
         pcCharacters[nLength++] = __base64EncodingTable[((acBuffer[1] & 0x0F) << 2) | ((acBuffer[2] & 0xC0) >> 6)];
         
      } /* End if () */
      else {
         
         pcCharacters[nLength++] = '=';
         
      } /* End else */
      
      if ( sBufferLength > 2 ) {
         
         pcCharacters[nLength++] = __base64EncodingTable[acBuffer[2] & 0x3F];
         
      } /* End if () */
      else {
         
         pcCharacters[nLength++] = '=';
         
      } /* End else */
      
   } /* End while () */
   
   return [[NSString alloc] initWithBytesNoCopy:pcCharacters length:nLength encoding:NSASCIIStringEncoding freeWhenDone:YES];
}

@end

// ----------------------------------
// Unit test
// ----------------------------------

#pragma mark -

#if __IDEA_EVENT_KIT_TESTING__

#endif // #if __IDEA_EVENT_KIT_TESTING__

#import "IDEAEventKit/__pragma_pop.h"
