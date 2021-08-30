//
//  IDEARSA.m
//  IDEA
//
//  Created by Harry on 2019/4/2.
//  Copyright © 2019年 Harry. All rights reserved.
//

#import "IDEARSA.h"

#if __has_include(<openssl/opensslconf.h>) || __has_include("openssl/opensslconf.h")

#define BUFFSIZE  1024
#define PADDING   RSA_PADDING_TYPE_PKCS1

@interface IDEARSA () {
    
   RSA *_rsa;
}

//@property (nonatomic, strong)             RSA                                 * rsa;

@end

@implementation IDEARSA

- (void)dealloc {
   
   __LOG_FUNCTION;
   
   // Custom dealloc
   
   __SUPER_DEALLOC;
   
   return;
}

+ (id)shareInstance {
   
   static IDEARSA *_IDEARSA = nil;
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
      
      _IDEARSA = [[self alloc] init];
   });
   return _IDEARSA;
}

- (BOOL)importRSAKeyWithType:(KeyType)type {
   
   FILE     *file;
   NSString *keyName = (type == KeyTypePublic) ? @"public_key" : @"private_key";
   NSString *keyPath = [[NSBundle mainBundle] pathForResource:keyName ofType:@"pem"];
   
   file = fopen([keyPath UTF8String], "rb");
   
   if (NULL != file) {
      
      if (type == KeyTypePublic) {
         
         _rsa = PEM_read_RSA_PUBKEY(file, NULL, NULL, NULL);
         
         assert(_rsa != NULL);
      }
      else {
         
         _rsa = PEM_read_RSAPrivateKey(file, NULL, NULL, NULL);
         
         assert(_rsa != NULL);
      }
      
      fclose(file);
      
      return (_rsa != NULL) ? YES : NO;
   }
   
   return NO;
}

- (BOOL)importRSAKeyWithPath:(NSString *)aKeyPath KeyType:(KeyType)type {
   
   FILE     *stFile  = NULL;
   
   stFile = fopen([aKeyPath UTF8String], "rb");
   
   if (NULL != stFile) {
      
      if (type == KeyTypePublic) {
         
         _rsa = PEM_read_RSA_PUBKEY(stFile, NULL, NULL, NULL);
         assert(_rsa != NULL);
      }
      else {
         
         _rsa = PEM_read_RSAPrivateKey(stFile, NULL, NULL, NULL);
         assert(_rsa != NULL);
      }
      
      fclose(stFile);
      
      return (_rsa != NULL) ? YES : NO;
   }
   
   return NO;
}

- (BOOL)importRSAKeyFromeStringWithType:(KeyType)type andKey:(NSString *)key
{
   if (key.length == 0) { return NO; }
   
   BIO   *keybio  = NULL;
   keybio = BIO_new_mem_buf((__bridge void *)(key), -1);
   
   if (keybio==NULL) {
      
      printf( "Failed to create key BIO");
      return 0;
   }
   
   if (type == KeyTypePublic) {
      
      _rsa = PEM_read_bio_RSA_PUBKEY(keybio, &_rsa,NULL, NULL);
      
   } /* End if () */
   else {
      
      _rsa = PEM_read_bio_RSAPrivateKey(keybio, &_rsa,NULL, NULL);
      
   } /* End else */
   
   BIO_free(keybio);
   
   return (_rsa != NULL) ? YES : NO;
}

- (NSString *)encryptByRsa:(NSString*)content withKeyType:(KeyType)keyType {
   
   //   if (![self importRSAKeyWithPath:keyType])
   //      return nil;
   
   //    if (![self importRSAKeyWithType:keyType])
   //        return nil;
   
   int status;
   NSUInteger length  = [content length];
   unsigned char input[length + 1];
   bzero(input, length + 1);
   int i = 0;
   for (; i < length; i++)
   {
      input[i] = [content characterAtIndex:i];
   }
   
   NSInteger  flen = [self getBlockSizeWithRSA_PADDING_TYPE:PADDING];
   
   char *encData = (char*)malloc(flen);
   bzero(encData, flen);
   
   switch (keyType) {
   case KeyTypePublic:
      status = RSA_public_encrypt((int)length, (unsigned char*)input, (unsigned char*)encData, _rsa, PADDING);
      break;
      
   default:
      status = RSA_private_encrypt((int)length, (unsigned char*)input, (unsigned char*)encData, _rsa, PADDING);
      break;
   }
   
   if (status)
   {
      NSData *returnData = [NSData dataWithBytes:encData length:status];
      free(encData);
      encData = NULL;
      
      NSString *ret = [self base64EncodedStringForData:returnData ];
      return ret;
   }
   
   free(encData);
   encData = NULL;
   
   return nil;
}
- (NSString *)decryptByRsa:(NSString*)content withKeyType:(KeyType)keyType
{
   //   if (![self importRSAKeyWithPath:keyType])
   //      return nil;
   //    if (![self importRSAKeyWithType:keyType])
   //        return nil;
   
   int status;
   
   NSData *data = [self base64DecodedDataForString:content];
   NSUInteger length = [data length];
   
   NSInteger flen = [self getBlockSizeWithRSA_PADDING_TYPE:PADDING];
   char *decData = (char*)malloc(flen);
   bzero(decData, flen);
   
   switch (keyType) {
   case KeyTypePublic:
      status = RSA_public_decrypt((int)length, (unsigned char*)[data bytes], (unsigned char*)decData, _rsa, PADDING);
      break;
      
   default:
      status = RSA_private_decrypt((int)length, (unsigned char*)[data bytes], (unsigned char*)decData, _rsa, PADDING);
      break;
   }
   
   if (status)
   {
      NSMutableString *decryptString = [[NSMutableString alloc] initWithBytes:decData length:strlen(decData) encoding:NSASCIIStringEncoding];
      free(decData);
      decData = NULL;
      
      return decryptString;
   }
   
   free(decData);
   decData = NULL;
   
   return nil;
}
- (int)getBlockSizeWithRSA_PADDING_TYPE:(RSA_PADDING_TYPE)padding_type
{
   int len = RSA_size(_rsa);
   
   if (padding_type == RSA_PADDING_TYPE_PKCS1 || padding_type == RSA_PADDING_TYPE_SSLV23) {
      len -= 11;
   }
   
   return len;
}
//---------------加密工具方法
- (NSString *)base64EncodedStringForData:(NSData *)data
{
   return [self base64EncodedStringWithWrapWidth:0 data:data];
}

