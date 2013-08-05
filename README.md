HJImagesToVideo
===============

Convert image array to mp4

Feel free to use this in your projects - if you make any improvements submit a pull request!  It is still in progress.

This helper class takes an array of UIImages and will convert them to an mp4 at your desired path, size, and framerate

This is all you need!
```
[HJImagesToVideo videoFromImages:imageArray ToPath:path WithFPS:10 WithCallbackBlock:nil];
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

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
