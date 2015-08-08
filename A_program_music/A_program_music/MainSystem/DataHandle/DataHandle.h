//
//  DataHandle.h
//  A_program_music
//
//  Created by 姚天成 on 15/6/26.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataHandle : NSObject
+(instancetype)DataHandle;
@property(nonatomic,assign)CGPoint point;
@property(nonatomic,assign)BOOL isPlayMusic;
@property(nonatomic,assign)NSInteger MusicQuality;
@end