- (NSString *)base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth data:(NSData *)data
{
   //ensure wrapWidth is a multiple of 4
   wrapWidth = (wrapWidth / 4) * 4;
   
   const char lookup[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
   
   long long inputLength = [data length];
   const unsigned char *inputBytes = [data bytes];
   
   long long maxOutputLength = (inputLength / 3 + 1) * 4;
   maxOutputLength += wrapWidth? (maxOutputLength / wrapWidth) * 2: 0;
   unsigned char *outputBytes = (unsigned char *)malloc(maxOutputLength);
   
   long long i;
   long long outputLength = 0;
   for (i = 0; i < inputLength - 2; i += 3)
   {
      outputBytes[outputLength++] = lookup[(inputBytes[i] & 0xFC) >> 2];
      outputBytes[outputLength++] = lookup[((inputBytes[i] & 0x03) << 4) | ((inputBytes[i + 1] & 0xF0) >> 4)];
      outputBytes[outputLength++] = lookup[((inputBytes[i + 1] & 0x0F) << 2) | ((inputBytes[i + 2] & 0xC0) >> 6)];
      outputBytes[outputLength++] = lookup[inputBytes[i + 2] & 0x3F];
      
      //add line break
      if (wrapWidth && (outputLength + 2) % (wrapWidth + 2) == 0)
      {
         outputBytes[outputLength++] = '\r';
         outputBytes[outputLength++] = '\n';
      }
   }
   
   //handle left-over data
   if (i == inputLength - 2)
   {
      // = terminator
      outputBytes[outputLength++] = lookup[(inputBytes[i] & 0xFC) >> 2];
      outputBytes[outputLength++] = lookup[((inputBytes[i] & 0x03) << 4) | ((inputBytes[i + 1] & 0xF0) >> 4)];
      outputBytes[outputLength++] = lookup[(inputBytes[i + 1] & 0x0F) << 2];
      outputBytes[outputLength++] =   '=';
   }
   else if (i == inputLength - 1)
   {
      // == terminator
      outputBytes[outputLength++] = lookup[(inputBytes[i] & 0xFC) >> 2];
      outputBytes[outputLength++] = lookup[(inputBytes[i] & 0x03) << 4];
      outputBytes[outputLength++] = '=';
      outputBytes[outputLength++] = '=';
   }
   
   //truncate data to match actual output length
   outputBytes = realloc(outputBytes, outputLength);
   NSString *result = [[NSString alloc] initWithBytesNoCopy:outputBytes length:outputLength encoding:NSASCIIStringEncoding freeWhenDone:YES];
   
#if !__has_feature(objc_arc)
   [result autorelease];
#endif
   
   return (outputLength >= 4)? result: nil;
}
- (NSData *)base64DecodedDataForString:(NSString *)string
{
   return [self dataWithBase64EncodedString:string];
}
- (NSData *)dataWithBase64EncodedString:(NSString *)string
{
   const char lookup[] =
   {
      99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99,
      99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99,
      99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 62, 99, 99, 99, 63,
      52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 99, 99, 99, 99, 99, 99,
      99,  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14,
      15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 99, 99, 99, 99, 99,
      99, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
      41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 99, 99, 99, 99, 99
   };
   
   NSData *inputData = [string dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
   long long inputLength = [inputData length];
   const unsigned char *inputBytes = [inputData bytes];
   
   long long maxOutputLength = (inputLength / 4 + 1) * 3;
   NSMutableData *outputData = [NSMutableData dataWithLength:maxOutputLength];
   unsigned char *outputBytes = (unsigned char *)[outputData mutableBytes];
   
   int accumulator = 0;
   long long outputLength = 0;
   unsigned char accumulated[] = {0, 0, 0, 0};
   for (long long i = 0; i < inputLength; i++)
   {
      unsigned char decoded = lookup[inputBytes[i] & 0x7F];
      if (decoded != 99)
      {
         accumulated[accumulator] = decoded;
         if (accumulator == 3)
         {
            outputBytes[outputLength++] = (accumulated[0] << 2) | (accumulated[1] >> 4);
            outputBytes[outputLength++] = (accumulated[1] << 4) | (accumulated[2] >> 2);
            outputBytes[outputLength++] = (accumulated[2] << 6) | accumulated[3];
         }
         accumulator = (accumulator + 1) % 4;
      }
   }
   
   //handle left-over data
   if (accumulator > 0) outputBytes[outputLength] = (accumulated[0] << 2) | (accumulated[1] >> 4);
   if (accumulator > 1) outputBytes[++outputLength] = (accumulated[1] << 4) | (accumulated[2] >> 2);
   if (accumulator > 2) outputLength++;
   
   //truncate data to match actual output length
   outputData.length = outputLength;
   return outputLength? outputData: nil;
}

@end

#endif /* __has_include(<openssl/opensslconf.h>) || __has_include("openssl/opensslconf.h") */
