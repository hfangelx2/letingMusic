//
//  RankDitailTableViewCell.h
//  A_program_music
//
//  Created by dlios on 15/6/22.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "MusicTableViewCell.h"
#import "RankDitailModel.h"

@interface RankDitailTableViewCell : MusicTableViewCell

@property(nonatomic,retain)UILabel *label1;
@property(nonatomic,retain)UILabel *label2;
@property(nonatomic,retain)UILabel *label3;
@property(nonatomic,retain)RankDitailModel *rankDitailmodel;
@property(nonatomic,retain)UIImageView *imageview1;
@property(nonatomic,assign)BOOL changeColor;


@end
