//
//  SearchDataViewCell.h
//  NewMyMusicAPP
//
//  Created by 08- 张志强 on 15/6/26.
//  Copyright (c) 2015年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchMVModel.h"
#import "UIImageView+WebCache.h"
@interface SearchDataViewCell : UITableViewCell


@property(nonatomic,retain)UILabel *titleLable;
@property(nonatomic,retain)UILabel *artistNameLable;
@property(nonatomic,retain)UIImageView *albumImg;

@property(nonatomic,retain)SearchMVModel *model;



@end
