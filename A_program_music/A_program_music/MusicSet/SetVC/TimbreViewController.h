//
//  TimbreViewController.h
//  A_program_music
//
//  Created by dlios on 15/6/29.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "MusicViewController.h"

@protocol TimbreVCdelegate <NSObject>

-(void)sendMessageToSet:(NSString *)string;

@end




@interface TimbreViewController : MusicViewController<UITableViewDataSource,UITableViewDelegate>


@property(nonatomic,assign)id<TimbreVCdelegate>mydelegate;



@end
