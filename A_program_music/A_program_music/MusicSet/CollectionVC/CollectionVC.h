//
//  CollectionVC.h
//  A_program_music
//
//  Created by dlios on 15/6/29.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "MusicViewController.h"
#import "CollectionTableViewCell.h"
@interface CollectionVC : MusicViewController<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,retain)NSMutableArray *array;




@end
