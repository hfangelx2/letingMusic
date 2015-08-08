//
//  DetailNewSongModel.h
//  A_program_music
//
//  Created by dlios on 15/6/25.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailNewSongModel : NSObject



@property(nonatomic,copy)NSString *msg_id;
@property(nonatomic,copy)NSString *album_name;
@property(nonatomic,copy)NSString *singer_name;
@property(nonatomic,retain)NSIndexPath *indexpath;
@property(nonatomic,retain)NSMutableArray *audition_list;

@end
