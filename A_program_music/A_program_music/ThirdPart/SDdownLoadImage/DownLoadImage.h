//
//  DownLoadImage.h
//  UI15_Get-Post
//
//  Created by 姚天成 on 15/6/2.
//  Copyright (c) 2015年 jack_yao. All rights reserved.
//

#import <Foundation/Foundation.h>

//参数是用来回调的
typedef void(^downLoadBlock)(NSData *data);


@interface DownLoadImage : NSObject



+(void)downLoadImageUrl:(NSString *)URL block:(downLoadBlock)myBlock;

@end
