//
//  MainViewController.m
//  A_program_music
//
//  Created by 姚天成 on 15/6/19.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@property(nonatomic,retain)PlayingController *playingPage;
@property(nonatomic,retain)MusicView *PlayingRoundView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.discover = [[DiscoverController alloc] init];
    self.discover.title = @"乐荐";
    self.discover.view.backgroundColor = [UIColor whiteColor];
    
    self.storage = [[StorgeController alloc] init];
    self.storage.title = @"乐库";
    self.storage.view.backgroundColor = [UIColor whiteColor];
    
    self.rank = [[RankController alloc] init];
    self.rank.title = @"乐听";
    self.rank.view.backgroundColor = [UIColor whiteColor];
    
    self.Video = [[VideoController alloc] init];
    self.Video.title = @"乐看";
    self.Video.mydelegate = self;
    self.Video.view.backgroundColor = [UIColor whiteColor];
    
    self.navController = [[SCNavTabBarController alloc] init];
    self.navController.subViewControllers = @[self.discover, self.storage, self.rank, self.Video];
    //关闭显示向下抽屉小箭头
    self.navController.showArrowButton = NO;
    [self.navController addParentController:self];
    self.navigationItem.title = @"音乐";
    [self.navController setNavTabBarColor:[UIColor redColor]];
    //搜索页面.
    self.searchPage = [[SearchController alloc] init];
    self.searchPage.mydelegate = self;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(0*WIDTH, 5*WIDTH, 25*WIDTH, 25*WIDTH);
    [button setImage:[UIImage imageNamed:@"sousuo"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(searchPageAction)forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
//    设置页面
    
//    self.musicSetVC = [[MusicSetViewController alloc] init];
  /*  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"sort_artist"] style:UIBarButtonItemStyleDone target:self action:@selector(presentRightMenuViewController:)];*/
    
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame=CGRectMake(0, 5, 25, 25);
    [button1 setImage:[UIImage imageNamed:@"yonghu"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(presentRightMenuViewController:)forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithCustomView:button1];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    
    
}
-(void)displayView{

    [self.mydelegate viewDisplayView];
}
-(void)hideView{
    [self.mydelegate hideRoundView];
}
-(void)hideRoundView{

    [self.mydelegate hideRoundView];
}
-(void)hideView1{
    [self.mydelegate hideRoundView];
}

-(void)searchPageAction{
    //MusicNavigationController *nav = [[MusicNavigationController alloc] initWithRootViewController:self.searchPage];
    
    [self.navigationController pushViewController:self.searchPage animated:YES];
    
}
-(void)viewDisplayView{

    [self.mydelegate viewDisplayView];

}


/*
-(void)pushToMusicSet
{
    [MusicView animateWithDuration:1.0 animations:^{
        self.navigationController.view.transform = CGAffineTransformMakeTranslation(-self.view.frame.size.width*0.8, 0);
        
    }];
    

    
    
    
    
    
    
    MusicNavigationController *nav = [[MusicNavigationController alloc] initWithRootViewController:self.musicSetVC];
    
   [self presentViewController:nav animated:YES completion:^{
       
       
   }];

}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
