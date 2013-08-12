//
//  IMGViewController.m
//  ImageToVid
//
//  Created by teejay on 8/12/13.
//  Copyright (c) 2013 Foley. All rights reserved.
//

#import "IMGViewController.h"
#import "HJImagesToVideo.h"

@interface IMGViewController ()

@end

@implementation IMGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Export Test
    
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:
                      [NSString stringWithFormat:@"Documents/movie.mp4"]];
    NSArray * testImageArray = @[ [UIImage imageNamed:@"frame1.JPG"],
                                  [UIImage imageNamed:@"frame2.JPG"],
                                  [UIImage imageNamed:@"frame3.JPG"],
                                  [UIImage imageNamed:@"frame4.JPG"],
                                  [UIImage imageNamed:@"frame5.JPG"],
                                  [UIImage imageNamed:@"frame6.JPG"],
                                  [UIImage imageNamed:@"frame7.JPG"],
                                  [UIImage imageNamed:@"frame8.JPG"],
                                  [UIImage imageNamed:@"frame9.JPG"],
                                  [UIImage imageNamed:@"frame10.JPG"],
                                  [UIImage imageNamed:@"frame11.JPG"]];
    
    [[NSFileManager defaultManager] removeItemAtPath:path error:NULL];
    
    [HJImagesToVideo videoFromImages:testImageArray
                              toPath:path
                             withFPS:10
                   withCallbackBlock:^(BOOL success) {
                       
                       if (success) {
                           NSLog(@"Success");
                           [HJImagesToVideo saveVideoToPhotosWithImages:testImageArray
                                                      withCallbackBlock:^(BOOL success) {
                                                          if (success) {
                                                              NSLog(@"Success");
                                                          } else {
                                                              NSLog(@"Failed");
                                                          }
                                                      }];
                       } else {
                           NSLog(@"Failed");
                       }
                   }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
