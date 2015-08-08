//
//  PlayingController.m
//  A_program_music
//
//  Created by 姚天成 on 15/6/21.
//  Copyright (c) 2015年 CHD. All rights reserved.
//
/*
 //定位
 [TopicsTable setContentOffset:CGPointMake(0, promiseNum * 44 + Chapter * 20)];
 
*/
#import "PlayingController.h"
#import "VLDContextSheetItem.h"
#import "UMSocial.h"
@interface PlayingController ()<NSURLSessionDelegate>
@property(nonatomic,retain)PlayModel *model;
@property(nonatomic,retain)MusicButton *backButton;//左上角返回按钮
@property(nonatomic,retain)MusicLabel *songNameLabel;//歌曲名label
@property(nonatomic,retain)MusicLabel *singerNameLabel;//歌手名label
@property(nonatomic,retain)UIImageView *SingerPic;//歌手图片
@property(nonatomic,copy)NSString *sing_name;
@property(nonatomic,retain)UISlider *musicProgramSlider;//音乐播放进度
@property(nonatomic,retain)MusicButton *playButton;//播放暂停按钮
@property(nonatomic,retain)MusicButton *lastMusic;//上一曲
@property(nonatomic,retain)MusicButton *nextMusic;//下一曲
@property(nonatomic,retain)MusicButton *duiLie;//循环模式
@property(nonatomic,retain)MusicButton *xunhuan;//喜欢
@property(nonatomic,retain)NSMutableArray *array;//播放队列
@property(nonatomic,assign)NSInteger num;
@property(nonatomic,copy)NSString *songName;
@property(nonatomic,assign)BOOL isDisPlayList;
@property(nonatomic,retain)MusicTableViewController *songListTableView;
@property(nonatomic,assign)NSInteger songLenth;
@property(nonatomic,retain)NSTimer *myTime;
@property(nonatomic,copy)NSString *url;
@property(nonatomic,assign)NSInteger a;
@property(nonatomic,assign)NSInteger duration;


@property (nonatomic,strong) NSURLSession *session;

@end

static PlayingController *play = nil;

@implementation PlayingController
-(void)dealloc{
    [_songListTableView release];
    [_songNameLabel release];
    [_model release];
    [_singerNameLabel release];
    [_SingerPic release];
    
    [super dealloc];
}
+(instancetype)PlayingBox{

    
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        play = [[PlayingController alloc] init];
        play.player = [[STKAudioPlayer alloc] init];
        
    });
    return play;

}


