//
//  DiscoverModel.h
//  A_program_music
//
//  Created by 姚天成 on 15/6/19.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiscoverModel : NSObject

@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *pic_url;
@property(nonatomic,copy)NSString *value;
@property(nonatomic,copy)NSString *desc;
@property(nonatomic,copy)NSString *author;
@property(nonatomic,copy)NSString *listen_count;
@property(nonatomic,copy)NSString *Listid;
@property(nonatomic,retain)NSMutableDictionary *action;
@end
