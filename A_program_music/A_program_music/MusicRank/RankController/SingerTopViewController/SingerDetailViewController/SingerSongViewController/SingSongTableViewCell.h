//
//  SingSongTableViewCell.h
//  A_program_music
//
//  Created by dlios on 15/6/24.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "MusicTableViewCell.h"
#import "SingerSongModel.h"
@interface SingSongTableViewCell : MusicTableViewCell


@property(nonatomic,retain)SingerSongModel *model;
@property(nonatomic,assign)BOOL changeColor;
@property(nonatomic,copy)NSString *number;


@end
