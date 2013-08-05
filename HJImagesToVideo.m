//
//  HJImagesToVideo.m
//  HJImagesToVideo
//
//  Created by Harrison Jackson on 8/4/13.
//  Copyright (c) 2013 Harrison Jackson. All rights reserved.
//

#import "HJImagesToVideo.h"

@implementation HJImagesToVideo

+(void)videoFromImages:(NSArray *)images ToPath:(NSString *)path WithFPS:(int)fps WithCallbackBlock:(void (^)(void))callbackBlock{
    [HJImagesToVideo writeImageAsMovie:images toPath:path size:CGSizeMake(480, 320) fps:fps];
    
    
    callbackBlock();
}
+(void)videoFromImages:(NSArray *)images  ToPath:(NSString *)path withSize:(CGSize)size WithFPS:(int)fps WithCallbackBlock:(void (^)(void))callbackBlock{
    [HJImagesToVideo writeImageAsMovie:images toPath:path size:size fps:fps];
    
    callbackBlock();
}
+(void)saveVideoToPhotosWithImages:(NSArray *)images WithCallbackBlock:(void (^)(void))callbackBlock{
    NSString *tempPath = [NSHomeDirectory() stringByAppendingPathComponent:
                      [NSString stringWithFormat:@"temp.mp4"]];
    [[NSFileManager defaultManager] removeItemAtPath:tempPath error:NULL];

    [HJImagesToVideo videoFromImages:images ToPath:tempPath WithFPS:10 WithCallbackBlock:^{
        UISaveVideoAtPathToSavedPhotosAlbum(tempPath, self, nil, nil);
        callbackBlock();
    }];
    
}
+(void)saveVideoToPhotosWithImages:(NSArray *)images withSize:(CGSize)size WithCallbackBlock:(void (^)(void))callbackBlock{
    NSString *tempPath = [NSHomeDirectory() stringByAppendingPathComponent:
                          [NSString stringWithFormat:@"temp.mp4"]];
    [[NSFileManager defaultManager] removeItemAtPath:tempPath error:NULL];

    [HJImagesToVideo videoFromImages:images ToPath:tempPath withSize:size WithFPS:10 WithCallbackBlock:^{
        UISaveVideoAtPathToSavedPhotosAlbum(tempPath, self, nil, nil);
        callbackBlock();
    }];
    
    callbackBlock();
    
}

+ (void)test
{
    // Modify this array to use your test images 
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:
                      [NSString stringWithFormat:@"Documents/movie.mp4"]];
    NSArray * testImageArray = [[NSArray alloc] initWithObjects:
                                [UIImage imageNamed:@"frame1.png"],
                                [UIImage imageNamed:@"frame2.png"],
                                [UIImage imageNamed:@"frame3.png"],
                                [UIImage imageNamed:@"frame4.png"],
                                [UIImage imageNamed:@"frame5.png"],
                                [UIImage imageNamed:@"frame6.png"],
                                [UIImage imageNamed:@"frame7.png"],
                                [UIImage imageNamed:@"frame8.png"],
                                [UIImage imageNamed:@"frame9.png"], nil];
    
    [[NSFileManager defaultManager] removeItemAtPath:path error:NULL];
    [HJImagesToVideo videoFromImages:testImageArray ToPath:path WithFPS:10 WithCallbackBlock:^{
        NSLog(@"Success");
        
    }];

}


