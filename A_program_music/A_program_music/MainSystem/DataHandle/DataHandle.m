//
//  DataHandle.m
//  A_program_music
//
//  Created by 姚天成 on 15/6/26.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "DataHandle.h"

@implementation DataHandle

+(instancetype)DataHandle{
    
    static DataHandle *data = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        data = [[DataHandle alloc] init];
    });
    return data;
    
}



@end
