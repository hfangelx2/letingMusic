//
//  NewSongViewController.h
//  A_program_music
//
//  Created by dlios on 15/6/23.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "MusicViewController.h"
#import "NewSongCollectionViewCell.h"
#import "NewSongModel.h"
#import "DetailNewSViewController.h"
#import "SqlDateBase.h"

@interface NewSongViewController : MusicViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property(nonatomic,retain)NSMutableArray *array;
@property(nonatomic,retain)NSMutableArray *array1;




@end
