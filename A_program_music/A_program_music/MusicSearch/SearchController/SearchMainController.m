//
//  SearchMainController.m
//  A_program_music
//
//  Created by 姚天成 on 15/6/21.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "SearchMainController.h"

@interface SearchMainController ()
@property(nonatomic,retain)NSString *temp;

@end

@implementation SearchMainController




- (void)viewDidLoad {
    [super viewDidLoad];
    self.OneSong = [[[SearchOneSongController alloc] init] autorelease];
    self.OneSong.title = @"单曲";
    self.OneSong.view.backgroundColor = [UIColor whiteColor];
    
    self.singer = [[[SearchSingerController alloc] init] autorelease];
    self.singer.title = @"歌手";
    self.singer.view.backgroundColor = [UIColor whiteColor];
    
    self.songList = [[[SearchSongListController alloc] init] autorelease];
    self.songList.title = @"歌单";
    self.songList.view.backgroundColor = [UIColor whiteColor];
    
    self.album = [[[SearchAlbumController alloc] init] autorelease];
    self.album.title = @"专辑";
    self.album.view.backgroundColor = [UIColor whiteColor];
    
    self.MV = [[[SearchMVController alloc] init] autorelease];
    self.MV.title = @"MV";
    self.MV.myDelegate = self;
    self.MV.view.backgroundColor = [UIColor whiteColor];
    
    self.navController = [[[SCNavTabBarController alloc] init] autorelease];
    self.navController.subViewControllers = @[self.OneSong, self.singer, self.album, self.songList, self.MV];
    
    self.navController.showArrowButton = NO;
    [self.navController addParentController:self];
    //传值
    [self getDataToPage];
    [self.navController setNavTabBarColor:[UIColor redColor]];
    //self.navigationItem.leftBarButtonItem= [[MusicBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(backToSearch)];
}
#warning 为啥比viewdidload先走
//重写set
-(void)setName:(NSString *)name{

    self.navigationItem.title = name;
    self.temp = name;


}
//协议方法
-(void)hideview{
    
    [self.myDelegate SearchMainHideView];

}
-(void)backToSearch{
    
    [self.navigationController popoverPresentationController];
    [super dealloc];

}
-(void)getDataToPage{

    self.OneSong.searchName = self.temp;
    self.songList.searchName = self.temp;
    self.album.searchName = self.temp;
    self.singer.searchName = self.temp;
    self.MV.title1 = self.temp;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
