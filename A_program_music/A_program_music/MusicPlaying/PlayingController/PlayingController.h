//
//  PlayingController.h
//  A_program_music
//
//  Created by 姚天成 on 15/6/21.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "MusicViewController.h"
#import "STKAudioPlayer.h"
#import "PlayModel.h"
#import "SongListCell.h"
#import "SearchOneSongCell.h"
#import <AVFoundation/AVFoundation.h>
#import "VLDContextSheet.h"
#import <MediaPlayer/MediaPlayer.h>
//定义循环枚举值
typedef NS_ENUM(NSInteger, PlayWithWay)
{
    PlayWithWayOneSongCirculation = 0,  //单曲
    PlayWithWayRandom,   //随机
    PlayWithWaySole   // 顺序
};

@protocol viewDisplayRoundView <NSObject>

-(void)viewDisplayView;
-(void)hideRoundView;

@end



@interface PlayingController : MusicViewController<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,VLDContextSheetDelegate>
@property(nonatomic,assign)id<viewDisplayRoundView>myDelegate;
@property(nonatomic,retain)NSMutableArray *playArray;
@property(nonatomic,assign)NSInteger indexPath;

@property (nonatomic, retain)NSTimer *myTimer;
@property(nonatomic,retain)STKAudioPlayer *player;//播放器对象
@property(nonatomic,assign)PlayWithWay playWithWay;

+(instancetype)PlayingBox;

@property (retain, nonatomic) VLDContextSheet *contextSheet;

-(void)lastSong;
-(void)nextSong;
@end
