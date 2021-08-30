//
//  UIImage+Effects.m
//  IDEAKit
//
//  Created by Harry on 16/5/7.
//  Copyright © 2016年 Harry. All rights reserved.
//

#import "UIImage+Effects.h"

#import <Accelerate/Accelerate.h>
#import <AVFoundation/AVFoundation.h>
#import <float.h>

#ifndef __SCREEN_WIDTH
#  define __SCREEN_WIDTH                                                [[UIScreen mainScreen] bounds].size.width
#endif /* __SCREEN_WIDTH */

#ifndef __SCREEN_HEIGHT
#  define __SCREEN_HEIGHT                                               [[UIScreen mainScreen] bounds].size.height
#endif /* __SCREEN_HEIGHT */

@implementation UIImage (ImageEffects)

- (UIImage *)applyLightEffect {
   
   UIColor *tintColor = [UIColor colorWithWhite:1.0 alpha:0.3];
   return [self applyBlurWithRadius:30 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
}

- (UIImage *)applyExtraLightEffect {
   
   UIColor *tintColor = [UIColor colorWithWhite:0.97 alpha:0.82];
   return [self applyBlurWithRadius:20 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
}

- (UIImage *)applyDarkEffect {
   
   UIColor *tintColor = [UIColor colorWithWhite:0.11 alpha:0.73];
   return [self applyBlurWithRadius:20 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
}

- (UIImage *)applyTintEffectWithColor:(UIColor *)tintColor {
   
   const CGFloat EffectColorAlpha = 0.6;
   UIColor *effectColor = tintColor;
   int componentCount = CGColorGetNumberOfComponents(tintColor.CGColor);
   if (componentCount == 2) {
      CGFloat b;
      if ([tintColor getWhite:&b alpha:NULL]) {
         effectColor = [UIColor colorWithWhite:b alpha:EffectColorAlpha];
      }
   }
   else {
      CGFloat r, g, b;
      if ([tintColor getRed:&r green:&g blue:&b alpha:NULL]) {
         effectColor = [UIColor colorWithRed:r green:g blue:b alpha:EffectColorAlpha];
      }
   }
   return [self applyBlurWithRadius:10 tintColor:effectColor saturationDeltaFactor:-1.0 maskImage:nil];
}

- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage {
   
   // Check pre-conditions.
   if (self.size.width < 1 || self.size.height < 1) {
      LogDebug((@"*** error: invalid size: (%.2f x %.2f). Both dimensions must be >= 1: %@", self.size.width, self.size.height, self));
      return nil;
   }
   if (!self.CGImage) {
      LogDebug((@"*** error: image must be backed by a CGImage: %@", self));
      return nil;
   }
   if (maskImage && !maskImage.CGImage) {
      LogDebug((@"*** error: maskImage must be backed by a CGImage: %@", maskImage));
      return nil;
   }
   
   CGRect imageRect = { CGPointZero, self.size };
   UIImage *effectImage = self;
   
   BOOL hasBlur = blurRadius > __FLT_EPSILON__;
   BOOL hasSaturationChange = fabs(saturationDeltaFactor - 1.) > __FLT_EPSILON__;
   if (hasBlur || hasSaturationChange) {
      UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
      CGContextRef effectInContext = UIGraphicsGetCurrentContext();
      CGContextScaleCTM(effectInContext, 1.0, -1.0);
      CGContextTranslateCTM(effectInContext, 0, -self.size.height);
      CGContextDrawImage(effectInContext, imageRect, self.CGImage);
      
      vImage_Buffer effectInBuffer;
      effectInBuffer.data     = CGBitmapContextGetData(effectInContext);
      effectInBuffer.width    = CGBitmapContextGetWidth(effectInContext);
      effectInBuffer.height   = CGBitmapContextGetHeight(effectInContext);
      effectInBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectInContext);
      
      UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
      CGContextRef effectOutContext = UIGraphicsGetCurrentContext();
      vImage_Buffer effectOutBuffer;
      effectOutBuffer.data     = CGBitmapContextGetData(effectOutContext);
      effectOutBuffer.width    = CGBitmapContextGetWidth(effectOutContext);
      effectOutBuffer.height   = CGBitmapContextGetHeight(effectOutContext);
      effectOutBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectOutContext);
      
      if (hasBlur) {
         // A description of how to compute the box kernel width from the Gaussian
         // radius (aka standard deviation) appears in the SVG spec:
         // http://www.w3.org/TR/SVG/filters.html#feGaussianBlurElement
         //
         // For larger values of 's' (s >= 2.0), an approximation can be used: Three
         // successive box-blurs build a piece-wise quadratic convolution kernel, which
         // approximates the Gaussian kernel to within roughly 3%.
         //
         // let d = floor(s * 3*sqrt(2*pi)/4 + 0.5)
         //
         // ... if d is odd, use three box-blurs of size 'd', centered on the output pixel.
         //
         CGFloat inputRadius = blurRadius * [[UIScreen mainScreen] scale];
         NSUInteger radius = floor(inputRadius * 3. * sqrt(2 * M_PI) / 4 + 0.5);
         if (radius % 2 != 1) {
            radius += 1; // force radius to be odd so that the three box-blur methodology works.
         }
         vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
         vImageBoxConvolve_ARGB8888(&effectOutBuffer, &effectInBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
         vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
      }
      BOOL effectImageBuffersAreSwapped = NO;
      if (hasSaturationChange) {
         CGFloat s = saturationDeltaFactor;
         CGFloat floatingPointSaturationMatrix[] = {
            0.0722 + 0.9278 * s,  0.0722 - 0.0722 * s,  0.0722 - 0.0722 * s,  0,
            0.7152 - 0.7152 * s,  0.7152 + 0.2848 * s,  0.7152 - 0.7152 * s,  0,
            0.2126 - 0.2126 * s,  0.2126 - 0.2126 * s,  0.2126 + 0.7873 * s,  0,
            0,                    0,                    0,  1,
         };
         const int32_t divisor = 256;
         NSUInteger matrixSize = sizeof(floatingPointSaturationMatrix)/sizeof(floatingPointSaturationMatrix[0]);
         int16_t saturationMatrix[matrixSize];
         for (NSUInteger i = 0; i < matrixSize; ++i) {
            saturationMatrix[i] = (int16_t)roundf(floatingPointSaturationMatrix[i] * divisor);
         }
         if (hasBlur) {
            vImageMatrixMultiply_ARGB8888(&effectOutBuffer, &effectInBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
            effectImageBuffersAreSwapped = YES;
         }
         else {
            vImageMatrixMultiply_ARGB8888(&effectInBuffer, &effectOutBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
         }
      }
      if (!effectImageBuffersAreSwapped)
         effectImage = UIGraphicsGetImageFromCurrentImageContext();
      UIGraphicsEndImageContext();
      
      if (effectImageBuffersAreSwapped)
         effectImage = UIGraphicsGetImageFromCurrentImageContext();
      UIGraphicsEndImageContext();
   }
   
   // Set up output context.
   UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
   CGContextRef outputContext = UIGraphicsGetCurrentContext();
   CGContextScaleCTM(outputContext, 1.0, -1.0);
   CGContextTranslateCTM(outputContext, 0, -self.size.height);
   
   // Draw base image.
   CGContextDrawImage(outputContext, imageRect, self.CGImage);
   
   // Draw effect image.
   if (hasBlur) {
      CGContextSaveGState(outputContext);
      if (maskImage) {
         CGContextClipToMask(outputContext, imageRect, maskImage.CGImage);
      }
      CGContextDrawImage(outputContext, imageRect, effectImage.CGImage);
      CGContextRestoreGState(outputContext);
   }
   
   // Add in color tint.
   if (tintColor) {
      CGContextSaveGState(outputContext);
      CGContextSetFillColorWithColor(outputContext, tintColor.CGColor);
      CGContextFillRect(outputContext, imageRect);
      CGContextRestoreGState(outputContext);
   }
   
   // Output image is ready.
   UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
   UIGraphicsEndImageContext();
   
   return outputImage;
}

+ (UIImage*)imageOfPixelWithColor:(UIColor *)color {
   
   UIImage * pixel = nil;
   CGFloat offset = 5.0f;
   UIGraphicsBeginImageContextWithOptions(CGSizeMake(offset, offset), NO, 0.0f);
   CGContextRef ctx = UIGraphicsGetCurrentContext();
   
   CGContextSetFillColorWithColor(ctx, [color CGColor]);
   CGContextAddRect(ctx, CGRectMake(0, 0, offset, offset));
   CGContextClosePath(ctx);
   CGContextDrawPath(ctx, kCGPathFill);
   
   pixel = UIGraphicsGetImageFromCurrentImageContext();
   UIGraphicsEndImageContext();
   return pixel;
}

+ (UIImage*)imageOfPixelWithColor:(UIColor *)color size:(CGSize)size {
   
   UIImage * pixel = nil;
   UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
   CGContextRef ctx = UIGraphicsGetCurrentContext();
   
   CGContextSetFillColorWithColor(ctx, [color CGColor]);
   CGContextAddRect(ctx, CGRectMake(0, 0, size.width, size.height));
   CGContextClosePath(ctx);
   CGContextDrawPath(ctx, kCGPathFill);
   
   pixel = UIGraphicsGetImageFromCurrentImageContext();
   UIGraphicsEndImageContext();
   return pixel;
}

+ (UIImage*) imageOfPixelWithUpCircleColor:(UIColor*)color size:(CGSize)size {
   
   UIImage * pixel = nil;
   
   UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
   CGContextRef ctx = UIGraphicsGetCurrentContext();
   UIImage *image = [UIImage imageNamed:@"story-slide"];
   CGContextDrawImage(ctx, CGRectMake(0, 0, size.width, size.height), image.CGImage);
   pixel = UIGraphicsGetImageFromCurrentImageContext();
   UIGraphicsEndImageContext();
   
   return pixel;
}

+ (UIImage *)imageOfPixelWithColor:(UIColor *)color size:(CGSize)size cornerRadius:(CGFloat)radius {
   
   UIImage * pixel = nil;
   UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
   CGContextRef ctx = UIGraphicsGetCurrentContext();
   
   CGContextSetFillColorWithColor(ctx, [color CGColor]);
   //    CGContextAddRect(ctx, CGRectMake(0, 0, size.width, size.height));
   UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width, size.height) cornerRadius:radius];
   CGContextAddPath(ctx, path.CGPath);
   CGContextClosePath(ctx);
   CGContextDrawPath(ctx, kCGPathFill);
   
   pixel = UIGraphicsGetImageFromCurrentImageContext();
   UIGraphicsEndImageContext();
   return pixel;
}

- (UIImage *)imageRenderWithTintColor:(UIColor *)tintColor {
   
//   if (@available(iOS 13.0, *)) {
//
//      return [self imageWithTintColor:tintColor];
//
//   } /* End if () */
//   else {
//
//      return [self imageWithTintColor:tintColor blendMode:kCGBlendModeDestinationIn];
//
//   } /* End else */

   return [self imageWithTintColor:tintColor blendMode:kCGBlendModeDestinationIn];
}

- (UIImage *) imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode {
   //We want to keep alpha, set opaque to NO; Use 0.0f for scale to use the scale factor of the device’s main screen.
   UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
   [tintColor setFill];
   CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
   UIRectFill(bounds);
   
   
   if (blendMode != kCGBlendModeDestinationIn) {
      
      [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
   }
   else {
      
      //Draw the tinted image in context
      [self drawInRect:bounds blendMode:blendMode alpha:1.0f];
   }
   
   UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
   UIGraphicsEndImageContext();
   
   return tintedImage;
}

- (UIImage *) imageWithGradientTintColor:(UIColor *)tintColor {
   return [self imageWithTintColor:tintColor blendMode:kCGBlendModeOverlay];
}

+ (UIImage *)imageWithCenterText:(NSString *)text textColor:(UIColor *)textColor size:(CGSize)size {
   UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
   CGSize isize = [text boundingRectWithSize:CGSizeMake(size.width, CGFLOAT_MAX)
                                     options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:size.height*0.5f]}
                                     context:nil].size;
   CGFloat left = (size.width-isize.width)*0.5f, top = (size.height-isize.height)*0.5f;
   [text drawInRect:CGRectMake(left, top, isize.width, isize.height) withAttributes:@{NSForegroundColorAttributeName:textColor?textColor:[UIColor blackColor], NSFontAttributeName:[UIFont systemFontOfSize:size.height*0.5f]}];
   UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
   UIGraphicsEndImageContext();
   return image;
}

- (NSData *)imageRepresentData {
   NSData *data=UIImageJPEGRepresentation(self, 1.0);
   if (data.length > 100 * 1024) {
      if (data.length > 1024 * 1024) { // 1M以及以上
         
         data=UIImageJPEGRepresentation(self, 0.1);
      }
      else if (data.length > 512 * 1024) { // 0.5M-1M
         
         data=UIImageJPEGRepresentation(self, 0.5);
      }
      else if (data.length > 200 * 1024) { // 0.25M-0.5M
         
         data=UIImageJPEGRepresentation(self, 0.9);
      }
   }
   return data;
}

- (UIImage *)imageWithCircle:(UIColor *)color {
   UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
   CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
   CGContextRef context = UIGraphicsGetCurrentContext();
   
   UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:bounds cornerRadius:self.size.height*0.5f];
   CGContextAddPath(context, [path CGPath]);
   
   CGContextSetFillColorWithColor(context, [color CGColor]);
   CGContextClosePath(context);
   CGContextDrawPath(context, kCGPathFill);
   
   [self drawInRect:bounds];
   
   UIImage * pixel = UIGraphicsGetImageFromCurrentImageContext();
   UIGraphicsEndImageContext();
   return pixel;
}

