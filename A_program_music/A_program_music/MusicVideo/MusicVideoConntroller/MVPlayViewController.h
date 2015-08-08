//
//  MVPlayViewController.h
//  A_program_music
//
//  Created by dlios on 15/6/23.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MVDetailViewController.h"
#import "MVXGViewController.h"

@protocol MVPLay <NSObject>

-(void)displayView;

@end

@interface MVPlayViewController : UIViewController<IDsennt>
@property(nonatomic,copy)NSString *videoUrl;
@property(nonatomic,copy)NSString *titleNVC;
@property(nonatomic,copy)NSString *idD;
@property(nonatomic,retain)MVDetailViewController *MVDetailVC;
@property(nonatomic,retain)MVXGViewController *MVXViewVC;
@property(nonatomic,copy)NSString *strid;
@property(nonatomic,assign)id<MVPLay>mydelegate;
@end
