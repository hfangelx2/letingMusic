//
//  DetailNewSViewController.h
//  A_program_music
//
//  Created by dlios on 15/6/24.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "MusicViewController.h"
#import "DetailNewSongModel.h"
#import "detailNSTableViewCell.h"
#import "PlayingController.h"
#import "PlayModel.h"
#import "NewSongScrollView.h"
@interface DetailNewSViewController : MusicViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,retain)DetailNewSongModel *detailNewSongModel;
@property(nonatomic,retain)NSMutableArray *allStrArray;
@property(nonatomic,retain)NSMutableArray *array;
@property(nonatomic,retain)NSMutableArray *playArray;

@property(nonatomic,retain)NSMutableArray *scrollArray;







@end