- (UIImage *)imageWithBorderCircle:(UIColor *)color offset:(CGFloat)offset {
   CGRect bounds = CGRectMake(0, 0, self.size.width+offset, self.size.height+offset);
   UIGraphicsBeginImageContextWithOptions(bounds.size, NO, [[UIScreen mainScreen] scale]);
   CGContextRef context = UIGraphicsGetCurrentContext();
   
   UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:bounds cornerRadius:bounds.size.height*0.5f-1];
   CGContextAddPath(context, [path CGPath]);
   
   CGContextSetStrokeColorWithColor(context, [color CGColor]);
   CGContextSetLineWidth(context, 1.0f);
   CGContextClosePath(context);
   CGContextDrawPath(context, kCGPathStroke);
   
   [self drawInRect:bounds];
   
   UIImage * pixel = UIGraphicsGetImageFromCurrentImageContext();
   UIGraphicsEndImageContext();
   return pixel;
}

- (UIImage *)imageWithRect:(UIColor *)color {
   UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
   CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
   CGContextRef context = UIGraphicsGetCurrentContext();
   
   CGContextSetFillColorWithColor(context, [color CGColor]);
   CGContextAddRect(context, bounds);
   CGContextClosePath(context);
   CGContextDrawPath(context, kCGPathFill);
   
   [self drawInRect:bounds];
   
   UIImage * pixel = UIGraphicsGetImageFromCurrentImageContext();
   UIGraphicsEndImageContext();
   return pixel;
}

