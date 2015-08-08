//
//  detailNSTableViewCell.h
//  A_program_music
//
//  Created by dlios on 15/6/26.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "MusicTableViewCell.h"
#import "DetailNewSongModel.h"
@interface detailNSTableViewCell : MusicTableViewCell

@property(nonatomic,retain)DetailNewSongModel *detailNewSongModel;
@property(nonatomic,assign)BOOL changeColor;


@end
