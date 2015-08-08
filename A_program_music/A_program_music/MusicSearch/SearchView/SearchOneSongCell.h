//
//  SearchOneSongCell.h
//  A_program_music
//
//  Created by 姚天成 on 15/6/21.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "MusicTableViewCell.h"
#import "OneSongModel.h"
#import "AlbumModel.h"
@interface SearchOneSongCell : MusicTableViewCell

@property(nonatomic,retain)OneSongModel *model;
@property(nonatomic,copy)NSString *number;
@property(nonatomic,assign)BOOL isCollect;
@property(nonatomic,retain)AlbumModel *album;

@end
