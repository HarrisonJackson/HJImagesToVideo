//
//  HJImagesToVideo.h
//  HJImagesToVideo
//
//  Created by Harrison Jackson on 8/4/13.
//  Copyright (c) 2013 Harrison Jackson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreVideo/CoreVideo.h>
#import <CoreFoundation/CoreFoundation.h>
#import <CoreMedia/CoreMedia.h>
#import <UIKit/UIKit.h>

@interface HJImagesToVideo : NSObject{
    
}



+(void)videoFromImages:(NSArray *)images ToPath:(NSString *)path WithCallbackBlock:(void (^)(void))callbackBlock;
+(void)videoFromImages:(NSArray *)images  ToPath:(NSString *)path withSize:(CGSize)size WithCallbackBlock:(void (^)(void))callbackBlock;
+(void)saveVideoToPhotosWithImages:(NSArray *)images WithCallbackBlock:(void (^)(void))callbackBlock;
+(void)saveVideoToPhotosWithImages:(NSArray *)images withFrame:(CGSize)size WithCallbackBlock:(void (^)(void))callbackBlock;





@end
