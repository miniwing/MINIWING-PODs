//
//  AFNetworking+Operations.h
//  IDEAKit
//
//  Created by Harry on 15/12/1.
//  Copyright © 2015年 Harry. All rights reserved.
//

#ifdef DEBUG
#  pragma clang diagnostic ignored                 "-Wnullability-completeness"
#endif /* DEBUG */

#import <IDEAKit/NSURLRequest+NSString.h>

#if (__has_include(<AFNetworking/AFNetworking.h>) || __has_include("AFNetworking/AFNetworking.h") || __has_include("AFNetworking.h"))

#  if __has_include(<AFNetworking/AFNetworking.h>)
#     import <AFNetworking/AFNetworking.h>
#  elif __has_include("AFNetworking/AFNetworking.h")
#     import "AFNetworking/AFNetworking.h"
#  elif __has_include("AFNetworking.h")
#     import "AFNetworking.h"
#  endif

NS_ASSUME_NONNULL_BEGIN

typedef NSDictionary<NSString *,NSString *>        HttpHeader;
typedef NSMutableDictionary<NSString *,NSString *> HttpMutableHeaders;

@interface AFHTTPSessionManager (Operations)

- (NSURLSessionDataTask * _Nullable)GET:(NSString *)aURL
                                 resume:(BOOL)aResume
                                prepare:(nullable void (^)(NSMutableURLRequest *aRequest, AFHTTPSessionManager *aSessionManager))aPrepare
                                headers:(nullable NSDictionary <NSString *, NSString *> *)aHeaders
                             parameters:(nullable NSDictionary <NSString *, NSString *> *)aParams
                                success:(void (^)(NSURLSessionDataTask *aTask, id aResponse))aSUCCESS
                                failure:(void (^)(NSURLSessionDataTask *aTask, NSError *aError))aFAILURE;

/**
 Creates and runs an `NSURLSessionDataTask` with a `POST` request.
 */
- (NSURLSessionDataTask *)POST:(NSString *)aURL
                        resume:(BOOL)aRESUME
                       prepare:(nullable void (^)(NSMutableURLRequest *aRequest, AFHTTPSessionManager *aSessionManager))aPrepare
                       headers:(nullable NSDictionary <NSString *, NSString *> *)aHeaders
                    parameters:(id)aPARAMETERs
                       success:(void (^)(NSURLSessionDataTask *aTask, id aResponse))aSUCCESS
                       failure:(void (^)(NSURLSessionDataTask *aTask, NSError *aError))aFAILURE;

/**
 Creates and runs an `NSURLSessionDataTask` with a `PATCH` request.
 */
- (NSURLSessionDataTask *)PATCH:(NSString *)aURL
                         resume:(BOOL)aRESUME
                        prepare:(nullable void (^)(NSMutableURLRequest *aRequest, AFHTTPSessionManager *aSessionManager))aPrepare
                        headers:(nullable NSDictionary <NSString *, NSString *> *)aHeaders
                     parameters:(id)aPARAMETERs
                        success:(void (^)(NSURLSessionDataTask *aTask, id aResponse))aSUCCESS
                        failure:(void (^)(NSURLSessionDataTask *aTask, NSError *aError))aFAILURE;

/**
 Creates and runs an `NSURLSessionDataTask` with a multipart `POST` request.
 */
- (NSURLSessionDataTask *)POST:(NSString *)URLString
                        resume:(BOOL)aRESUME
                       prepare:(nullable void (^)(NSMutableURLRequest *aRequest, AFHTTPSessionManager *aSessionManager))aPrepare
                       headers:(nullable NSDictionary <NSString *, NSString *> *)aHeaders
                    parameters:(id)aPARAMETERs
              constructingBody:(void (^)(id <AFMultipartFormData> formData))aBlock
                      progress:(nullable void (^)(NSProgress * _Nonnull aProgress))uploadProgress
                       success:(void (^)(NSURLSessionDataTask *aTask, id aResponse))aSUCCESS
                       failure:(void (^)(NSURLSessionDataTask *aTask, NSError *aError))aFAILURE;

- (NSURLSessionDownloadTask *)DOWNLOAD:(NSString *)aURL
                                resume:(BOOL)aRESUME
                               prepare:(nullable void (^)(NSMutableURLRequest *aRequest, AFHTTPSessionManager *aSessionManager))aPrepare
                               headers:(nullable NSDictionary <NSString *, NSString *> *)aHeaders
                            parameters:(id)aPARAMETERs
                              progress:(void (^)(NSProgress *aDownloadProgress)) aDownloadProgress
                           destination:(NSURL * (^)(NSURL *aTargetPath, NSURLResponse *aResponse))aDestination
                     completionHandler:(void (^)(NSURLResponse *aResponse, NSURL *aFilePath, NSError *aError))aCompletionHandler;

- (void)cancelAllOperations;

- (NSUInteger)operationCount;

@end

NS_ASSUME_NONNULL_END

#endif /* (__has_include(<AFNetworking/AFNetworking.h>) || __has_include("AFNetworking/AFNetworking.h")) */
