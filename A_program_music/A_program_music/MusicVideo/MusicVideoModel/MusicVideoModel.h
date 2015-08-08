//
//  MusicVideoModel.h
//  A_program_music
//
//  Created by dlios on 15/6/23.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicVideoModel : NSObject
@property(nonatomic,copy)NSString *albumImg;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,retain)NSMutableArray *artists;
@property(nonatomic,copy)NSString *posterPic;
@property(nonatomic,copy)NSString *url;
@property(nonatomic,copy)NSString *Idd;

@end
