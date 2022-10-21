//
//  AFNetworking+Operations.m
//  APPCategory
//
//  Created by Harry on 15/12/1.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "AFNetworking+Operations.h"

#if (__has_include(<AFNetworking/AFNetworking.h>) || __has_include("AFNetworking/AFNetworking.h") || __has_include("AFNetworking.h"))

@implementation AFHTTPSessionManager (Operations)

- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)aMethod
                                       URLString:(NSString *)aURL
                                         prepare:(nullable void (^)(NSMutableURLRequest *aRequest, AFHTTPSessionManager *aSessionManager))aPrepare
                                         headers:(nullable NSDictionary <NSString *, NSString *> *)aHeaders
                                      parameters:(id)aParameters
                                  uploadProgress:(void (^)(NSProgress *uploadProgress)) aUploadProgress
                                downloadProgress:(void (^)(NSProgress *downloadProgress)) aDownloadProgress
                                         success:(void (^)(NSURLSessionDataTask *, id))aSUCCESS
                                         failure:(void (^)(NSURLSessionDataTask *, NSError *))aFAILURE {
   
   NSError              *stError       = nil;
      
   NSMutableURLRequest  *stRequest     = [self.requestSerializer requestWithMethod:aMethod
                                                                         URLString:aURL
                                                                        parameters:aParameters
                                                                             error:&stError];
   if (stError) {
      
      if (aFAILURE) {
         
         dispatch_async(self.completionQueue ?: dispatch_get_main_queue(), ^{
            
            aFAILURE(nil, stError);
         });
         
      } /* End if () */
      
      return nil;
      
   } /* End if () */
   
   if (aPrepare) {
      
      aPrepare(stRequest, self);
      
   } /* End if () */

   for (NSString *szHeaderField in aHeaders.keyEnumerator) {
      
      [stRequest setValue:aHeaders[szHeaderField] forHTTPHeaderField:szHeaderField];
      
   } /* End for () */
   
   __block NSURLSessionDataTask *stDataTask  = [self dataTaskWithRequest:stRequest
                                                          uploadProgress:aUploadProgress
                                                        downloadProgress:aDownloadProgress
                                                       completionHandler:^(NSURLResponse * aHttpResponse, id aResponseObject, NSError *aError) {
      if (aError) {
         
         if (aFAILURE) {
            
            aFAILURE(stDataTask, aError);
            
         } /* End if () */
         
      } /* End if () */
      else {
         
         if (aSUCCESS) {
            
            aSUCCESS(stDataTask, aResponseObject);
            
         } /* End if () */
         
      } /* End else */
   }];
   
   return stDataTask;
}

- (NSURLSessionDataTask *)GET:(NSString *)aURL
                       resume:(BOOL)aResume
                      prepare:(nullable void (^)(NSMutableURLRequest *aRequest, AFHTTPSessionManager *aSessionManager))aPrepare
                      headers:(nullable NSDictionary <NSString *, NSString *> *)aHeaders
                   parameters:(nullable NSDictionary <NSString *, NSString *> *)aParams
                      success:(void (^)(NSURLSessionDataTask *aTask, id aResponse))aSUCCESS
                      failure:(void (^)(NSURLSessionDataTask *aTask, NSError *aError))aFAILURE {
   NSURLSessionDataTask *stDataTask = [self dataTaskWithHTTPMethod:@"GET"
                                                         URLString:aURL
                                                           prepare:aPrepare
                                                           headers:aHeaders
                                                        parameters:aParams
                                                    uploadProgress:nil
                                                  downloadProgress:nil
                                                           success:aSUCCESS
                                                           failure:aFAILURE];
   
   if (aResume) {
      
      [stDataTask resume];
      
   } /* End if () */
   
   return stDataTask;
}

- (NSURLSessionDataTask *)POST:(NSString *)aURL
                        resume:(BOOL)aResume
                       prepare:(nullable void (^)(NSMutableURLRequest *aRequest, AFHTTPSessionManager *aSessionManager))aPrepare
                       headers:(nullable NSDictionary <NSString *, NSString *> *)aHeaders
                    parameters:(id)aParameters
                       success:(void (^)(NSURLSessionDataTask *aTask, id aResponse))aSUCCESS
                       failure:(void (^)(NSURLSessionDataTask *aTask, NSError *aError))aFAILURE {
   
   NSURLSessionDataTask *stDataTask = [self dataTaskWithHTTPMethod:@"POST"
                                                         URLString:aURL
                                                           prepare:aPrepare
                                                           headers:aHeaders
                                                        parameters:aParameters
                                                    uploadProgress:nil
                                                  downloadProgress:nil
                                                           success:aSUCCESS
                                                           failure:aFAILURE];
   
   if (aResume) {
      
      [stDataTask resume];
      
   } /* End if () */
   
   return stDataTask;
}

