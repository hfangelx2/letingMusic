//
//  DiscoverNewsongList.h
//  A_program_music
//
//  Created by 姚天成 on 15/6/25.
//  Copyright © 2015年 CHD. All rights reserved.
//

#import "MusicViewController.h"
#import "PlayModel.h"
#import "DiscoverModel.h"
@interface DiscoverNewsongList : MusicViewController<UITableViewDataSource,UITableViewDelegate>


@property(nonatomic,retain)DiscoverModel *model;
@end
