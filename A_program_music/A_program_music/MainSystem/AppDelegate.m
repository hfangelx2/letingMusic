//
//  AppDelegate.m
//  A_program_music
//
//  Created by 姚天成 on 15/6/19.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "AppDelegate.h"
#import "UMSocial.h"
#import "SearchController.h"
#import "DXAlertView.h"
#import "ZWIntroductionViewController.h"

@interface AppDelegate ()
@property(nonatomic,retain)UIImageView *PlayingRoundView;
@property(nonatomic,retain)PlayingController *play;
@property(nonatomic,retain)ZWIntroductionViewController *introductionView;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [UMSocialData setAppKey:@"557fcbbb67e58e3875005b64"];
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [DataHandle DataHandle].MusicQuality = [userDefault integerForKey:@"MusicQuality"];
    
    [self startNetWork];
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
//    根式图
     MusicSetViewController *setVC = [[MusicSetViewController alloc] init];
    
//    主视图放在根视图上
    self.main = [[[MainViewController alloc] init] autorelease];
    self.main.mydelegate = self;
    MusicNavigationController *nav = [[MusicNavigationController alloc] initWithRootViewController:_main];
  
    RESideMenu *sideMenuViewController = [[RESideMenu alloc] initWithContentViewController:nav
                                                                    leftMenuViewController:nil
                                                                   rightMenuViewController:setVC];
    
    self.window.rootViewController = sideMenuViewController;
    
    sideMenuViewController.backgroundImage = [UIImage imageNamed:@"12"];
    
    
    
    
    
    
    
    
//小圆点
    self.PlayingRoundView = [[[UIImageView alloc] initWithFrame:CGRectMake(self.window.frame.size.width - 60, self.window.frame.size.height - 50, 30, 30)] autorelease];
    self.PlayingRoundView.layer.cornerRadius = 15;
    self.PlayingRoundView.backgroundColor = [UIColor clearColor];
    self.PlayingRoundView.image = [UIImage imageNamed:@"yinle"];
    [self.window addSubview:self.PlayingRoundView];
    self.PlayingRoundView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap  = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ToPlayingPage)] autorelease];
    [self.PlayingRoundView addGestureRecognizer:tap];
    self.PlayingRoundView.alpha = 0.7;
    UIPanGestureRecognizer * panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                            action:@selector(doHandlePanAction:)];
    [self.PlayingRoundView addGestureRecognizer:panGestureRecognizer];
    
    [DataHandle DataHandle].point = self.PlayingRoundView.frame.origin;
    self.play = [PlayingController PlayingBox];
    self.play.myDelegate = self;
    
    NSUserDefaults *isFirst = [NSUserDefaults standardUserDefaults];
    NSInteger a = [isFirst integerForKey:@"first"];
    if (a == 0) {
    NSArray *coverImageNames = @[@"tm1", @"tm2", @"tm3"];
    NSArray *backgroundImageNames = @[@"leting1", @"leting2", @"leting4"];
    self.introductionView = [[ZWIntroductionViewController alloc] initWithCoverImageNames:coverImageNames backgroundImageNames:backgroundImageNames];
    
    [self.window addSubview:self.introductionView.view];
    __weak AppDelegate *weakSelf = self;
    self.introductionView.didSelectedEnter = ^() {
        [weakSelf.introductionView.view removeFromSuperview];
        weakSelf.introductionView = nil;
        NSUserDefaults *isFirst = [NSUserDefaults standardUserDefaults];
        //存储时，除NSNumber类型使用对应的类型意外，其他的都是使用setObject:forKey:
        [isFirst setInteger:1 forKey:@"first"];
    };
    }
    [self builtStart];
    return YES;
}
- (void) doHandlePanAction:(UIPanGestureRecognizer *)paramSender{
    
    CGPoint point = [paramSender translationInView:self.PlayingRoundView];
    NSLog(@"%f,%f",point.x,point.y);
    [DataHandle DataHandle].point = self.PlayingRoundView.frame.origin;
    paramSender.view.center = CGPointMake(paramSender.view.center.x + point.x, paramSender.view.center.y + point.y);
    
    if ( paramSender.view.frame.origin.x < 0 || paramSender.view.frame.origin.y < 0 || paramSender.view.frame.origin.x + paramSender.view.frame.size.width >[UIScreen mainScreen].bounds.size.width || paramSender.view.frame.origin.y + paramSender.view.frame.size.height > [UIScreen mainScreen].bounds.size.height) {
        
        [MusicView animateWithDuration:1 animations:^{
          paramSender.view.frame = CGRectMake(self.window.frame.size.width - 60, self.window.frame.size.height - 50, 30, 30);
        }];
    }
    
    [paramSender setTranslation:CGPointMake(0, 0) inView:self.PlayingRoundView];
    
    
}
//开始网络监听
-(void)startNetWork{
    Reachability* reach = [Reachability reachabilityWithHostname:@"leting"];
    NSLog(@"-- current status: %@", reach.currentReachabilityString);
    
    // start the notifier which will cause the reachability object to retain itself!
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    [reach startNotifier];
}
- (void) reachabilityChanged: (NSNotification*)note {
    Reachability * reach = [note object];
    NSString *str = @"";
    if(![reach isReachable])
    {
        str = @"No";
//        DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"提示" contentText:@"无网络,请检查网络链接" leftButtonTitle:nil rightButtonTitle:@"好的"];        
//        [alert show];
        NSLog(@"网络不可用");
        [[NSNotificationCenter defaultCenter]postNotificationName:@"IsNetWork" object:str];
        return;
    }
    str = @"Yes";
    [[NSNotificationCenter defaultCenter]postNotificationName:@"IsNetWork" object:str];
    NSLog(@"网络可用");
    NSString *Wifi = @"";
    if (reach.isReachableViaWiFi) {
        Wifi = @"Yes";
        [[NSNotificationCenter defaultCenter]postNotificationName:@"IsWifi" object:Wifi];
        NSLog( @"当前通过wifi连接");
    } else {
        Wifi = @"No";
        [[NSNotificationCenter defaultCenter]postNotificationName:@"IsWifi" object:Wifi];
        NSLog( @"wifi未开启，不能用");
    }
    NSString *Mobile3G = @"";
    if (reach.isReachableViaWWAN) {
        Mobile3G = @"Yes";
        [[NSNotificationCenter defaultCenter]postNotificationName:@"Is3gOr2g" object:Mobile3G];
        NSLog( @"当前通过2g or 3g连接");
    } else {
        Mobile3G = @"No";
        [[NSNotificationCenter defaultCenter]postNotificationName:@"Is3gOr2g" object:Mobile3G];
        NSLog( @"2g or 3g网络未使用");
    }
}


