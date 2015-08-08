//
//  MusicVideoTableViewCell.h
//  A_program_music
//
//  Created by dlios on 15/6/23.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicVideoTableViewCell : UITableViewCell

@property(nonatomic,copy)NSString *picUrl;
@property(nonatomic,copy)NSString *title;

@property(nonatomic,retain)UIImageView *imageV;

@property(nonatomic,retain)UILabel *labelTitle;

@end