-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;

}
-(void)viewWillAppear:(BOOL)animated{
    
    [self.myDelegate hideRoundView];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //注册session
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setActive:YES error:nil];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    
    _playWithWay = PlayWithWaySole;//默认为循环播放
    self.isDisPlayList = NO;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"playBackgroundPic"]];
    //self.view.backgroundColor = [UIColor whiteColor];
    [self creatBackButton];
    //创建歌名label
    [self creatSongNameLabel];
    //设置scrollview默认显示页
    [self creatPlayButton];

    [self creatSongList];
    self.SingerPic = [[[UIImageView alloc] initWithFrame:CGRectMake(35, 100, 250, 250)] autorelease];
    [self.view addSubview:self.SingerPic];
    self.SingerPic.center = self.view.center;
   
   
}
//创建slider 
-(void)creatSlider{
    
    self.musicProgramSlider = [[UISlider alloc] initWithFrame:CGRectMake(20, self.view.frame.size.height - 100, self.view.frame.size.width - 40, 20)];
    [self.musicProgramSlider addTarget:self action:@selector(changeProgress) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.musicProgramSlider];
    //设置slider滑块图片
    [self.musicProgramSlider setThumbImage:[UIImage imageNamed:@"fx_star_slider_min"] forState:UIControlStateHighlighted];
    
}
//slider触发方法
-(void)changeProgress{
    if (!self.player)
    {
        return;
    }
    
    NSLog(@"Slider Changed: %f", self.musicProgramSlider.value);
    
    [self.player seekToTime:self.musicProgramSlider.value];
    if (self.player.state == STKAudioPlayerStateStopped) {
        [self nextSong];
    }
}
//创建播放页面的button
-(void)creatPlayButton{
   
    self.playButton = [self creatButtonMethed:CGRectMake(self.view.frame.size.width / 5 * 2 + 5, self.view.frame.size.height - 70, 50, 50) Title:nil Image:[UIImage imageNamed:@"toolbar_play_n"]];
    [self.playButton addTarget:self action:@selector(playMusic) forControlEvents:UIControlEventTouchUpInside];
     [self addSubButtonOnView:self.playButton];
    
    self.lastMusic = [self creatButtonMethed:CGRectMake(self.view.frame.size.width / 5 * 1 + 5, self.playButton.frame.origin.y, self.playButton.frame.size.width, self.playButton.frame.size.height) Title:nil Image:[UIImage imageNamed:@"shangyiqu"]];
    [self.lastMusic addTarget:self action:@selector(lastSong) forControlEvents:UIControlEventTouchUpInside];
     [self addSubButtonOnView:self.lastMusic];
    
    self.nextMusic = [self creatButtonMethed:CGRectMake(self.view.frame.size.width / 5 * 3 + 5, self.playButton.frame.origin.y, self.playButton.frame.size.width, self.playButton.frame.size.height) Title:nil Image:[UIImage imageNamed:@"xiayiqu"]];
    [self.nextMusic addTarget:self action:@selector(nextSong) forControlEvents:UIControlEventTouchUpInside];
     [self addSubButtonOnView:self.nextMusic];
    
    self.xunhuan = [self creatButtonMethed:CGRectMake( self.view.frame.size.width / 5 - 58, self.playButton.frame.origin.y, self.playButton.frame.size.width, self.playButton.frame.size.height) Title:nil Image:[UIImage imageNamed:@"顺序播放"]];
    [self.xunhuan addTarget:self action:@selector(xunhuanAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubButtonOnView:self.xunhuan];
    
    self.duiLie = [self creatButtonMethed:CGRectMake(self.view.frame.size.width / 5 * 4 + 5, self.playButton.frame.origin.y, self.playButton.frame.size.width, self.playButton.frame.size.height) Title:nil Image:[UIImage imageNamed:@"playList"]];
    [self.duiLie addTarget:self action:@selector(songList:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubButtonOnView:self.duiLie];
   // UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeList)];
    //[self.view addGestureRecognizer:tap];
    
}
//-(void)closeList{
//    if (self.isDisPlayList == NO) {
//        return;
//    }
//    NSLog(@"关闭列表");
//    [MusicView animateWithDuration:0.5 animations:^{
//        self.songListTableView.alpha = 0;
//        self.songListTableView.frame = CGRectMake(self.view.frame.size.width, self.view.frame.size.height, 0, 0);
//    }];
//    [self.view bringSubviewToFront:self.SingerPic];
//    [self.view bringSubviewToFront:self.musicProgramSlider];
//    self.isDisPlayList = NO;
//    
//
//}



-(void)addSubButtonOnView:(MusicButton *)button{

    [self.view addSubview:button];

}
-(void)songList:(MusicButton *)button{
    
    if (self.isDisPlayList == NO) {
        NSLog(@"显示列表");
        [MusicView animateWithDuration:0.5 animations:^{
            self.songListTableView.alpha = 0.7;
            self.songListTableView.frame = CGRectMake(self.view.frame.size.width / 5.17886, self.view.frame.size.height / 3.229, self.view.frame.size.width / 1.306, self.view.frame.size.height / 1.6958);
            [self.view bringSubviewToFront:self.songListTableView];
        }];
        self.isDisPlayList = YES;
    }else{
        NSLog(@"关闭列表");
        [MusicView animateWithDuration:0.5 animations:^{
            self.songListTableView.alpha = 0;
            self.songListTableView.frame = CGRectMake(self.view.frame.size.width, self.view.frame.size.height, 0, 0);
        }];
        [self.view bringSubviewToFront:self.SingerPic];
        [self.view bringSubviewToFront:self.musicProgramSlider];
        self.isDisPlayList = NO;
    }
    
}
//创建歌单列表
-(void)creatSongList{
    //CGFloat width = [UIScreen mainScreen].bounds.size.width;
    //CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    self.songListTableView = [[[MusicTableViewController alloc] initWithFrame:CGRectMake(self.view.frame.size.width, self.view.frame.size.height, 0, 0) style:UITableViewStylePlain] autorelease];
    self.songListTableView.backgroundColor = [UIColor lightGrayColor];
    self.songListTableView.alpha = 0.7;
    self.songListTableView.delegate = self;
    self.songListTableView.dataSource = self;
    [self.view addSubview:self.songListTableView];
    [self.view bringSubviewToFront:self.songListTableView];
}


//循环按钮触发方法
-(void)xunhuanAction{
    //关闭列表
    //[self closeList];
    if (_playWithWay == PlayWithWayOneSongCirculation) {//单曲循环播放
        [self.xunhuan setImage:[UIImage imageNamed:@"随机播放"] forState:UIControlStateNormal];
        _playWithWay = PlayWithWayRandom;
        return;
    }else if (_playWithWay == PlayWithWayRandom){//随机播放
        [self.xunhuan setImage:[UIImage imageNamed:@"顺序播放"] forState:UIControlStateNormal];
        _playWithWay = PlayWithWaySole;
        return;
    }else if(_playWithWay == PlayWithWaySole){//顺序循环
        [self.xunhuan setImage:[UIImage imageNamed:@"单曲循环"] forState:UIControlStateNormal];
        _playWithWay = PlayWithWayOneSongCirculation;
        return;
    }
    
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

        NSString *str = [NSString stringWithFormat:@"播放列表(%ld)",self.array.count];
        return str;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

        return 50;
  
    
}
//点击cell播放对应歌曲
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

        [self playMusicSong:indexPath.row];
        [self songList:self.xunhuan];

    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        
    return self.array.count;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *name = @"songList";
    SongListCell *cell = [tableView dequeueReusableCellWithIdentifier:name];
    if (cell == nil) {
        cell = [[SongListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:name];
    }
    //将model传入自定义cell中
    cell.model = [self.array objectAtIndex:indexPath.row];
    //将number传进去
    cell.number = [NSString stringWithFormat:@"%ld.",indexPath.row + 1];
    //cell.selectionStyle = UITableViewCellSelectionStyleNone; //（这种是没有点击后的阴影效果)
    cell.backgroundColor = [UIColor clearColor];
    //cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
    
}
//播放按钮.
-(void)playMusic{
    if (!self.player)
    {
        return;
    }
   // [self closeList];
    //如果状态不为播放,将playButton的图片变为暂停
    if (self.player.state == STKAudioPlayerStatePaused|| self.player.state == STKAudioPlayerStateReady || self.player.state == STKAudioPlayerStateDisposed)
    {
        [self.playButton setImage:[UIImage imageNamed:@"toolbar_pause_n"] forState:UIControlStateNormal];
        [self.player resume];
        self.myTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(MusicProgress) userInfo:self repeats:YES];
    }else if (self.player.state == STKAudioPlayerStateStopped){
        [self playMusicSong:self.num];
    }
    else
    {
        [self.playButton setImage:[UIImage imageNamed:@"toolbar_play_n"] forState:UIControlStateNormal];
        [self.player pause];
        [self.myTimer invalidate];
    }

}
//重写set方法
-(void)setPlayArray:(NSMutableArray *)playArray{

    self.array = [NSMutableArray arrayWithArray:playArray];
    

}
-(void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}
//给锁屏后台传递信息
- (void)playButtonPress:(UIImage *)image {
    Class playingInfoCenter = NSClassFromString(@"MPNowPlayingInfoCenter");
    if (playingInfoCenter) {
        
        NSMutableDictionary *songInfo = [ [NSMutableDictionary alloc] init];
        MPMediaItemArtwork *albumArt = [ [MPMediaItemArtwork alloc] initWithImage:image];
        
        [ songInfo setObject: self.songName forKey:MPMediaItemPropertyTitle ];
        [ songInfo setObject: self.sing_name forKey:MPMediaItemPropertyArtist ];
        //音乐进度
        songInfo[MPMediaItemPropertyPlaybackDuration] = @(self.player.duration);
        //未知.
        //[songInfo setObject:[NSNumber numberWithDouble:CMTimeGetSeconds(CMTimeMakeWithSeconds((self.musicProgramSlider.value), self.player.progress))] forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime];
        
        [ songInfo setObject: albumArt forKey:MPMediaItemPropertyArtwork ];
        [ [MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:songInfo ];
    }
}
#pragma mark - 可以播放了!!!!!!!
-(void)setIndexPath:(NSInteger)indexPath{
    self.num = indexPath;

    [self playMusicSong:self.num];

}
-(void)playMusicSong:(NSInteger)num{
    if (!self.musicProgramSlider) {
        [self creatSlider];
    }
    PlayModel *model = [self.array objectAtIndex:num];
    if (model.audition_list.count == 0) {
        return;
    }else{
        self.model = model;
        //给label赋值
        self.songName= model.song_name;
        self.sing_name = model.singer_name;
        self.songNameLabel.text = self.songName;
        self.singerNameLabel.text = self.sing_name;
        //取出流畅音质
        NSLog(@"%ld",[DataHandle DataHandle].MusicQuality);
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        if ([DataHandle DataHandle].MusicQuality == 0) {
            dic = [model.audition_list firstObject];
        }else if ([DataHandle DataHandle].MusicQuality == 1){
            if (model.audition_list.count > 1 && model.audition_list.count < 3) {
                dic = [model.audition_list objectAtIndex:1];
            }else{
                dic = [model.audition_list firstObject];
            }
        }else if ([DataHandle DataHandle].MusicQuality == 2){
            if (model.audition_list.count == 3) {
                dic = [model.audition_list lastObject];
            }else{
                dic = [model.audition_list objectAtIndex:model.audition_list.count - 1];
            }
        
        }


        NSString *temp = [dic objectForKey:@"url"];
        //NSArray *strarray = [temp componentsSeparatedByString:@"?"];
       // NSString *url = strarray[0];
        //如果点击的音乐是相同的歌曲,直接return
        if ([self.url isEqualToString: temp]) {
            if (_playWithWay != PlayWithWayOneSongCirculation) {
            self.myTimer = [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(MusicProgress) userInfo:self repeats:YES];
                return;
            }
        }
        NSLog(@"---+++++++++++%@",[NSThread currentThread]);
        NSString *str = [NSString stringWithFormat:@"%@",[dic objectForKey:@"duration"]];
        [self slider:str];
        [self playMusic:temp];
        //分享的时候用的
        self.url = temp;
        //[self.songListTableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:self.num inSection:0]];
       // [self.songListTableView reloadData];
        if (self.myTimer) {
            if (self.myTimer.isValid) {//如果是开启状态
                [self.myTimer invalidate];
                self.myTimer = nil;
            }
        }
        self.myTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(MusicProgress) userInfo:self repeats:YES];
        [self getNetPic:model.singer_name];
        }
    [self.songListTableView reloadData];
    //歌单自动滚到播放的对应的歌曲
    [self.songListTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:num inSection:0]
                                animated:YES
                          scrollPosition:UITableViewScrollPositionBottom];
    [self.songListTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:num inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    //判断播放器状态
    if (self.player.state == STKAudioPlayerStatePlaying) {
        if (self.myTimer) {
            if (self.myTimer.isValid) {//如果是开启状态
                [self.myTimer invalidate];
                self.myTimer = nil;
            }
        }
    }
    _a = 0;
    
}
-(void)slider:(NSString *)str{
    if ([str rangeOfString:@":"].location != NSNotFound) {
        NSLog(@"这个字符串中有:");
        NSArray *array = [str componentsSeparatedByString:@":"];
        NSInteger min = [[array firstObject] integerValue];
        NSInteger second = [[array lastObject] integerValue];
        NSLog(@"%ld,%ld",min,second);
        self.duration =min * 60 + second;
        self.musicProgramSlider.maximumValue = self.duration;
        NSLog(@"%.2f",self.musicProgramSlider.maximumValue);
    }else{
        NSInteger time = [str integerValue];
        self.duration = time/1000;
        self.musicProgramSlider.maximumValue = self.duration;
        NSLog(@"%.2f",self.musicProgramSlider.maximumValue);
        
    }
}

//slider的触发方法
-(void)MusicProgress{
    if (!self.player) {
        return;
    }
    [DataHandle DataHandle].isPlayMusic = YES;
    NSLog(@"value = %f,duration = %f player = %f",self.musicProgramSlider.value,self.musicProgramSlider.maximumValue,self.player.duration);
   // self.musicProgramSlider.maximumValue = self.player.duration;
    self.musicProgramSlider.value = self.player.progress;
    if (self.player.state == STKAudioPlayerStatePlaying){
        [self.playButton setImage:[UIImage imageNamed:@"toolbar_pause_n"] forState:UIControlStateNormal];
    }if (self.player.state == STKAudioPlayerStatePaused || self.player.state == STKAudioPlayerStateStopped || self.player.state == STKAudioPlayerStateError || self.player.state == STKAudioPlayerStateReady || self.player.state == STKAudioPlayerStateDisposed)
    {
        [self.playButton setImage:[UIImage imageNamed:@"toolbar_play_n"] forState:UIControlStateNormal];

    }
//    NSLog(@"%f,%f",self.musicProgramSlider.value , self.player.duration);
    if (self.musicProgramSlider.maximumValue - self.player.progress < 3) {
        _a++;
        if (_a == 1) {
            NSLog(@"%ld即将播放下一曲",_playWithWay);
            //[self performSelector:@selector(nextSong) withObject:nil afterDelay:8.0f];
            if (_playWithWay == PlayWithWayOneSongCirculation) {
                NSLog(@"单曲循环");
                //[self.player stop];
                [self playMusicSong:self.num];
                return;
            }
            [self nextSong];
        }
        //[self performSelector:@selector(nextSong) withObject:nil afterDelay:8.0f];
        
    }
    
        
}



//上一首
-(void)lastSong{
    //[self closeList];
    NSLog(@"%ld",self.playWithWay);
    if (self.num == 0) {
        self.num = self.array.count;
    }
    if (self.playWithWay == PlayWithWaySole) {//如果为顺序循环播放
        if (self.player.state == STKAudioPlayerStatePlaying) {
            [self playMusicSong:--self.num];
            NSLog(@"%ld",self.array.count);
        }
    }else if (self.playWithWay == PlayWithWayRandom){
        if (self.player.state == STKAudioPlayerStatePlaying) {
            self.num = arc4random() % self.array.count;
            NSLog(@"播放%ld首",self.num - 1);
            [self playMusicSong:self.num];
        }
    
    }else if (self.playWithWay == PlayWithWayOneSongCirculation){
        if (self.player.state == STKAudioPlayerStatePlaying) {
            [self playMusicSong:--self.num];
        }
    
    }

}

//下一曲
-(void)nextSong{
    //[self.player stop];
   // [self closeList];
    if (self.playWithWay == PlayWithWaySole) {//如果为顺序循环播放
        if (self.player.state == STKAudioPlayerStatePlaying) {
            if (self.num == self.array.count - 1) {
                self.num = 0;
                [self playMusicSong:self.num];
                return;
            }
            [self playMusicSong:++self.num];
            NSLog(@"%ld",self.array.count);
        }
    }else if (self.playWithWay == PlayWithWayRandom){
        if (self.player.state == STKAudioPlayerStatePlaying) {
            self.num = arc4random() % self.array.count;
            NSLog(@"播放%ld首",self.num - 1);
            [self playMusicSong:self.num];
        }
        
    }else if (self.playWithWay == PlayWithWayOneSongCirculation){
        if (self.player.state == STKAudioPlayerStatePlaying) {
            if (self.num == self.array.count - 1) {
                self.num = 0;
                [self playMusicSong:self.num];
                return;
            }
            [self playMusicSong:++self.num];
        }
        
    }
    
}

//播放音乐
-(void)playMusic:(NSString *)str{
    //播放
    [self.player playURL:[NSURL URLWithString:str]];
}

//创建button方法
-(MusicButton *)creatButtonMethed:(CGRect)frame Title:(NSString *)title Image:(UIImage *)image{

    MusicButton *button = [MusicButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateNormal];
    //button.backgroundColor = [UIColor redColor];

    return button;

}
//
//-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    [tableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:self.num inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
//    
//    
//}

-(void)creatSongPic:(NSString *)strUrl{
    //显示歌曲图片
    
    
#pragma mark - 设置图片
    //设置图片
    //将url转成image
    NSURL *url = [NSURL URLWithString:strUrl];

    //创建系统的全局队列(子线程)
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"+++++++++++%@",[NSThread currentThread]);
        NSData *data = [NSData dataWithContentsOfURL:url];//单线程  阻塞线程
        UIImage *image = [UIImage imageWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{//回到主线程
            NSLog(@"转换完了");
            [self playButtonPress:image];
            self.SingerPic.image = image;

        });
    });
    
    //锁屏显示音乐信息
    self.SingerPic.layer.cornerRadius = 250/2;
    self.SingerPic.layer.masksToBounds = YES;//设置圆角边缘;
    self.SingerPic.layer.borderWidth = 0.1;//设置边框宽度
    self.SingerPic.layer.borderColor = [UIColor clearColor].CGColor;//边框颜色
    self.SingerPic.userInteractionEnabled = YES;
    [self createContextSheet];
    UIGestureRecognizer *gestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget: self
                                                                                           action: @selector(longPressed:)];
    [self.SingerPic addGestureRecognizer: gestureRecognizer];
}
#pragma mark - 歌手图片上的菜单需完善!!!
- (void) createContextSheet {
    VLDContextSheetItem *item1 = [[VLDContextSheetItem alloc] initWithTitle: @"喜欢"
                                                                      image: [UIImage imageNamed:@"love"]
                                                           highlightedImage: [UIImage imageNamed:@"love2"]];
    
    
    VLDContextSheetItem *item2 = [[VLDContextSheetItem alloc] initWithTitle: @"分享"
                                                                      image: [UIImage imageNamed:@"fenxiang"]
                                                           highlightedImage: [UIImage imageNamed: @"fenxiang-light"]];
    
    VLDContextSheetItem *item3 = [[VLDContextSheetItem alloc] initWithTitle: @"下载"
                                                                      image: [UIImage imageNamed: @"down_normal"]
                                                           highlightedImage: [UIImage imageNamed: @"down_press"]];
    
    self.contextSheet = [[VLDContextSheet alloc] initWithItems: @[ item1, item2 ,item3]];
    self.contextSheet.delegate = self;
}
//选择了哪个button
- (void) contextSheet: (VLDContextSheet *) contextSheet didSelectItem: (VLDContextSheetItem *) item {
    if ([item.title isEqualToString:@"分享"]) {
        
        NSString *str = [NSString stringWithFormat:@"分享 %@ 的单曲 <<%@>>:%@ (分享来自@乐听music)",self.sing_name,self.songName,self.url];
        UIImageView *image = [[UIImageView alloc] init];
        [image sd_setImageWithURL:[NSURL URLWithString:self.model.pic_url]];
        [UMSocialSnsService presentSnsIconSheetView:self
                                             appKey:@"557fcbbb67e58e3875005b64"
                                          shareText:str
                                         shareImage:image.image
                                    shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToEmail,nil]
                                           delegate:nil];
    }
    if ([item.title isEqualToString:@"喜欢"]) {
        NSMutableArray *array = [[CollectSQL shareSQL] selectAllSCPlayModel];
        for (PlayModel *model in array) {
            if ([model.song_name isEqualToString:self.model.song_name] && [model.singer_name isEqualToString:self.model.singer_name]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"已收藏过!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
                [alert show];
                return;
            }
        }
        [[CollectSQL shareSQL] insertSCMusicWithPlayModel:self.model];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"收藏成功!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
        [alert show];
        
    }
    if ([item.title isEqualToString:@"下载"]) {
        [self downloadFile:self.url];
    }
    NSLog(@"Selected item: %@", item.title);
}
//长按触发方法
- (void) longPressed: (UIGestureRecognizer *) gestureRecognizer {
    if(gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        [self.contextSheet startWithGestureRecognizer: gestureRecognizer
                                               inView: self.view];
    }
}
//触摸停止 触发方法
- (void) willRotateToInterfaceOrientation: (UIInterfaceOrientation) toInterfaceOrientation
                                 duration: (NSTimeInterval) duration {
    
    [super willRotateToInterfaceOrientation: toInterfaceOrientation duration: duration];
    
    [self.contextSheet end];
}
#pragma mark - 下载音乐
/**
 *  使用代理监控下载进度
 */
