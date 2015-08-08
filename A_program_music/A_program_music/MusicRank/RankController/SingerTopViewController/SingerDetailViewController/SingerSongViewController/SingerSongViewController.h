//
//  SingerSongViewController.h
//  A_program_music
//
//  Created by dlios on 15/6/24.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "MusicViewController.h"
#import "SingerSongModel.h"
#import "SingSongTableViewCell.h"
#import "PlayingController.h"
#import "PlayModel.h"
@interface SingerSongViewController : MusicViewController<UITableViewDataSource,UITableViewDelegate>


@property(nonatomic,retain)SingerSongModel *singerSongModel;
@property(nonatomic,retain)NSMutableArray *array;
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,assign)BOOL upLoad;
@property(nonatomic,copy)NSString *pic;
@property(nonatomic,assign)NSInteger pageCount;
@property(nonatomic,retain)NSMutableArray *playArray;


@end
