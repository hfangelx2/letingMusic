//
//  StorgePlayModel.h
//  A_program_music
//
//  Created by dlios on 15/6/29.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StorgePlayModel : NSObject
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *singerName;
@property(nonatomic,retain)NSMutableArray *auditionList;


@end
