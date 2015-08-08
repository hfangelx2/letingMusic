

//
//  SleepViewController.m
//  A_program_music
//
//  Created by dlios on 15/6/29.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "SleepViewController.h"
#import "PlayingController.h"
#import "DXAlertView.h"

@interface SleepViewController ()
@property(nonatomic,retain)NSTimer *myTimer;
@property(nonatomic,retain)MusicTableViewController *tableview1;
@property(nonatomic,retain)NSTimer *timer;
@property(nonatomic,copy)NSString *time;
@property(nonatomic,assign)NSInteger time1;
@end

@implementation SleepViewController

+(instancetype)shareSleepHandle
{   static SleepViewController *sleepVC = nil;
    static dispatch_once_t sleep;
     dispatch_once(&sleep, ^{
         sleepVC = [[SleepViewController alloc] init];
         sleepVC.time = 0;
     });

    return sleepVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    

    
    self.tableview1 = [[MusicTableViewController alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableview1.dataSource = self;
    self.tableview1.delegate = self;
    [self.view addSubview:self.tableview1];
    self.tableview1.separatorStyle = 0;
    self.tableview1.backgroundColor = [UIColor colorWithRed:252/255.0 green:230/255.0 blue:201/255.0 alpha:1.0];
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(SleepTimeOne) userInfo:nil repeats:YES];
    
}

-(void)pushToRightMenu
{
    [self.sideMenuViewController presentRightMenuViewController];
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"mycell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"10分钟后";
       
    }
    if (indexPath.row == 1) {
        cell.textLabel.text = @"20分钟后";
        
    }
    if (indexPath.row == 2) {
        cell.textLabel.text = @"30分钟后";
        
    }
    if (indexPath.row == 3) {
        cell.textLabel.text = @"60分钟后";
        
    }
    if (indexPath.row == 4) {
        cell.textLabel.text = @"90分钟后";
    }
    cell.backgroundColor = [UIColor colorWithRed:252/255.0 green:230/255.0 blue:201/255.0 alpha:1.0];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
    [self performSelector:@selector(scale_0) withObject:nil afterDelay:10.0f*60];
        DXAlertView *dxAview = [[DXAlertView alloc] initWithTitle:@"提示" contentText:@"10分钟后关闭" leftButtonTitle:nil rightButtonTitle:@"确定"];
        [dxAview show];
        [self sleep1:10.0f * 60];
        [self popToController];
        
    }
    if (indexPath.row == 1) {
       [self performSelector:@selector(scale_0) withObject:nil afterDelay:20.0f*60];
        DXAlertView *dxAview = [[DXAlertView alloc] initWithTitle:@"提示" contentText:@"20分钟后关闭" leftButtonTitle:nil rightButtonTitle:@"确定"];
        [self sleep1:20.0f * 60];
        [dxAview show];
        [self popToController];

        
    }
    if (indexPath.row == 2) {
        [self performSelector:@selector(scale_0) withObject:nil afterDelay:30.0f*60];
        DXAlertView *dxAview = [[DXAlertView alloc] initWithTitle:@"提示" contentText:@"30分钟后关闭" leftButtonTitle:nil rightButtonTitle:@"确定"];
        [dxAview show];
        [self sleep1:30.0f * 60];
        [self popToController];

    }
    if (indexPath.row == 3) {
       [self performSelector:@selector(scale_0) withObject:nil afterDelay:60.0f*60];
        DXAlertView *dxAview = [[DXAlertView alloc] initWithTitle:@"提示" contentText:@"60分钟后关闭" leftButtonTitle:nil rightButtonTitle:@"确定"];
        [dxAview show];
        [self sleep1:60.0f * 60];
        [self popToController];

    
    }
    if (indexPath.row == 4) {
      [self performSelector:@selector(scale_0) withObject:nil afterDelay:90.0f*60];
        
        DXAlertView *dxAview = [[DXAlertView alloc] initWithTitle:@"提示" contentText:@"90分钟后关闭" leftButtonTitle:nil rightButtonTitle:@"确定"];
        [dxAview show];
        [self sleep1:90.0f * 60];
        [self popToController];

        
    }
    if (indexPath.row == 5) {
       
        
    }

    

}
//返回上一个控制器
-(void)popToController{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)scale_0
{
    PlayingController *playVC = [PlayingController PlayingBox];
    [playVC.player stop];
    exit(0);

}

-(void)sleep1:(NSInteger)time{
    
    self.time1 = time;
    if (self.myTimer) {
        if (self.myTimer.isValid) {//如果是开启状态
            [self.myTimer invalidate];
            self.myTimer = nil;
        }
    }
    
    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeProgress) userInfo:self repeats:YES];

}

-(void)timeProgress{
    NSLog(@"走没走");
    self.time1--;
    self.time = [NSString stringWithFormat:@"%d分%d秒",_time1/60,_time1%60];
    [self.myDelegate sleepTime:self.time];
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
