//
//  StrorgePlayViewController.h
//  A_program_music
//
//  Created by dlios on 15/6/29.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StrorgePlayTableViewCell.h"
#import "StorgePlayModel.h"

@interface StrorgePlayViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,copy)NSString *titleA;
@property(nonatomic,copy)NSString *ID;
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,assign)BOOL upLoad;
@property(nonatomic,retain)StorgePlayModel *model;
@property(nonatomic,assign)NSInteger pageCount;



@end
