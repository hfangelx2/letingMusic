//
//  DownLoadImage.m
//  UI15_Get-Post
//
//  Created by 姚天成 on 15/6/2.
//  Copyright (c) 2015年 jack_yao. All rights reserved.
//

#import "DownLoadImage.h"

@implementation DownLoadImage

+(void)downLoadImageUrl:(NSString *)URL block:(downLoadBlock)myBlock{
 
    NSString *urlEncode = [URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlEncode];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
       //block回调
        myBlock(data);
    }];
    
}

@end
