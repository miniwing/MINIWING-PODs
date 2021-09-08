//
//  IDEAPingClient.m
//  IDEAPing
//
//  Created by Harry on 2021/7/28.
//
//  Mail: miniwing.hz@gmail.com
//  TEL : +(852)53054612
//

#include <netdb.h>

#import "IDEAPingClient.h"

//发送数据的间隙
#define PING_TIME_INTERVAL                         (1)

//超时时间
#define PING_TIMEOUT                               (1.5)

//发送的ping的总次数
#if __Debug__
#define kSequenceNumber                            (5)
#else /* __Debug__ */
#define kSequenceNumber                            (10)
#endif /* !__Debug__ */

#define PING_TIMEOUT_DELAY                         (1000)

typedef void (^BlockPingResult)     (NSString *aHostName, NSString *aIP, NSTimeInterval aTime, NSError *aError);
typedef void (^BlockPingCompleted)  (NSString *aHostName, NSString *aIP);

@interface IDEAPingClient () <SimplePingDelegate>

/**开始发送数据的时间*/
@property (nonatomic, assign)                BOOL                                 pinging;

@property (nonatomic, copy)                  NSString                            * ipAddress;
@property (nonatomic, strong)                NSTimer                             * timer;

@property (nonatomic, strong)                SimplePing                          * pinger;

@property (nonatomic, copy)                  BlockPingResult                       pingResult;
@property (nonatomic, copy)                  BlockPingCompleted                    pingCompleted;

/**开始发送数据的时间*/
@property (nonatomic, assign)                NSTimeInterval                        startTimeInterval;

/**消耗的时间*/
@property (nonatomic, assign)                NSTimeInterval                        delayTime;

/**接收到数据或者丢失的数据的次数*/
@property (nonatomic, assign)                NSInteger                             receivedOrDelayCount;

/**发出的数据包*/
@property (nonatomic, assign)                NSUInteger                            sendPackets;

/**收到的数据包*/
@property (nonatomic, assign)                NSUInteger                            receivePackets;

/**丢包率*/
@property (nonatomic, assign)                double                                packetLoss;

@end

@implementation IDEAPingClient

- (void)dealloc {
   
   __LOG_FUNCTION;
   
   // Custom dealloc
   [self stopPing];
   
   __RELEASE(_timer);
   __RELEASE(_pinger);
   
   __SUPER_DEALLOC;
   
   return;
}

- (instancetype)initWithHostName:(NSString *)aHostName {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   self  = [super init];
   
   if (self) {
      
      _pinger  = [[SimplePing alloc] initWithHostName:aHostName];
      
      _pinger.addressStyle = SimplePingAddressStyleAny;
      _pinger.delegate     = self;
      
      _sendPackets         = 0;
      _receivePackets      = 0;
      
      _pinging             = NO;

   } /* End if () */
   
   __CATCH(nErr);
   
   return self;
}

+ (instancetype)pingClientWithHostName:(NSString *)aHostName
                                  ping:(void (^ __nullable)(NSString *aHostName, NSString *aIP, NSTimeInterval aTime, NSError *aError))aPing
                             completed:(void (^ __nullable)(NSString *aHostName, NSString *aIP))aCompleted {
   
   int                            nErr                                     = EFAULT;
   
   IDEAPingClient                *stPingClient                             = nil;
   
   __TRY;
   
   LogDebug((@"+[IDEAPingClient pingClientWithHostName:result:] : HostName : %@", aHostName));
   
   stPingClient  = [[IDEAPingClient alloc] initWithHostName:aHostName];
      
   [stPingClient setPingResult:aPing];
   [stPingClient setPingCompleted:aCompleted];
   [stPingClient startPing];
   
   __CATCH(nErr);
   
   return stPingClient;
}

- (void)startPing {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   [self.pinger start];
   
   self.pinging   = YES;
   
   __CATCH(nErr);
   
   return;
}

