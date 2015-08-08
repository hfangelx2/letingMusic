//
//  MVDetailTableViewCell.h
//  A_program_music
//
//  Created by dlios on 15/6/27.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MVDetailTableViewCell : UITableViewCell

@property(nonatomic,retain)NSMutableArray *bigArray;
@property(nonatomic,copy)NSString *artName;
@property(nonatomic,copy)NSString *descriptionA;
@property(nonatomic,copy)NSString *playTimes;
@property(nonatomic,copy)NSString *regdate;
@property(nonatomic,copy)NSString *posterPic;
@property(nonatomic,retain)NSMutableArray *XgMvArray;

@end
