//
//  MainViewController.h
//  A_program_music
//
//  Created by 姚天成 on 15/6/19.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "MusicViewController.h"
#import "DiscoverController.h"
#import "RankController.h"
#import "StorgeController.h"
#import "VideoController.h"
#import "SCNavTabBarController.h"
#import "SearchController.h"
#import "MusicSetViewController.h"
#import "VideoController.h"

@protocol mainControllerDelegate <NSObject>

-(void)hideRoundView;
-(void)viewDisplayView;
@end


@interface MainViewController : MusicViewController<MVprotocol,searchPageDelegate>
@property(nonatomic,retain)SCNavTabBarController *navController;
@property(nonatomic,assign)id<mainControllerDelegate>mydelegate;
@property(nonatomic,retain)DiscoverController *discover;
@property(nonatomic,retain)StorgeController *storage;
@property(nonatomic,retain)VideoController *Video;
@property(nonatomic,retain)RankController *rank;
@property(nonatomic,retain)SearchController *searchPage;
@property(nonatomic,retain)MusicSetViewController *musicSetVC;



@end
