//
//  SingerSongModel.h
//  A_program_music
//
//  Created by dlios on 15/6/24.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingerSongModel : NSObject


@property(nonatomic,copy)NSString *singer_id;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *singerName;
@property(nonatomic,copy)NSString *pic_url;
@property(nonatomic,retain)NSIndexPath *indexpath;
@property(nonatomic,copy)NSString *number;
@property(nonatomic,retain)NSMutableArray *audition_list;

@end
