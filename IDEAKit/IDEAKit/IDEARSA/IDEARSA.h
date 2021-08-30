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

#if __has_include(<openssl/opensslconf.h>)
#  import <openssl/rsa.h>
#  import <openssl/pem.h>
#  import <openssl/err.h>
#elif __has_include("openssl/opensslconf.h")
#  import "openssl/rsa.h"
#  import "openssl/pem.h"
#  import "openssl/err.h"
//#elif __has_include("opensslconf.h")
//#  import "rsa.h"
//#  import "pem.h"
//#  import "err.h"
#endif

#if __has_include(<openssl/opensslconf.h>) || __has_include("openssl/opensslconf.h")

NS_ASSUME_NONNULL_BEGIN

typedef enum
{
   KeyTypePublic,
   KeyTypePrivate
} KeyType;

typedef enum
{
   RSA_PADDING_TYPE_NONE   = RSA_NO_PADDING,
   RSA_PADDING_TYPE_PKCS1  = RSA_PKCS1_PADDING,
   RSA_PADDING_TYPE_SSLV23 = RSA_SSLV23_PADDING
   
}RSA_PADDING_TYPE;


@interface IDEARSA : NSObject

- (BOOL)importRSAKeyWithPath:(NSString *)aKeyPath KeyType:(KeyType)type;
- (BOOL)importRSAKeyFromeStringWithType:(KeyType)type andKey:(NSString *)keyPath;
- (BOOL)importRSAKeyWithType:(KeyType)type;
- (int)getBlockSizeWithRSA_PADDING_TYPE:(RSA_PADDING_TYPE)padding_type;
- (NSString *)encryptByRsa:(NSString*)content withKeyType:(KeyType)keyType;
- (NSString *)decryptByRsa:(NSString*)content withKeyType:(KeyType)keyType;

@end

@interface IDEARSA ()

+ (id)shareInstance;

@end

NS_ASSUME_NONNULL_END

#endif
