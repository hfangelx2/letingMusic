//
//  KoreaController.h
//  A_program_music
//
//  Created by 姚天成 on 15/6/24.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "MusicViewController.h"
#import "OneSongModel.h"
#import "SearchOneSongCell.h"
@interface KoreaController : MusicViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,retain)NSString *IDD;


@end
