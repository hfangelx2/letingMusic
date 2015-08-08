//
//  SongListCell.h
//  A_program_music
//
//  Created by 姚天成 on 15/6/23.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "MusicTableViewCell.h"
#import "PlayModel.h"
@interface SongListCell : MusicTableViewCell

@property(nonatomic,retain)PlayModel *model;
@property(nonatomic,copy)NSString *number;
@end
