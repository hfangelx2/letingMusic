//
//  CollectionTableViewCell.h
//  A_program_music
//
//  Created by dlios on 15/7/3.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "MusicTableViewCell.h"
#import "PlayModel.h"

@interface CollectionTableViewCell : MusicTableViewCell


@property(nonatomic,retain)PlayModel *playModel;
@property(nonatomic,copy)NSString *number;








@end