- (UIImage *)imageInsertWithSize:(CGSize)size backgroundColor:(UIColor *)color {
   UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
   CGRect bounds = CGRectMake(0, 0, size.width, size.height);
   CGContextRef context = UIGraphicsGetCurrentContext();
   
   CGContextSetStrokeColorWithColor(context, [color CGColor]);
   CGContextAddRect(context, bounds);
   CGContextClosePath(context);
   CGContextDrawPath(context, kCGPathStroke);
   
   [self drawInRect:CGRectMake((size.width-self.size.width)*0.5f, (size.height-self.size.height)*0.5f, self.size.width, self.size.height)];
   
   UIImage * pixel = UIGraphicsGetImageFromCurrentImageContext();
   UIGraphicsEndImageContext();
   return pixel;
}

- (UIImage *)imageInsertCircleWithSize:(CGSize)size backgroundColor:(UIColor *)color {
   UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
   CGRect bounds = CGRectMake(0, 0, size.width, size.height);
   CGContextRef context = UIGraphicsGetCurrentContext();
   
   UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:bounds cornerRadius:size.height*0.5f];
   CGContextAddPath(context, [path CGPath]);
   
   CGContextSetFillColorWithColor(context, [color CGColor]);
   CGContextClosePath(context);
   CGContextDrawPath(context, kCGPathFill);
   
   [self drawInRect:CGRectMake((size.width-self.size.width)*0.5f, (size.height-self.size.height)*0.5f, self.size.width, self.size.height)];
   
   UIImage * pixel = UIGraphicsGetImageFromCurrentImageContext();
   UIGraphicsEndImageContext();
   return pixel;
}

