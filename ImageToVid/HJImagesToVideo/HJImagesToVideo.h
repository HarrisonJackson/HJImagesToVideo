//
//  HJImagesToVideo.h
//  HJImagesToVideo
//
//  Created by Harrison Jackson on 8/4/13.
//  Copyright (c) 2013 Harrison Jackson. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <CoreVideo/CoreVideo.h>
#import <CoreFoundation/CoreFoundation.h>
#import <CoreMedia/CoreMedia.h>
#import <AssetsLibrary/AssetsLibrary.h>


FOUNDATION_EXPORT CGSize DefaultFrameSize;
FOUNDATION_EXPORT NSInteger DefaultFrameRate;

typedef void(^SuccessBlock)(BOOL success);


@interface HJImagesToVideo : NSObject


+ (void)videoFromImages:(NSArray *)images
                 toPath:(NSString *)path
      withCallbackBlock:(SuccessBlock)callbackBlock;

+ (void)videoFromImages:(NSArray *)images
                 toPath:(NSString *)path
                withFPS:(int)fps
      withCallbackBlock:(SuccessBlock)callbackBlock;

+ (void)videoFromImages:(NSArray *)images
                 toPath:(NSString *)path
               withSize:(CGSize)size
      withCallbackBlock:(SuccessBlock)callbackBlock;

+ (void)videoFromImages:(NSArray *)images
                 toPath:(NSString *)path
               withSize:(CGSize)size
                withFPS:(int)fps
      withCallbackBlock:(SuccessBlock)callbackBlock;

//Convienience methods for saving to Camera Roll

+ (void)saveVideoToPhotosWithImages:(NSArray *)images
                  withCallbackBlock:(SuccessBlock)callbackBlock;

+ (void)saveVideoToPhotosWithImages:(NSArray *)images
                          withSize:(CGSize)size
                  withCallbackBlock:(SuccessBlock)callbackBlock;

+ (void)saveVideoToPhotosWithImages:(NSArray *)images
                            withFPS:(int)fps
                  withCallbackBlock:(SuccessBlock)callbackBlock;

+ (void)saveVideoToPhotosWithImages:(NSArray *)images
                          withSize:(CGSize)size
                            withFPS:(int)fps
                  withCallbackBlock:(SuccessBlock)callbackBlock;


@end