- (void)stopPing {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   if (self.pingCompleted) {
      
      self.pingCompleted(self.pinger.hostName, self.ipAddress);
      __RELEASE(self.pingCompleted);

   } /* End if () */
   
   [self.pinger stop];
   __RELEASE(_pinger);

   if (nil != self.timer) {
      
      [self.timer invalidate];
      __RELEASE(_timer);
      
   } /* End if () */

   self.delayTime    = 0;
   self.packetLoss   = 0;
   
   self.pinging   = NO;

   __CATCH(nErr);
   
   return;
}

- (void)sendPingData {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   //执行到指定次数后停止时间搓
   if (self.receivedOrDelayCount == kSequenceNumber) {
      
      [self stopPing];
      
   } /* End if () */
   
   self.startTimeInterval  = [NSDate timeIntervalSinceReferenceDate];
   [self.pinger sendPingWithData:nil];
   
   //超时问题处理
   [self performSelector:@selector(pingTimeout) withObject:nil afterDelay:PING_TIMEOUT];
   
   __CATCH(nErr);
   
   return;
}

- (void)pingTimeout {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   LogDebug((@"-[IDEAPingClient pingTimeout] : ++++超时了+++"));
   
   if (self.timer) {
      
      self.receivedOrDelayCount++;
      
      self.packetLoss = (double)((self.sendPackets - self.receivePackets) * 1.f / self.sendPackets * 100);
      
      if (self.receivedOrDelayCount == kSequenceNumber) {
         
         [self stopPing];
         
      } /* End if () */
      
   } /* End if () */
   
   __CATCH(nErr);
   
   return;
}

// 取消超时
- (void)cancelTimeOut {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;

   [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(pingTimeout) object:nil];

   __CATCH(nErr);

   return;
}

/**
 * 将ping接收的数据转换成ip地址
 * @param address 接受的ping数据
 */
- (NSString *)displayIPFormAddress:(NSData *)aAddress {
   
   int                            nErr                                     = EFAULT;

   NSString                      *szHostName                               = nil;
   char                           aszHost[NI_MAXHOST]                      = {0};

   __TRY;
         
   if (aAddress != nil) {
      
      nErr = getnameinfo([aAddress bytes],
                         (socklen_t)[aAddress length],
                         aszHost,
                         sizeof(aszHost),
                         NULL,
                         0,
                         NI_NUMERICHOST);
      
      if (nErr == noErr) {
         
         szHostName = [NSString stringWithCString:aszHost encoding:NSASCIIStringEncoding];
         
         assert(szHostName != nil);
         
      } /* End if () */
      
   } /* End if () */
   
   __CATCH(nErr);
   
   return szHostName;
}

#pragma mark - Error
/*
 * 解析错误数据并翻译
 */
- (NSString *)shortErrorFromError:(NSError *)aError {
   
   int                            nErr                                     = EFAULT;
   
   NSString                      *szResult                                 = nil;
   NSNumber                      *stFailureNum                             = nil;
   int                            nFailure                                 = EFAULT;
   const char                    *cpcFailure;

   __TRY;
      
   assert(aError != nil);
      
   // Handle DNS errors as a special case.
   
   if ([[aError domain] isEqual:(NSString *)kCFErrorDomainCFNetwork] && ([aError code] == kCFHostErrorUnknown)) {
      
      stFailureNum = [[aError userInfo] objectForKey:(id)kCFGetAddrInfoFailureKey];
      
      if ([stFailureNum isKindOfClass:[NSNumber class]]) {
         
         nFailure = [stFailureNum intValue];
         
         if (nFailure != 0) {
            
            cpcFailure = gai_strerror(nFailure);
            
            if (cpcFailure != NULL) {
               
               szResult = [NSString stringWithUTF8String:cpcFailure];
               
               assert(szResult != nil);
               
            } /* End if () */
            
         } /* End if () */
         
      } /* End if () */
      
   } /* End if () */
   
   // Otherwise try various properties of the error object.
   
   if (szResult == nil) {
      
      szResult = [aError localizedFailureReason];
      
   } /* End if () */
   
   if (szResult == nil) {
      
      szResult = [aError localizedDescription];
      
   } /* End if () */
   
   if (szResult == nil) {
      
      szResult = [aError description];
      
   } /* End if () */
   
   assert(szResult != nil);
   
   __CATCH(nErr);
   
   return szResult;
}