+ (UIImage *)imageSudokuWithImages:(NSArray<UIImage *> *)images backgroundColor:(UIColor *)backgroundColor {
   UIImage * image = [images firstObject];
   CGSize size = image.size;
   CGFloat space = 5.0f, width = size.width-space*2, dimmer = width/3.0f, left = space, top = space;
   UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
   CGContextRef ctx = UIGraphicsGetCurrentContext();
   
   CGContextSetFillColorWithColor(ctx, [backgroundColor CGColor]);
   CGContextAddRect(ctx, CGRectMake(space, space, width, size.height-space*2));
   CGContextClosePath(ctx);
   CGContextDrawPath(ctx, kCGPathFill);
   
   for (NSInteger idx = 0; idx < images.count; idx++) {
      UIImage * image = [images objectAtIndex:idx];
      [image drawInRect:CGRectMake(left, top, dimmer, dimmer)];
      if ((idx+1)%3==0) {
         left = space;
         top += dimmer;
      } else {
         left += dimmer;
      }
   }
   
   UIImage * pixel = UIGraphicsGetImageFromCurrentImageContext();
   UIGraphicsEndImageContext();
   return pixel;
}

+ (UIImage *)imageAddShapeWithColor:(UIColor *)color size:(CGSize)size {
   CGFloat space = size.width*0.1f;
   UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
   CGContextRef ctx = UIGraphicsGetCurrentContext();
   
   UIBezierPath * outline = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, size.width, size.height)];
   UIBezierPath * cross1 = [UIBezierPath bezierPath];
   [cross1 moveToPoint:CGPointMake(space, size.height*0.5f)];
   [cross1 addLineToPoint:CGPointMake(size.width-space, size.height*0.5f)];
   UIBezierPath * cross2 = [UIBezierPath bezierPath];
   [cross2 moveToPoint:CGPointMake(size.width*0.5f, space)];
   [cross2 addLineToPoint:CGPointMake(size.width*0.5f, size.height-space)];
   
   [outline appendPath:cross1];
   [outline appendPath:cross2];
   
   CGContextAddPath(ctx, [outline CGPath]);
   
   CGContextSetStrokeColorWithColor(ctx, [color CGColor]);
   CGContextClosePath(ctx);
   CGContextDrawPath(ctx, kCGPathStroke);
   
   UIImage * pixel = UIGraphicsGetImageFromCurrentImageContext();
   UIGraphicsEndImageContext();
   return pixel;
}

