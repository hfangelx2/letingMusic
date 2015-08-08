//
//  SetViewController.m
//  A_program_music
//
//  Created by dlios on 15/6/29.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "SetViewController.h"

@interface SetViewController ()

@property(nonatomic,retain)UITableView *tableview1;
@property(nonatomic,retain)MusicView *aboutMeView;
@property(nonatomic,copy)NSString *time;
@end

@implementation SetViewController


+(instancetype)ShareSetHandle
{
    static SetViewController *setVC = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
         setVC = [[SetViewController alloc] init];
        
    });
    return setVC;
 

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"about_arrow"] style:UIBarButtonItemStyleDone target:self action:@selector(pushToRightMenu)] autorelease];
    self.navigationItem.title = @"设置";
    
    self.tableview1 = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableview1.dataSource = self;
    self.tableview1.delegate = self;
    [self.view addSubview:self.tableview1];
    self.tableview1.separatorStyle = 0;
    self.tableview1.backgroundColor = [UIColor colorWithRed:252/255.0 green:230/255.0 blue:201/255.0 alpha:1.0];
    
    
    self.aboutMeView = [[MusicView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height/2)];
    self.aboutMeView.backgroundColor = [UIColor whiteColor];
    UIImageView *imageview1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"aboutMe"]]  ;
    [self.aboutMeView addSubview:imageview1];
    [self.view addSubview:self.aboutMeView];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10*WIDTH, 10*HEIGHT, (self.view.frame.size.width - 20)*WIDTH, 100*HEIGHT)];
    label1.numberOfLines = 0;
    label1.text = @"我们是一群ios爱好开发者,本着交流技术的精神开发此app.如有侵犯了您的权益,请及时与我们取得联系.我们将尽快处理.\n邮箱:hfangelx2@163.com";
    [self.aboutMeView addSubview:label1];

    self.str = @"流畅音质";
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [DataHandle DataHandle].MusicQuality = [userDefault integerForKey:@"MusicQuality"];
    
    if ([DataHandle DataHandle].MusicQuality == 0) {
        self.str = @"流畅音质";
    }
    if ([DataHandle DataHandle].MusicQuality == 1) {
        self.str = @"普通音质";
    }
    if ([DataHandle DataHandle].MusicQuality == 2) {
        self.str = @"高品音质";
    }

    
    
    
    
    
}

-(void)pushToRightMenu
{
    [self.sideMenuViewController presentRightMenuViewController];
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 5;
}
-(void)sleepTime:(NSString *)time{
    self.time = time;
    NSLog(@"1234567890");
    [self.tableview1 reloadData];
}
-(NSString *)time{
    if (!_time) {
        self.time = @"";
    }
    return _time;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   static NSString *identifier = @"mycell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    if (indexPath.row == 0) {
        if (!self.time) {
            cell.textLabel.text = @"睡眠";
        }else{
        cell.textLabel.text = [NSString stringWithFormat:@"睡眠                    %@",self.time];
        }
    }
    if (indexPath.row == 1) {
        
        NSString *string = [NSString stringWithFormat:@"音质选择             %@",self.str];
        cell.textLabel.text = string;
        
    }
    if (indexPath.row == 2) {
        cell.textLabel.text = @"摇一摇换歌";
        UISwitch *switchview = [[UISwitch alloc] initWithFrame:CGRectZero];
        [switchview addTarget:self action:@selector(updateSwitch:) forControlEvents:UIControlEventValueChanged];
        cell.accessoryView = switchview;
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        NSString *str = [userDefault objectForKey:@"qiege"];
        if ([str isEqualToString:@"1"]) {
            switchview.on = YES;
        }else{
            switchview.on = NO;
        }
        [switchview release];
    }
    if (indexPath.row == 3) {
        NSUInteger inter = [[SDImageCache sharedImageCache] getSize];
        CGFloat MB = inter/1024.0/1024.0;
        NSString *string = [NSString stringWithFormat:@"清除缓存             缓存%.2fMB",MB];
        cell.textLabel.text = string ;
//        [self.tableview1 reloadData];
    }
    if (indexPath.row == 4) {
        cell.textLabel.text = @"关于我们";

    }
    
    cell.backgroundColor = [UIColor colorWithRed:252/255.0 green:230/255.0 blue:201/255.0 alpha:1.0];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)updateSwitch:(UISwitch *)switchView{
   // NSLog(@"%ld",switchView.on);
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    if (switchView.on) {
        NSLog(@"开启切歌");
        [userDefault setObject:@"1" forKey:@"qiege"];
    }else if (!switchView.on){
        NSLog(@"关闭切歌");
        [userDefault setObject:@"0" forKey:@"qiege"];
    }

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        SleepViewController *sleepVC = [SleepViewController shareSleepHandle];
        sleepVC.myDelegate = self;
        [self.navigationController pushViewController:sleepVC animated:YES];
    }
    
    if (indexPath.row == 1) {
        TimbreViewController *timbreVC = [[TimbreViewController alloc] init];
        timbreVC.mydelegate = self;
        [self.navigationController pushViewController:timbreVC animated:YES];
    }
    
    if (indexPath.row == 3) {
     
        
        NSUInteger inter = [[SDImageCache sharedImageCache] getSize];
        CGFloat MB = inter/1024.0/1024.0;
        NSString *string = [NSString stringWithFormat:@"%.2f",MB];

        
        
        NSString *str = [NSString stringWithFormat:@"缓存大小%@MB,确定要清除缓存吗?",string];

        
        UIAlertView *aView = [[UIAlertView alloc] initWithTitle:nil message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [aView show];
        

        
    }
    if (indexPath.row == 4 ) {
        
        [UIView animateWithDuration:1.0 animations:^{
            if (self.getBack == 0) {
                self.aboutMeView.transform = CGAffineTransformMakeTranslation(0, -self.view.frame.size.height/2);
            }
            if (self.getBack == 1) {
                self.aboutMeView.transform = CGAffineTransformMakeTranslation(0, self.view.frame.size.height/2);
               
            }
            
            self.getBack = !self.getBack;
            
        }];
        
        
    }

}

- (long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [[SDImageCache sharedImageCache] clearDisk];

        [self.tableview1 reloadData];
    }
   

}


-(void)sendMessageToSet:(NSString *)string
{
   
    self.str = [NSString stringWithString:string];
    [self.tableview1 reloadData];

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
