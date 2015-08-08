//
//  OneSongModel.h
//  A_program_music
//
//  Created by 姚天成 on 15/6/21.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OneSongModel : NSObject
@property(nonatomic,copy)NSString *song_id;
@property(nonatomic,copy)NSString *singer_id;
@property(nonatomic,copy)NSString *song_name;
@property(nonatomic,copy)NSString *singer_name;
@property(nonatomic,retain)NSMutableArray *audition_list;






@end