- (UIImage *)imageRotation:(UIImageOrientation)orientation {
   long double rotate = 0.0;
   CGRect rect;
   float translateX =0;
   float translateY =0;
   float scaleX =1.0;
   float scaleY =1.0;
   switch (orientation) {
      case UIImageOrientationLeft:
         rotate =M_PI_2;
         rect =CGRectMake(0,0, self.size.height, self.size.width);
         translateX =0;
         translateY = -rect.size.width;
         scaleY = rect.size.width/rect.size.height;
         scaleX = rect.size.height/rect.size.width;
         break;
      case UIImageOrientationRight:
         rotate =3 * M_PI_2;
         rect =CGRectMake(0,0, self.size.height, self.size.width);
         translateX = -rect.size.height;
         translateY =0;
         scaleY = rect.size.width/rect.size.height;
         scaleX = rect.size.height/rect.size.width;
         break;
      case UIImageOrientationDown:
         rotate =M_PI;
         rect =CGRectMake(0,0, self.size.width, self.size.height);
         translateX = -rect.size.width;
         translateY = -rect.size.height;
         break;
      default:
         rotate =0.0;
         rect =CGRectMake(0,0, self.size.width, self.size.height);
         translateX =0;
         translateY =0;
         break;
   }
   UIGraphicsBeginImageContext(rect.size);
   CGContextRef context =UIGraphicsGetCurrentContext();
   CGContextTranslateCTM(context,0.0, rect.size.height);
   CGContextScaleCTM(context,1.0, -1.0);
   CGContextRotateCTM(context, rotate);
   CGContextTranslateCTM(context, translateX, translateY);
   CGContextScaleCTM(context, scaleX, scaleY);
   CGContextDrawImage(context,CGRectMake(0,0, rect.size.width, rect.size.height), self.CGImage);
   UIImage *pic =UIGraphicsGetImageFromCurrentImageContext();
   return pic;
}

+ (UIImage *)imageUsingUrl:(AVURLAsset *)urlAsset {
   AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:urlAsset];
   gen.appliesPreferredTrackTransform = YES;
   CMTime time = CMTimeMakeWithSeconds(0.0, 600);
   NSError *error = nil;
   CMTime actualTime;
   CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
   UIImage *thumb = [[UIImage alloc] initWithCGImage:image];
   CGImageRelease(image);
   return thumb;
}

