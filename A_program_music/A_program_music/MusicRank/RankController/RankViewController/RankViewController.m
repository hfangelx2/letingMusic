//
//  RankViewController.m
//  A_program_music
//
//  Created by dlios on 15/6/19.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "RankViewController.h"
#import "DXAlertView.h"

@interface RankViewController ()

@property(nonatomic,retain)MBProgressHUD *HUD;

@end

@implementation RankViewController

-(void)dealloc
{
    [_allArray release];
    [_tableView release];
    [_threeArray release];
    [_HUD release];
    [super dealloc];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[[MusicTableViewController alloc] initWithFrame:[[UIScreen mainScreen]bounds] style:UITableViewStylePlain] autorelease];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.navigationItem.title = @"排行";
    
    self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.HUD.labelText = @"正在加载";
    [self.HUD show:YES];
    
    
    [self afnGetRequest];
   
    
    
    
    
}

-(void)afnGetRequest
{
    
    
    
    AFNetworkReachabilityManager *netWorkManager = [AFNetworkReachabilityManager sharedManager];
    
    
    NSString *url_string = [NSString stringWithFormat:@"http://v1.ard.tj.itlily.com/ttpod?a=getnewttpod&id=281&app=ttpod&v=v7.9.4.2015052918&uid="];
    
    
    //[NSSet setWithObjects:@"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html",nil];  代表支持所有的接口类型
    
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html",nil];
    [manager GET:url_string parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [netWorkManager stopMonitoring];
        //        NSLog(@"使用AFN进行get请求 ===  %@",responseObject);
        NSMutableDictionary *bigDic = responseObject;
        NSMutableArray *array = [bigDic objectForKey:@"data"];
        self.allArray = [NSMutableArray array];

//        self.threeArray = [NSMutableArray array];
        for (NSMutableDictionary *dic in array) {


            RankModel *rankmodel = [[RankModel alloc] init];
            rankmodel.title = [dic objectForKey:@"title"];
            rankmodel.pic_url = [dic objectForKey:@"pic_url"];
            rankmodel.number = [dic objectForKey:@"id"];
            rankmodel.details = [dic objectForKey:@"details"];
            self.threeArray = [dic objectForKey:@"songlist"];
            
            rankmodel.array = self.threeArray;
            [self.allArray addObject:rankmodel];
            [rankmodel release];
            
            [self.HUD hide:YES];
            
        }  [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
//        NSLog(@"失败==== %@",error);
        [self.HUD hide:YES];
        DXAlertView *alertView  =[[DXAlertView alloc] initWithTitle:@"提示" contentText:@"网络连接失败" leftButtonTitle:nil rightButtonTitle:@"确定"];
        [alertView show];
    }];
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    return self.allArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *identififer = @"mycell";
    RankTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identififer];
    if (cell == nil) {
        cell = [[[RankTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identififer] autorelease];
    }
    
    RankModel *rankmodel = [[RankModel alloc] init];
    rankmodel = [self.allArray objectAtIndex:indexPath.row];
    
    cell.model = rankmodel;
    
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = 0;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return 130;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RankDitailViewController *rankDitailVC = [[RankDitailViewController alloc] init];
    RankModel *rankmodel = [[RankModel alloc] init];
    rankmodel = [self.allArray objectAtIndex:indexPath.row];
    
    rankDitailVC.rankmodel = rankmodel ;
    
    [rankmodel release];
    
    [self.navigationController pushViewController:rankDitailVC animated:YES];

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