#pragma mark - <SimplePingDelegate>
- (void)simplePing:(SimplePing *)aPinger didStartWithAddress:(NSData *)aAddress {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   self.ipAddress = [self displayIPFormAddress:aAddress];

   LogDebug((@"-[IDEAPingClient simplePing:didStartWithAddress:] : IP : %@", self.ipAddress));

   @weakify(self);
   self.timer = [NSTimer scheduledTimerWithTimeInterval:PING_TIME_INTERVAL repeats:YES block:^(NSTimer * _Nonnull timer) {
      
      @strongify(self);
      [self sendPingData];
   }];
      
   __CATCH(nErr);
   
   return;
}

- (void)simplePing:(SimplePing *)aPinger didFailWithError:(NSError *)aError {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;

#if __Debug__
   NSString *szError = [NSString stringWithFormat:@"#%ld try create failed: %@", self.receivedOrDelayCount, [self shortErrorFromError:aError]];
   
   LogError((@"[IDEAPingClient didFailWithError:] : %@", szError));
#endif /* __Debug__ */

   if (nil != self.pingResult) {
      
      self.pingResult(aPinger.hostName, self.ipAddress, 0, aError);
      
   } /* End if () */
   
   __CATCH(nErr);
   
   return;
}

- (void)simplePing:(SimplePing *)aPinger didSendPacket:(NSData *)aPacket sequenceNumber:(uint16_t)aSequenceNumber {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;

   self.sendPackets++;
   [self cancelTimeOut];

   __CATCH(nErr);
   
   return;
}

- (void)simplePing:(SimplePing *)aPinger didFailToSendPacket:(NSData *)aPacket sequenceNumber:(uint16_t)aSequenceNumber error:(NSError *)aError {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   self.receivedOrDelayCount++;
   [self cancelTimeOut];
   
#if __Debug__
   NSString *szError = [NSString stringWithFormat:@"#%u send failed: %@", aSequenceNumber, [self shortErrorFromError:aError]];
   LogError((@"[IDEAPingClient didFailToSendPacket:sequenceNumber:error:] : %@", szError));
#endif /* __Debug__ */

   if (nil != self.pingResult) {
      
      self.pingResult(aPinger.hostName, self.ipAddress, 0, aError);
      
   } /* End if () */
   
   __CATCH(nErr);
   
   return;
}

- (void)simplePing:(SimplePing *)aPinger didReceivePingResponsePacket:(NSData *)aPacket sequenceNumber:(uint16_t)aSequenceNumber {
   
   int                            nErr                                     = EFAULT;
   
   NSTimeInterval                 dLatency                                 = 0;
   
   __TRY;
   
   self.receivedOrDelayCount++;
   [self cancelTimeOut];
   
   self.receivePackets++;
   
   self.packetLoss   = (double)((self.sendPackets - self.receivePackets) * 1.0f / self.sendPackets * 100);
   self.delayTime    = ([NSDate timeIntervalSinceReferenceDate] - self.startTimeInterval) * 1000;
         
   if (nil != self.pingResult) {
      
      self.pingResult(aPinger.hostName, self.ipAddress, self.delayTime, nil);
      
   } /* End if () */
   
   if (self.receivedOrDelayCount == kSequenceNumber) {
      
      [self stopPing];
      
   } /* End if () */
   
   LogDebug((@"ip:%@  #%u received, size=%zu time=%f loss=%f", self.ipAddress, aSequenceNumber, aPacket.length, self.delayTime, self.packetLoss));

   __CATCH(nErr);
   
   return;
}

- (void)simplePing:(SimplePing *)aPinger didReceiveUnexpectedPacket:(NSData *)aPacket {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;
   
//   [aPinger stop];
//
//   if (nil != self.pingResult) {
//
//      self.pingResult(0, [NSError  errorWithDomain:@"SimplePing"
//                                              code:-1
//                                          userInfo:nil]);
//
//   } /* End if () */
   
   __CATCH(nErr);
   
   return;
}

- (BOOL)isPinging {
   
   return _pinging;
}

@end
