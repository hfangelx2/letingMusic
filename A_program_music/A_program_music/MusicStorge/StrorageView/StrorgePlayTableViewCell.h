//
//  StrorgePlayTableViewCell.h
//  A_program_music
//
//  Created by dlios on 15/6/29.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StorgePlayModel.h"

@interface StrorgePlayTableViewCell : UITableViewCell

@property(nonatomic,retain)UILabel *labelSongName;
@property(nonatomic,retain)UILabel *labelSingerName;
@property(nonatomic,retain)UILabel *labelNumber;
@property(nonatomic,retain)UIImageView *imageView1;
@property(nonatomic,retain)UIButton *button;
@property(nonatomic,assign)NSInteger panduan;
@property(nonatomic,retain)StorgePlayModel *storgeModel;


@end