//播放页面的模态方法
-(void)ToPlayingPage{

#warning - 由二级界面跳转至播放页面有问题!!
    
    UINavigationController *nav = (UINavigationController *)self.window.rootViewController;
    NSLog(@"模态播放页面");
    [nav presentViewController:self.play animated:YES completion:^{
        [MusicView animateWithDuration:1.0 animations:^{
            self.PlayingRoundView.alpha = 0;
        }];
//        [MusicView animateWithDuration:1.0 animations:^{
//
//            self.PlayingRoundView.frame = CGRectMake(-90, self.window.frame.size.height - 50, 30, 30);
//        }];
        
    }];
    
    

}
- (void)builtStart
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(-20, 0, self.window.frame.size.width+40, self.window.frame.size.height)];
    
    imageView.image = [UIImage imageNamed:@"open"];

    [self.window addSubview:imageView];
    
    UILabel *label =[[[UILabel alloc]initWithFrame:CGRectMake(self.window.frame.origin.x+100, self.window.frame.origin.y+100, self.window.frame.size.width-200 + 40, self.window.frame.size.height-500)] autorelease];
    label.text = @"           听见,\n            你的音乐";
    label.textColor =[UIColor whiteColor];
    label.numberOfLines = 0;
    
    [self.window addSubview:label];
    
    [UIView animateWithDuration:1 animations:^{
        imageView.center = CGPointMake(imageView.center.x+20, imageView.center.y);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:2 animations:^{
            
            imageView.center = CGPointMake(imageView.center.x-20, imageView.center.y);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:1 animations:^{
                imageView.alpha = 0;
                //                imageLogo.alpha = 0;
            } completion:^(BOOL finished) {
                [label removeFromSuperview];
                [imageView removeFromSuperview];
                
            }];
        }];
    }];
}
-(void)viewDisplayView{

    [MusicView animateWithDuration:1.0 animations:^{
        self.PlayingRoundView.alpha = 0.7;
        self.PlayingRoundView.frame = CGRectMake([DataHandle DataHandle].point.x,[DataHandle DataHandle].point.y, 30, 30);
    }];

}
-(void)hideRoundView{
    [MusicView animateWithDuration:1.0 animations:^{
        
        self.PlayingRoundView.alpha = 0;
        //self.PlayingRoundView.frame = CGRectMake(-90, self.window.frame.size.height - 50, 30, 30);
        [MusicView animateWithDuration:1.0 animations:^{
            
            self.PlayingRoundView.frame = CGRectMake(-90, self.window.frame.size.height - 50, 30, 30);
        }];
        
    }];
    

}

// ---------------------------------------
- (void)sideMenu:(RESideMenu *)sideMenu willShowMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"willShowMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

- (void)sideMenu:(RESideMenu *)sideMenu didShowMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"didShowMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

- (void)sideMenu:(RESideMenu *)sideMenu willHideMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"willHideMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

- (void)sideMenu:(RESideMenu *)sideMenu didHideMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"didHideMenuViewController: %@", NSStringFromClass([menuViewController class]));
}


//监听锁屏系统按键方法
- (void)remoteControlReceivedWithEvent:(UIEvent *)event
{
    if (event.type == UIEventTypeRemoteControl) {
        switch (event.subtype) {
            case UIEventSubtypeRemoteControlPlay:
                [[PlayingController PlayingBox].player resume]; // 播放
                break;
                
            case UIEventSubtypeRemoteControlPause:
                [[PlayingController PlayingBox].player pause];//暂停
                break;
                
            case UIEventSubtypeRemoteControlPreviousTrack:
                [[PlayingController PlayingBox] lastSong]; // 播放上一曲按钮
                break;
                
            case UIEventSubtypeRemoteControlNextTrack:
                [[PlayingController PlayingBox]nextSong]; // 播放下一曲按钮
                break;
                
            default:
                break;
        }
    }
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    //开始后台
    NSError* error;
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:&error];
    //[application beginBackgroundTaskWithExpirationHandler:nil];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
