HJImagesToVideo
===============

Convert image array to mp4

Feel free to use this in your projects - if you make any improvements submit a pull request!  It is still in progress.

This helper class takes an array of UIImages and will convert them to an mp4 at your desired path, size, and framerate

Here are the basics:

#### Save to path with framerate and callback block
```
[HJImagesToVideo videoFromImages:imageArray ToPath:path WithFPS:10 WithCallbackBlock:nil];
```

#### Save to path with size, framerate,  and callback block
```
[HJImagesToVideo videoFromImages:imageArray ToPath:path withSize:size WithFPS:10 WithCallbackBlock:nil];
```
#### Save to photos 
```
[HJImagesToVideo saveVideoToPhotosWithImages:imageArray WithCallbackBlock:nil];
```

Example usage:

```
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
    
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:
                      [NSString stringWithFormat:@"Documents/temp.mp4"]];
    [[NSFileManager defaultManager] removeItemAtPath:path error:NULL];
    [HJImagesToVideo videoFromImages:testImageArray ToPath:path WithFPS:10 WithCallbackBlock:^{
        NSLog(@"Success");
        
    }];
```

Copyright 2013 Harrison Jackson
http://harrisonjackson.us

Feel free to use however you want - if you make any improvements submit a pull request!
