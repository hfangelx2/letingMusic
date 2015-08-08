//
//  CollectSQL.h
//  A_program_music
//
//  Created by 姚天成 on 15/7/2.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CollectSQL : NSObject
+ (instancetype)shareSQL;
- (void)insertSCMusicWithPlayModel:(PlayModel *)model;
- (NSMutableArray *)selectAllSCPlayModel;
- (void)deleteAllSCPlayMusic;
-(void)deleteSCMusicWithPlayModel:(PlayModel *)model;


@end