- (void)downloadFile:(NSString *)url
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:1 timeoutInterval:15];
    [[self.session downloadTaskWithRequest:request]resume];
}

#pragma mark  代理方法
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    NSString *pathFile = [NSTemporaryDirectory() stringByAppendingPathComponent:downloadTask.response.suggestedFilename];
    NSFileManager *manger = [NSFileManager defaultManager];
    [manger copyItemAtPath:location.path toPath:pathFile error:NULL];
}
// 进度数据
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    float progress = (float)totalBytesWritten / totalBytesExpectedToWrite;
    NSLog(@"%f",progress);
}

// 懒加载
- (NSURLSession *)session
{
    if(_session == nil)
    {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    }
    return _session;
}





#pragma mark -
-(void)creatSongNameLabel{
#warning - 如何让label上面的字体如果超出label显示范围  自动左右滚动
    //显示歌曲名字的label
    self.songNameLabel = [[[MusicLabel alloc] initWithFrame:CGRectMake(0, 0, 220, 20)] autorelease];
    self.songNameLabel.textAlignment = NSTextAlignmentCenter;
    self.songNameLabel.center = CGPointMake(self.view.center.x, 35);
    self.singerNameLabel = [[[MusicLabel alloc] initWithFrame:self.songNameLabel.frame] autorelease];
    self.singerNameLabel.center = CGPointMake(self.view.center.x, self.singerNameLabel.frame.origin.y + self.singerNameLabel.frame.size.height + 15);
    self.singerNameLabel.font = [UIFont systemFontOfSize:14];
    self.singerNameLabel.text = self.sing_name;
    self.singerNameLabel.textAlignment = NSTextAlignmentCenter;
    //self.songNameLabel.textAlignment = NSTextAlignmentCenter;
    self.songNameLabel.font = [UIFont systemFontOfSize:16];
    self.songNameLabel.text = self.songName;
    [self.view addSubview:self.singerNameLabel];
    [self.view addSubview:self.songNameLabel];
}