- (NSURLSessionDataTask *)POST:(NSString *)aURL
                        resume:(BOOL)aResume
                       prepare:(nullable void (^)(NSMutableURLRequest *aRequest, AFHTTPSessionManager *aSessionManager))aPrepare
                       headers:(nullable NSDictionary <NSString *, NSString *> *)aHeaders
                    parameters:(id)aPARAMETERs
              constructingBody:(void (^)(id <AFMultipartFormData> aFormData))aBlock
                      progress:(nullable void (^)(NSProgress * _Nonnull))aUploadProgress
                       success:(void (^)(NSURLSessionDataTask *aTask, id aResponse))aSUCCESS
                       failure:(void (^)(NSURLSessionDataTask *aTask, NSError *aError))aFAILURE {
   
   __block NSError     *stError     = nil;
      
   NSMutableURLRequest *stRequest   = [self.requestSerializer multipartFormRequestWithMethod:@"POST"
                                                                                   URLString:[[NSURL URLWithString:aURL relativeToURL:self.baseURL] absoluteString]
                                                                                  parameters:aPARAMETERs
                                                                   constructingBodyWithBlock:aBlock
                                                                                       error:&stError];
   if (stError) {
      
      if (aFAILURE) {
         
         dispatch_async(self.completionQueue ?: dispatch_get_main_queue(), ^{
            
            aFAILURE(nil, stError);
         });
         
      } /*End for () */
      
      return nil;
      
   } /*End for () */
   
   if (aPrepare) {
      
      aPrepare(stRequest, self);
      
   } /* End if () */

   for (NSString *szHeaderField in aHeaders.keyEnumerator) {
      
      [stRequest setValue:aHeaders[szHeaderField] forHTTPHeaderField:szHeaderField];
      
   } /* End for () */

   __block NSURLSessionDataTask  *stDataTask = [self uploadTaskWithStreamedRequest:stRequest
                                                                          progress:aUploadProgress
                                                                 completionHandler:^(NSURLResponse * __unused aResponse, id aResponseObject, NSError *aError) {
      if (aError) {
         
         if (aFAILURE) {
            
            aFAILURE(stDataTask, aError);
            
         } /* End if () */
         
      } /* End if () */
      else {
         
         if (aSUCCESS) {
            
            aSUCCESS(stDataTask, aResponseObject);
            
         } /* End if () */
         
      } /*End else */
   }];
   
   if (aResume) {
      
      [stDataTask resume];
      
   } /* End if () */
   
   return stDataTask;
}

- (NSURLSessionDataTask *)PATCH:(NSString *)aURL
                         resume:(BOOL)aResume
                        prepare:(nullable void (^)(NSMutableURLRequest *aRequest, AFHTTPSessionManager *aSessionManager))aPrepare
                        headers:(nullable NSDictionary <NSString *, NSString *> *)aHeaders
                     parameters:(id)aParameters
                        success:(void (^)(NSURLSessionDataTask *aTask, id aResponse))aSUCCESS
                        failure:(void (^)(NSURLSessionDataTask *aTask, NSError *aError))aFAILURE {
   
   NSURLSessionDataTask *stDataTask = [self dataTaskWithHTTPMethod:@"PATCH"
                                                         URLString:aURL
                                                           prepare:aPrepare
                                                           headers:aHeaders
                                                        parameters:aParameters
                                                    uploadProgress:nil
                                                  downloadProgress:nil
                                                           success:aSUCCESS
                                                           failure:aFAILURE];
   
   if (aResume) {
      
      [stDataTask resume];
      
   } /* End if () */
   
   return stDataTask;
}

- (NSURLSessionDownloadTask *)DOWNLOAD:(NSString *)aURL
                                resume:(BOOL)aResume
                               prepare:(nullable void (^)(NSMutableURLRequest *aRequest, AFHTTPSessionManager *aSessionManager))aPrepare
                               headers:(nullable NSDictionary <NSString *, NSString *> *)aHeaders
                            parameters:(id)aPARAMETERs
                              progress:(void (^)(NSProgress *aDownloadProgress)) aDownloadProgress
                           destination:(NSURL * (^)(NSURL *aTargetPath, NSURLResponse *aResponse))aDestination
                     completionHandler:(void (^)(NSURLResponse *aResponse, NSURL *aFilePath, NSError *aError))aCompletionHandler {
   
   __block NSURLSessionDownloadTask *stDownloadTask   = nil;
   __block NSMutableURLRequest      *stRequest        = [NSMutableURLRequest requestWithURLString:aURL];
   
   for (NSString *szHeaderField in aHeaders.keyEnumerator) {
      
      [stRequest setValue:aHeaders[szHeaderField] forHTTPHeaderField:szHeaderField];
      
   } /* End for () */

   stDownloadTask = [self.session downloadTaskWithRequest:stRequest];
   
   [self addDelegateForDownloadTask:stDownloadTask
                           progress:aDownloadProgress
                        destination:aDestination
                  completionHandler:aCompletionHandler];
   
   if (aResume) {
      
      [stDownloadTask resume];
      
   } /* End if () */
   
   return stDownloadTask;
}

- (void)cancelAllOperations {
   
   [self.operationQueue cancelAllOperations];
   
   return;
}

- (NSUInteger)operationCount {
   
   return [self.operationQueue operationCount];
}

@end

#endif /* IDEAKIT_AFNETWORKING_OPERATIONS */

//#endif /* __has_include(<AFNetworking/AFNetworking.h>) */
