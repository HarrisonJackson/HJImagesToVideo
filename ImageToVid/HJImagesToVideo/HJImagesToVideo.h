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

/**
 *  Determines defaults for transitions
 */
FOUNDATION_EXPORT BOOL const DefaultTransitionShouldAnimate;

/**
 *  Determines default frame size for videos
 */
FOUNDATION_EXPORT CGSize const DefaultFrameSize;

/**
 *  Determines default FPS of video - 10 Images at 10FPS results in a 1 second video clip.
 */
FOUNDATION_EXPORT NSInteger const DefaultFrameRate;

/**
 *  Number of frames to use in transition
 */
FOUNDATION_EXPORT NSInteger const TransitionFrameCount;

/**
 *  Number of frames to hold each image before beginning alpha fade into the next
 */
FOUNDATION_EXPORT NSInteger const FramesToWaitBeforeTransition;



typedef void(^SuccessBlock)(BOOL success);


@interface HJImagesToVideo : NSObject


/**
 *  This is the main function for creating a video from a set of images
 *
 *  FPS of 1 with 10 images results in 10 second video, but not necessarily an only 10 frame video. Transitions will add frames, but maintain expected duration
 *
 *  @param images        Images to convert to video
 *  @param path          Path to write video to
 *  @param size          Frame size of image
 *  @param fps           FPS of video
 *  @param animate       Yes results in crossfade between images
 *  @param callbackBlock Block to execute when video creation completes or fails
 */
+ (void)videoFromImages:(NSArray *)images
                 toPath:(NSString *)path
               withSize:(CGSize)size
                withFPS:(int)fps
     animateTransitions:(BOOL)animate
      withCallbackBlock:(SuccessBlock)callbackBlock;

+ (void)videoFromImages:(NSArray *)images
                 toPath:(NSString *)path
                withFPS:(int)fps
     animateTransitions:(BOOL)animate
      withCallbackBlock:(SuccessBlock)callbackBlock;

+ (void)videoFromImages:(NSArray *)images
                 toPath:(NSString *)path
               withSize:(CGSize)size
     animateTransitions:(BOOL)animate
      withCallbackBlock:(SuccessBlock)callbackBlock;

+ (void)videoFromImages:(NSArray *)images
                 toPath:(NSString *)path
     animateTransitions:(BOOL)animate
      withCallbackBlock:(SuccessBlock)callbackBlock;

+ (void)videoFromImages:(NSArray *)images
                 toPath:(NSString *)path
      withCallbackBlock:(SuccessBlock)callbackBlock;

/**
 *  Convenience methods for saving to camera roll
 *
 *  @param images        Images to convert to video
 *  @param size          Frame size of image
 *  @param fps           FPS of video
 *  @param animate       Yes results in crossfade between images
 *  @param callbackBlock Block to execute when video creation completes or fails
 */
+ (void)saveVideoToPhotosWithImages:(NSArray *)images
                           withSize:(CGSize)size
                            withFPS:(int)fps
                 animateTransitions:(BOOL)animate
                  withCallbackBlock:(SuccessBlock)callbackBlock;

+ (void)saveVideoToPhotosWithImages:(NSArray *)images
                          withSize:(CGSize)size
                 animateTransitions:(BOOL)animate
                  withCallbackBlock:(SuccessBlock)callbackBlock;

+ (void)saveVideoToPhotosWithImages:(NSArray *)images
                            withFPS:(int)fps
                 animateTransitions:(BOOL)animate
                  withCallbackBlock:(SuccessBlock)callbackBlock;

+ (void)saveVideoToPhotosWithImages:(NSArray *)images
                 animateTransitions:(BOOL)animate
                  withCallbackBlock:(SuccessBlock)callbackBlock;

+ (void)saveVideoToPhotosWithImages:(NSArray *)images
                  withCallbackBlock:(SuccessBlock)callbackBlock;


@end
