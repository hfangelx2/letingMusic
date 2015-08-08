//
//  SingerDetailViewController.h
//  A_program_music
//
//  Created by dlios on 15/6/23.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "MusicViewController.h"
#import "SingerDetailViewCell.h"
#import "SingerDetailModel.h"
#import "SingerModel.h"
#import "SingerSongViewController.h"
@interface SingerDetailViewController : MusicViewController<UITableViewDataSource,UITableViewDelegate>


@property(nonatomic,retain)SingerModel *singermodel;


@end
