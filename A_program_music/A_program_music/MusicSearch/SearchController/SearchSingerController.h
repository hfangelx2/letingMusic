//
//  SearchSingerController.h
//  A_program_music
//
//  Created by 姚天成 on 15/6/21.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "MusicViewController.h"
#import "SearchSingerModel.h"
#import "SearchSingerCell.h"
@interface SearchSingerController : MusicViewController<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,retain)NSString *searchName;
@property(nonatomic,retain)NSMutableArray *array;
@end
