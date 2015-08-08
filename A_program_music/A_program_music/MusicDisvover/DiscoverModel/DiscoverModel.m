//
//  DiscoverModel.m
//  A_program_music
//
//  Created by 姚天成 on 15/6/19.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "DiscoverModel.h"

@implementation DiscoverModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"action"]) {
        self.value = [value objectForKey:@"value"];
    }
    if ([key isEqualToString:@"id"]) {
        self.Listid = value;
    }
    
    
}


@end
