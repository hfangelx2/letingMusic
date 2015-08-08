//
//  SearchSongListController.h
//  A_program_music
//
//  Created by 姚天成 on 15/6/21.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "MusicViewController.h"
#import "SearchSongListCell.h"
#import "SearchSongListModel.h"
@interface SearchSongListController : MusicViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,retain)NSString *searchName;
@property(nonatomic,retain)NSMutableArray *array;

@end
