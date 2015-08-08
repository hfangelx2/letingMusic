//
//  SleepViewController.h
//  A_program_music
//
//  Created by dlios on 15/6/29.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "MusicViewController.h"

@protocol sleepTime <NSObject>

-(void)sleepTime:(NSString *)time;

@end


@interface SleepViewController : MusicViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property(nonatomic,assign)id<sleepTime>myDelegate;
+(instancetype)shareSleepHandle;
@property(nonatomic,assign)BOOL sleep;


@end
