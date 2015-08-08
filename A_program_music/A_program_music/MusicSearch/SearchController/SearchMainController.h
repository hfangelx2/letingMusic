//
//  SearchMainController.h
//  A_program_music
//
//  Created by 姚天成 on 15/6/21.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "MusicViewController.h"
#import "SCNavTabBarController.h"
#import "SearchOneSongController.h"
#import "SearchSingerController.h"
#import "SearchAlbumController.h"
#import "SearchSongListController.h"
#import "SearchMVController.h"

@protocol searchMainDelegate <NSObject>

-(void)SearchMainHideView;

@end


@interface SearchMainController : MusicViewController<searchMvDelegate>
@property(nonatomic,assign)id<searchMainDelegate>myDelegate;
@property(nonatomic,retain)SearchOneSongController *OneSong;
@property(nonatomic,retain)SearchSingerController *singer;
@property(nonatomic,retain)SearchSongListController *songList;
@property(nonatomic,retain)SearchAlbumController *album;
@property(nonatomic,retain)SearchMVController *MV;
@property(nonatomic,retain)SCNavTabBarController *navController;
@property(nonatomic,retain)NSString *name;

@end
