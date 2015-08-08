

//
//  TimbreViewController.m
//  A_program_music
//
//  Created by dlios on 15/6/29.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "TimbreViewController.h"
#import "DXAlertView.h"

@interface TimbreViewController ()

@property(nonatomic,retain)MusicTableViewController *tableview1;

@end

@implementation TimbreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableview1 = [[MusicTableViewController alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableview1.dataSource = self;
    self.tableview1.delegate = self;
    [self.view addSubview:self.tableview1];
    self.tableview1.separatorStyle = 0;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{


    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"mycell";
    MusicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MusicTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"流畅音质";
    }
    if (indexPath.row == 1) {
        cell.textLabel.text = @"普通音质";
    }
    if (indexPath.row == 2) {
        cell.textLabel.text = @"高品音质";
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    if (indexPath.row == 0) {
        [DataHandle DataHandle].MusicQuality = 0;
       NSString *string = @"流畅音质";
    [self.mydelegate sendMessageToSet:string];
    [userDefault setInteger:[DataHandle DataHandle].MusicQuality forKey:@"MusicQuality"];
        DXAlertView *aView = [[DXAlertView alloc] initWithTitle:nil contentText:@"流畅音质设置成功" leftButtonTitle:nil rightButtonTitle:@"确定"];
        [aView show];
        [self popToController];
        
    }
    if (indexPath.row == 1) {
        [DataHandle DataHandle].MusicQuality = 1;
        NSString *string = @"普通音质";
        [self.mydelegate sendMessageToSet:string];
         [userDefault setInteger:[DataHandle DataHandle].MusicQuality forKey:@"MusicQuality"];
        DXAlertView *aView = [[DXAlertView alloc] initWithTitle:nil contentText:@"普通音质设置成功" leftButtonTitle:nil rightButtonTitle:@"确定"];
        [aView show];
        [self popToController];
    }
    if (indexPath.row == 2) {
        [DataHandle DataHandle].MusicQuality = 2;
        NSString *string = @"高品音质";
        [self.mydelegate sendMessageToSet:string];
         [userDefault setInteger:[DataHandle DataHandle].MusicQuality forKey:@"MusicQuality"];
        DXAlertView *aView = [[DXAlertView alloc] initWithTitle:nil contentText:@"高品音质设置成功" leftButtonTitle:nil rightButtonTitle:@"确定"];
        [aView show];
        [self popToController];

    }
    
}

-(void)popToController{
    [self.navigationController popViewControllerAnimated:YES];
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
