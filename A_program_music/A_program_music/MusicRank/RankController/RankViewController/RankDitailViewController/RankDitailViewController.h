//
//  RankDitailViewController.h
//  A_program_music
//
//  Created by dlios on 15/6/20.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "MusicViewController.h"
#import "RankModel.h"
#import "RankDitailTableViewCell.h"
#import "RankDitailModel.h"
#import "PlayingController.h"
#import "PlayModel.h"
@interface RankDitailViewController : MusicViewController<UITableViewDataSource,UITableViewDelegate>


@property(nonatomic,retain)MusicTableViewController *tableView;
@property(nonatomic,retain)RankModel *rankmodel;
@property(nonatomic,retain)NSMutableArray *array;
@property(nonatomic,retain)NSTimer *timer;
@property(nonatomic,retain)UIVisualEffectView *visualEfView;
@property(nonatomic,retain)NSMutableArray *playArray;
@property(nonatomic,assign)NSInteger nextPage;
@property(nonatomic,assign)BOOL upLoad;


@end
