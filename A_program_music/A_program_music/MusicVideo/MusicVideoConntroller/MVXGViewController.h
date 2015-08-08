//
//  MVXGViewController.h
//  A_program_music
//
//  Created by dlios on 15/6/26.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MVXGVideoTableViewCell.h"
#import "MVXGModel.h"




@protocol IDsennt <NSObject>

-(void)presdent:(NSString *)idStr;

@end



@interface MVXGViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,copy)NSString *ID;

@property(nonatomic,assign)id<IDsennt>myDelegate;

@end