+(void)writeImageAsMovie:(NSArray *)array toPath:(NSString*)path size:(CGSize)size fps:(int)fps
{
    NSLog(@"%@", path);
    NSError *error = nil;
    AVAssetWriter *videoWriter = [[AVAssetWriter alloc] initWithURL:[NSURL fileURLWithPath:path]
                                                           fileType:AVFileTypeMPEG4
                                                              error:&error];
    NSParameterAssert(videoWriter);
    
    NSDictionary *videoSettings = [NSDictionary dictionaryWithObjectsAndKeys:
                                   AVVideoCodecH264, AVVideoCodecKey,
                                   [NSNumber numberWithInt:size.width], AVVideoWidthKey,
                                   [NSNumber numberWithInt:size.height], AVVideoHeightKey,
                                   nil];
    AVAssetWriterInput* writerInput = [AVAssetWriterInput assetWriterInputWithMediaType:AVMediaTypeVideo
                                                                         outputSettings:videoSettings];
    
    AVAssetWriterInputPixelBufferAdaptor *adaptor = [AVAssetWriterInputPixelBufferAdaptor assetWriterInputPixelBufferAdaptorWithAssetWriterInput:writerInput
                                                                                                                     sourcePixelBufferAttributes:nil];
    NSParameterAssert(writerInput);
    NSParameterAssert([videoWriter canAddInput:writerInput]);
    [videoWriter addInput:writerInput];
    
    
    //Start a session:
    [videoWriter startWriting];
    [videoWriter startSessionAtSourceTime:kCMTimeZero];
    
    CVPixelBufferRef buffer = NULL;
    buffer = [HJImagesToVideo pixelBufferFromCGImage:[[array objectAtIndex:0] CGImage] size:CGSizeMake(480, 320)];
    CVPixelBufferPoolCreatePixelBuffer (NULL, adaptor.pixelBufferPool, &buffer);
    
    //[adaptor appendPixelBuffer:buffer withPresentationTime:kCMTimeZero];
    int i = 0;
    while (1)
    {
        
		if(writerInput.readyForMoreMediaData){
            
			CMTime frameTime = CMTimeMake(1, fps );
			CMTime lastTime=CMTimeMake(i, fps);
			CMTime presentTime=CMTimeAdd(lastTime, frameTime);
			
			if (i >= [array count])
			{
				buffer = NULL;
			}
			else
			{
				buffer = [HJImagesToVideo pixelBufferFromCGImage:[[array objectAtIndex:i] CGImage] size:CGSizeMake(480, 320)];
			}
			
			
			if (buffer)
			{
				// append buffer
				[adaptor appendPixelBuffer:buffer withPresentationTime:presentTime];
				i++;
			}
			else
			{
				
				//Finish the session:
				[writerInput markAsFinished];
				[videoWriter finishWritingWithCompletionHandler:^{
                    NSLog(@"Success here to");
                    
                }];
				
				CVPixelBufferPoolRelease(adaptor.pixelBufferPool);
				
				NSLog (@"Done");
                break;
            }
        }
    }
}

+ (CVPixelBufferRef) pixelBufferFromCGImage: (CGImageRef) image  size:(CGSize)imageSize
{
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithBool:YES], kCVPixelBufferCGImageCompatibilityKey,
                             [NSNumber numberWithBool:YES], kCVPixelBufferCGBitmapContextCompatibilityKey,
                             nil];
    CVPixelBufferRef pxbuffer = NULL;
    CVReturn status = CVPixelBufferCreate(kCFAllocatorDefault, imageSize.width,
                                          imageSize.height, kCVPixelFormatType_32ARGB, (__bridge CFDictionaryRef) options,
                                          &pxbuffer);
    NSParameterAssert(status == kCVReturnSuccess && pxbuffer != NULL);
    
    CVPixelBufferLockBaseAddress(pxbuffer, 0);
    void *pxdata = CVPixelBufferGetBaseAddress(pxbuffer);
    NSParameterAssert(pxdata != NULL);
    
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(pxdata, imageSize.width,
                                                 imageSize.height, 8, 4*imageSize.width, rgbColorSpace,
                                                 kCGImageAlphaNoneSkipFirst);
    NSParameterAssert(context);
    //    CGContextConcatCTM(context, frameTransform);
    CGContextDrawImage(context, CGRectMake(0+(imageSize.width-CGImageGetWidth(image))/2, (imageSize.height-CGImageGetHeight(image))/2, CGImageGetWidth(image),
                                           CGImageGetHeight(image)), image);
    CGColorSpaceRelease(rgbColorSpace);
    CGContextRelease(context);
    
    CVPixelBufferUnlockBaseAddress(pxbuffer, 0);
    
    return pxbuffer;
}




@end
