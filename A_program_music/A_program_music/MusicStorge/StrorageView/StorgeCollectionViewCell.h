//
//  StorgeCollectionViewCell.h
//  A_program_music
//
//  Created by dlios on 15/6/20.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StorgeCollectionViewCell : UICollectionViewCell
@property(nonatomic,copy)NSString *picture;
@property(nonatomic,retain)UIImageView *imageV;
@property(nonatomic,copy)NSString *titleSmall;
@property(nonatomic,copy)NSString *titleBig;


@end
