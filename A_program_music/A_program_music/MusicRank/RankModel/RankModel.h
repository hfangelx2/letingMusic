//
//  RankModel.h
//  A_program_music
//
//  Created by 姚天成 on 15/6/19.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RankModel : NSObject

@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *singerName;
@property(nonatomic,copy)NSString *songName;
@property(nonatomic,copy)NSString *pic_url;
@property(nonatomic,retain)NSMutableArray *array;
@property(nonatomic,copy)NSString *number;
@property(nonatomic,copy)NSString *details;




@end
