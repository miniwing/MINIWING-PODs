//
//  IDEARSA.h
//  IDEA-APP
//
//  Created by Harry on 2019/4/2.
//  Copyright © 2019年 Harry. All rights reserved.
//
//  Mail: miniwing.hz@gmail.com
//  TEL : +(852)53054612
//

#import <Foundation/Foundation.h>

#if __has_include(<OpenSSL/OpenSSL.h>)
#  import <OpenSSL/OpenSSL.h>
#elif __has_include("OpenSSL/OpenSSL.h")
#  import "OpenSSL/OpenSSL.h"
#elif __has_include("OpenSSL.h")
#  import "OpenSSL.h"
#endif

#if __has_include(<OpenSSL/OpenSSL.h>) || __has_include("OpenSSL/OpenSSL.h")

NS_ASSUME_NONNULL_BEGIN

typedef enum {
   
   KeyTypePublic,
   KeyTypePrivate
   
} KeyType;

typedef enum {
   
   RSA_PADDING_TYPE_NONE   = RSA_NO_PADDING,
   RSA_PADDING_TYPE_PKCS1  = RSA_PKCS1_PADDING,
   RSA_PADDING_TYPE_SSLV23 = RSA_SSLV23_PADDING
   
}RSA_PADDING_TYPE;


@interface IDEAWKRSA : NSObject

- (BOOL)importRSAKeyWithPath:(NSString *)aKeyPath KeyType:(KeyType)type;
- (BOOL)importRSAKeyFromeStringWithType:(KeyType)type andKey:(NSString *)keyPath;
- (BOOL)importRSAKeyWithType:(KeyType)type;
- (int)getBlockSizeWithRSA_PADDING_TYPE:(RSA_PADDING_TYPE)padding_type;
- (NSString *)encryptByRsa:(NSString*)content withKeyType:(KeyType)keyType;
- (NSString *)decryptByRsa:(NSString*)content withKeyType:(KeyType)keyType;

@end

@interface IDEAWKRSA ()

+ (id)sharedInstance;

@end

NS_ASSUME_NONNULL_END

#endif