//创建返回按钮
-(void)creatBackButton{
    self.backButton = [MusicButton buttonWithType:UIButtonTypeCustom];
    //[self.backButton setTitle:@"返回" forState:UIControlStateNormal];
    [self.backButton setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
    self.backButton.frame = CGRectMake(22, 30, 30, 20);
    [self.backButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(backToMainPage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backButton];

}



//返回按钮触发方法
-(void)backToMainPage{

    [self dismissViewControllerAnimated:YES completion:^{
        //返回原界面
        [self.myDelegate viewDisplayView];
    }];

}

-(void)getNetPic:(NSString *)name{
    self.SingerPic.image = [UIImage imageNamed:@"NoPlaying"];
//    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"---------------%@",[NSThread currentThread]);
        //拼接请求网址
        NSString *urlString= [NSString stringWithFormat:@"%@",name];
        
        NSString * encodedString = (NSString *)CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)urlString, NULL, NULL,  kCFStringEncodingUTF8 );
        
        NSString * add1 = @"http://api.raventech.cn/api/music/search?album_name=&appkey=54679361&appversion=ios1.3.0&cate_type=0&client_time=2015-05-21%2015%3A28%3A39&content=";
        NSString *add2 =  @"&deviceid=86D47CC5-7337-4186-98C3-6EB77C5C8CD3&deviceusername=%25E5%25A4%25AA%25E9%2598%25B3&key=";
        NSString *str3 =  @"&network_type=1&page=1&searchtype=0&singer_name=&song_name=&type=0&zone=Asia%252FShanghai%2520%2528GMT%252B8%2529";
        NSString *superAddress = [NSString stringWithFormat:@"%@%@%@%@%@", add1,encodedString,add2,encodedString,str3];//单线程  阻塞线程
        dispatch_async(dispatch_get_main_queue(), ^{//回到主线程
            //请求网络数据
            [AFNGet GetData:superAddress block:^(id backData) {
                NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:backData];
                NSMutableDictionary *dic1 = [dic  objectForKey:@"info"];
                NSMutableArray *array = [dic1 objectForKey:@"data"];
                //NSLog(@"%@",array);
                if (array.count == 0) {
                    self.SingerPic.image = [UIImage imageNamed:@"NoPlaying"];self.SingerPic.layer.masksToBounds = NO;//设置圆角边缘;
                    return ;
                }
                NSMutableDictionary *dic2 = array[0];
                
                //设置歌手图片转盘旋转
                [self creatSongPic:[dic2 objectForKey:@"pic_url"]];
                NSLog(@"%@",[dic2 objectForKey:@"pic_url"]);
                self.model.pic_url = [dic2 objectForKey:@"pic_url"];
                
            }];

        });
    });
    
    
    
    
}
#pragma mark - 摇一摇切歌
- (BOOL)canBecomeFirstResponder
{
    
    return YES;// default is NO
}
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"开始摇动手机");
}
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"stop");
    [self nextSongWithMotion];

}
- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"取消");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"内存满了");
}

-(void)nextSongWithMotion{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *str = [defaults objectForKey:@"qiege"];
    NSLog(@"-------------------%@",str);
    if ([str isEqualToString:@"1"]) {
        NSLog(@"切歌了！");
        [self nextSong];
    }
}




@end
