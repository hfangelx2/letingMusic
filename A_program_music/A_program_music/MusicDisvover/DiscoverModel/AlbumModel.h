//
//  AlbumModel.h
//  A_program_music
//
//  Created by 姚天成 on 15/7/3.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlbumModel : NSObject
@property(nonatomic,copy)NSString *singerName;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,retain)NSMutableArray *auditionList;

@end
