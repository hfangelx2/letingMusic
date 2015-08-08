//
//  StorgeController.h
//  A_program_music
//
//  Created by 姚天成 on 15/6/19.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "MusicViewController.h"
#import "StorgeModel.h"
#import "StorgeCollectionViewCell.h"
#import "StrorgePlayViewController.h"
#import "SqlDateBase.h"



@interface StorgeController : MusicViewController<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,retain)UIAlertView *alertView;

@end
