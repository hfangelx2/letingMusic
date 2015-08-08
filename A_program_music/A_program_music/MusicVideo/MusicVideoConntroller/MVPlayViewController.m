//
//  MVPlayViewController.m
//  A_program_music
//
//  Created by dlios on 15/6/23.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "MVPlayViewController.h"
#import "KrVideoPlayerController.h"


@interface MVPlayViewController ()
@property(nonatomic,retain)KrVideoPlayerController *videoController;

@property(nonatomic,retain)UISegmentedControl *segment;

@property(nonatomic,copy)NSString *urld;
@property(nonatomic,retain)MBProgressHUD *MBD;
@property(nonatomic,assign)NSInteger switchA;

@end

@implementation MVPlayViewController

- (void)viewDidLoad {
    
    self.switchA = 0;
    [super viewDidLoad];
    
   
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUISegmentController];
   
    self.view.backgroundColor = [UIColor colorWithRed:143.0/255 green:172.0/255 blue:193.0/255 alpha:1];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(leftAction)];
    
    
    self.MBD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.MBD setYOffset:-50];
    [self.view addSubview:self.MBD];
    [self.MBD setLabelText:@"正在加载中......"];
    [self.MBD show:YES];
     [self getData];
   
}




//-------容器视图控制器UISegmentController-------
-(void)setUISegmentController
{
    
    NSArray *array = [NSArray arrayWithObjects:@"MV描述",@"相关MV", nil];
    
    self.segment = [[[UISegmentedControl alloc]initWithItems:array] autorelease];
    
    [self.view addSubview:_segment];
    
    
    
     _segment.frame =CGRectMake(10*WIDTH, 285*HEIGHT, self.view.frame.size.width -20*WIDTH, 40*HEIGHT);
    
     _segment.tintColor = [UIColor whiteColor];
    
     _segment.layer.cornerRadius = 2;
    
    [_segment addTarget:self action:@selector(segmentAction) forControlEvents:UIControlEventValueChanged ];
    
    
//    //设置系统单例
//    NSUserDefaults *nsuD = [NSUserDefaults standardUserDefaults];
//    
//    self.strid = [nsuD objectForKey:@"id"];
    
  //默认segment为0
    _segment.selectedSegmentIndex = 0;
    
  
  
    //设置相关MV界面
    self.MVXViewVC = [[[MVXGViewController alloc] init] autorelease];
    
    [self addChildViewController:self.MVXViewVC];
    
    
    self.MVXViewVC.ID = self.idD;
    [self.view addSubview:self.MVXViewVC.view];
    
    self.MVXViewVC.view.frame = CGRectMake(0, 330*HEIGHT, self.view.frame.size.width, 500*HEIGHT);
    
    
    
    
    //设置MV详情面描述界面
    
    self.MVDetailVC= [[[MVDetailViewController alloc] init] autorelease];
    
    [self addChildViewController:self.MVDetailVC];
    
   // [self setMVDetailVCValue];
    
    self.MVDetailVC.ID =self.idD;
    
    [self.view addSubview:self.MVDetailVC.view];
    
    self.MVDetailVC.view.frame = CGRectMake(0, 330*HEIGHT, self.view.frame.size.width, 500*HEIGHT);

    
 //   [self setMVXViewVCValue];
    [self.view bringSubviewToFront:self.MVDetailVC.view];
    
    self.MVXViewVC.myDelegate =self;
}

/*
-(void)setMVXViewVCValue
{
self.MVXViewVC.ID = self.strid;

}
-(void)setMVDetailVCValue
{
self.MVDetailVC.ID = self.strid;
}
*/





-(void)leftAction
{
  
    [self.videoController stop ];
    [self.mydelegate displayView];
    self.switchA = 1;
    [self.navigationController popViewControllerAnimated:YES];

}



-(void)segmentAction
{
  
    if (_segment.selectedSegmentIndex == 0) {
        
        [self.view bringSubviewToFront:self.MVDetailVC.view];
        [self.view bringSubviewToFront:self.videoController.view];
        
    }else{
    
        [self.view bringSubviewToFront:self.MVXViewVC.view];
        [self.view bringSubviewToFront:self.videoController.view];
        
    }

}


//-------------------请求数据------------------------
-(void)getData
{
    
    NSLog(@"请求数据刚开始self.swfich的值%ld",self.switchA);

    NSMutableDictionary *askerDic = [NSMutableDictionary dictionary];
    
    [askerDic setObject:@"0" forKey:@"D-A"];
    
    [askerDic setObject:self.idD forKey:@"id"];
    
    [askerDic setObject:@"true" forKey:@"relatedVideos"];
    
    [askerDic setObject:@"true" forKey:@"supportHtml"];
    
    [Connect ConnectRequestAFWithURL:VIDEODETAIL params:askerDic requestHeader:RequestHeader httpMethod:@"GET" block:^(NSObject *result) {
        
          NSMutableDictionary *dic = (NSMutableDictionary *)result;
        
          self.urld = [dic objectForKey:@"url"];

         self.titleNVC = [dic objectForKey:@"title"];
        
         self.navigationItem.title = self.titleNVC;
        
        [self.MBD hide:YES];
        
        
        if (self.switchA == 0) {
            [self playVideo];
            NSLog(@"0000000000音乐播放了");
        }
        NSLog(@"请求完数据self.swtich的值%ld",self.switchA);
      
      

    }];

  
}



//---------------第三方视频播放---------
-(void)playVideo
{
        NSURL *url = [NSURL URLWithString:self.urld];
    
        [self addVideoPlayerWithURL:url];

}


- (void)addVideoPlayerWithURL:(NSURL *)url{
    
         if (!self.videoController) {
        
         CGFloat width = [UIScreen mainScreen].bounds.size.width;
        
         self.videoController = [[[KrVideoPlayerController alloc] initWithFrame:CGRectMake(0, 64*HEIGHT, width, width*(9.0/16.0))] autorelease];
        
        __weak typeof(self)weakSelf = self;
        
         [self.videoController setDimissCompleteBlock:^{
            
            weakSelf.videoController = nil;
            
        }];
        [self.videoController setWillBackOrientationPortrait:^{
            
            [weakSelf toolbarHidden:NO];
            
        }];
        [self.videoController setWillChangeToFullscreenMode:^{
            
            [weakSelf toolbarHidden:YES];
            
        }];
        
         [self.view addSubview:self.videoController.view];
        
    }
    
          self.videoController.contentURL = url;
    
  
   
}



//隐藏navigation tabbar 电池栏
- (void)toolbarHidden:(BOOL)Bool{
    
    self.navigationController.navigationBar.hidden = Bool;
    
    self.tabBarController.tabBar.hidden = Bool;
    
    [[UIApplication sharedApplication] setStatusBarHidden:Bool withAnimation:UIStatusBarAnimationFade];
}


//---------------------自己签订的协议方法---------------------
-(void)presdent:(NSString *)idStr
{

    self.idD = idStr;
    
    [self getData];
    
    self.MVDetailVC.ID =self.idD;
    
    [self playVideo];
  
    [self.view bringSubviewToFront:self.videoController.view];
    
     self.navigationItem.title = self.titleNVC;
    
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
  
}

@end