- (UIImage *)scaleImageUsingSize:(CGSize)size {
   UIGraphicsBeginImageContext(size);
   [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
   UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
   UIGraphicsEndImageContext();
   return scaledImage;
}

- (UIColor *)colorAtPoint:(CGPoint)point {
   if (!CGRectContainsPoint(CGRectMake(0.0f, 0.0f, self.size.width, self.size.height), point)) {
      return nil;
   }
   
   NSInteger pointX = trunc(point.x);
   NSInteger pointY = trunc(point.y);
   CGImageRef cgImage = self.CGImage;
   NSUInteger width = self.size.width;
   NSUInteger height = self.size.height;
   CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
   int bytesPerPixel = 4;
   int bytesPerRow = bytesPerPixel * 1;
   NSUInteger bitsPerComponent = 8;
   unsigned char pixelData[4] = { 0, 0, 0, 0 };
   CGContextRef context = CGBitmapContextCreate(pixelData, 1, 1, bitsPerComponent, bytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
   CGColorSpaceRelease(colorSpace);
   CGContextSetBlendMode(context, kCGBlendModeCopy);
   
   // Draw the pixel we are interested in onto the bitmap context
   
   CGContextTranslateCTM(context, -pointX, pointY-(CGFloat)height);
   CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, (CGFloat)width, (CGFloat)height), cgImage);
   CGContextRelease(context);
   
   // Convert color values [0..255] to floats [0.0..1.0]
   CGFloat red   = (CGFloat)pixelData[0] / 255.0f;
   CGFloat green = (CGFloat)pixelData[1] / 255.0f;
   CGFloat blue  = (CGFloat)pixelData[2] / 255.0f;
   CGFloat alpha = (CGFloat)pixelData[3] / 255.0f;
   
   NSLog(@"rgba:%f,%f,%f,%f", red, green, blue, alpha);
   
   return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (UIImage *)bundleImageWithName:(NSString *)name bundle:(NSString *)bundle {
   NSString *bundlePath = [[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:bundle.length?bundle:@"MobileRTCResources.bundle"];
   NSBundle *bundleFile = [NSBundle bundleWithPath:bundlePath];
   NSString *imagePath = [bundleFile pathForResource:name ofType:@"png"];
   return [UIImage imageWithContentsOfFile:imagePath];
}

+ (UIImage *)imageOfLineGradient:(NSArray*)colors {
   UIImage * pixel = nil;
   UIGraphicsBeginImageContextWithOptions(CGSizeMake(__SCREEN_WIDTH, 64.0f), NO, 0.0f);
   CGContextRef ctx = UIGraphicsGetCurrentContext();
   
   CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
   CGFloat locations[2] = {0.0,1.0};
   CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)colors, locations);
   CGContextDrawLinearGradient(ctx, gradient, CGPointZero, CGPointMake(__SCREEN_WIDTH, 64.0f), kCGGradientDrawsAfterEndLocation);
   CGColorSpaceRelease(colorSpace);
   CGGradientRelease(gradient);
   
   pixel = UIGraphicsGetImageFromCurrentImageContext();
   UIGraphicsEndImageContext();
   return pixel;
}

+ (UIImage *)imageOfLineGradient:(NSArray *)colors topColor:(UIColor *)color height:(CGFloat)height {
   UIImage * gradient = [self imageOfLineGradient:colors];
   UIImage * line = [self imageOfPixelWithColor:color size:CGSizeMake(__SCREEN_WIDTH, height)];
   UIImage * pixel = nil;
   UIGraphicsBeginImageContextWithOptions(CGSizeMake(__SCREEN_WIDTH, 64.0f), NO, [[UIScreen mainScreen] scale]);
   
   [line drawInRect:CGRectMake(0, 0, __SCREEN_WIDTH, height)];
   [gradient drawInRect:CGRectMake(0, height, __SCREEN_WIDTH, 64-height)];
   
   pixel = UIGraphicsGetImageFromCurrentImageContext();
   UIGraphicsEndImageContext();
   return pixel;
}

+ (NSArray<UIImage *> *)anmatedImagesFromData:(NSData *)data {
   if (!data) {
      return nil;
   }
   
   CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
   
   size_t count = CGImageSourceGetCount(source);
   
   NSMutableArray<UIImage*> * gif = [NSMutableArray array];
   
   if (count <= 1) {
      [gif addObject:[[UIImage alloc] initWithData:data]];
   } else {
      CGFloat scale = [UIScreen mainScreen].scale;
      
      for (size_t i = 0; i < count; i++) {
         CGImageRef CGImage = CGImageSourceCreateImageAtIndex(source, i, NULL);
         UIImage * frameImage = [UIImage imageWithCGImage:CGImage scale:scale orientation:UIImageOrientationUp];
         [gif addObject:frameImage];
         CGImageRelease(CGImage);
      }
   }
   
   CFRelease(source);
   return gif;
}

@end
