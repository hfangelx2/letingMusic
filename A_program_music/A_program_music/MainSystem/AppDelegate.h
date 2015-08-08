//
//  AppDelegate.h
//  A_program_music
//
//  Created by 姚天成 on 15/6/19.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "PlayingController.h"
#import "DataHandle.h"
#import "RESideMenu.h"
#import "SearchMVController.h"


//typedef void(^remoteBlock) (id event);
@interface AppDelegate : UIResponder <UIApplicationDelegate,viewDisplayRoundView,RESideMenuDelegate,mainControllerDelegate,searchPageDelegate,searchMvDelegate>


//@property (nonatomic, copy) void(^remoteBlock)(UIEvent *event);
@property (retain, nonatomic) UIWindow *window;
@property(nonatomic,retain)MainViewController *main;
@property(nonatomic,retain)MusicViewController *RootVC;






@end

