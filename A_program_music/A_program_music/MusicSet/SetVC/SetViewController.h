//
//  SetViewController.h
//  A_program_music
//
//  Created by dlios on 15/6/29.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "MusicViewController.h"
#import "SleepViewController.h"
#import "TimbreViewController.h"
#import "AboutMeViewController.h"

@interface SetViewController : MusicViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,TimbreVCdelegate,sleepTime>

@property(nonatomic,assign)BOOL getBack;
@property(nonatomic,copy)NSString *str;


+(instancetype)ShareSetHandle;


@end
