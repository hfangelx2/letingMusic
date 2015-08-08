//
//  MVDetailViewController.h
//  A_program_music
//
//  Created by dlios on 15/6/26.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MVDetailModel.h"
#import "MVDetailTableViewCell.h"



@interface MVDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,copy)NSString *ID;
@property(nonatomic,retain)UILabel *labelMvDetail;


@end
