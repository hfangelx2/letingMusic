//
//  RankViewController.h
//  A_program_music
//
//  Created by dlios on 15/6/19.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "MusicViewController.h"
#import "RankTableViewCell.h"
#import "MusicTableViewController.h"
#import "RankModel.h"
#import "RankDitailViewController.h"
#import <MBProgressHUD.h>

@interface RankViewController : MusicViewController<UITableViewDataSource,UITableViewDelegate>


@property(nonatomic,retain)NSMutableArray *allArray;
@property(nonatomic,retain)MusicTableViewController *tableView;

@property(nonatomic,retain)NSMutableArray *threeArray;



@end
