//
//  MVXGVideoTableViewCell.h
//  A_program_music
//
//  Created by dlios on 15/6/26.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MVXGVideoTableViewCell : UITableViewCell

@property(nonatomic,retain)UIImageView *imgView;
@property(nonatomic,copy)NSString *songName;
@property(nonatomic,copy)NSString *artName;
@property(nonatomic,copy)NSString *picUrl;
@property(nonatomic,copy)NSString *IDD;
@property(nonatomic,retain)UILabel *labelSongName;
@property(nonatomic,retain)UILabel *labelArtName;

@end
