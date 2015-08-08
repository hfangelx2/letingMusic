
//
//  SingerDetailViewController.m
//  A_program_music
//
//  Created by dlios on 15/6/23.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "SingerDetailViewController.h"
#import "DXAlertView.h"

@interface SingerDetailViewController ()

@property(nonatomic,retain)MusicTableViewController *tableview;
@property(nonatomic,retain)NSMutableArray *array;
@property(nonatomic,retain)MBProgressHUD *HUD;

@end

@implementation SingerDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableview = [[[MusicTableViewController alloc] initWithFrame:[[UIScreen mainScreen]bounds] style:UITableViewStylePlain] autorelease];
    [self.view addSubview:self.tableview];
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
    self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.HUD.labelText = @"正在加载";
    [self.HUD show:YES];
    
    self.navigationItem.title = self.singermodel.title;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self getAfnInfo];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *identifier = @"mycell";
    SingerDetailViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[SingerDetailViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    }

    SingerDetailModel *detailModel = [[SingerDetailModel alloc] init];
    detailModel = [self.array objectAtIndex:indexPath.row];
    
    cell.detailModel = detailModel;
    
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{


    return 70;
}


-(void)getAfnInfo
{

    NSString *str = [NSString stringWithFormat:@"http://v1.ard.tj.itlily.com/ttpod?a=getnewttpod&id=%@",self.singermodel.number];
   
    
/*  [AFNGet GetData:str block:^(id backData) {
      NSMutableDictionary *bigDic = backData;
      NSMutableArray *array = [bigDic objectForKey:@"data"];
      self.array = [NSMutableArray array];
      for (NSMutableDictionary *dic in array) {
          SingerDetailModel *singDetailModel = [[SingerDetailModel alloc] init];
          singDetailModel.singer_name = [dic objectForKey:@"singer_name"];
          singDetailModel.pic_url = [dic objectForKey:@"pic_url"];
          singDetailModel.number = [dic objectForKey:@"singer_id"];
          [self.array addObject:singDetailModel];
         
      }
      [self.tableview reloadData];
  }];
*/

    [AFNGet GetData:str block:^(id backData) {
        NSMutableDictionary *bigDic = backData;

        NSMutableArray *array = [bigDic objectForKey:@"data"];
        self.array = [NSMutableArray array];
        for (NSMutableDictionary *dic in array) {
            SingerDetailModel *singDetailModel = [[SingerDetailModel alloc] init];
            singDetailModel.singer_name = [dic objectForKey:@"singer_name"];
            singDetailModel.pic_url = [dic objectForKey:@"pic_url"];
            singDetailModel.number = [dic objectForKey:@"singer_id"];
            [self.array addObject:singDetailModel];
            
            [self.HUD hide:YES];
        }
        [self.tableview reloadData];
        
    } blockError:^(NSError *error) {
        [self.HUD hide:YES];
        DXAlertView *alertView  =[[DXAlertView alloc] initWithTitle:@"提示" contentText:@"网络连接失败" leftButtonTitle:nil rightButtonTitle:@"确定"];
        [alertView show];
        [alertView release];

        
    }];
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SingerSongViewController *singerSongVC = [[SingerSongViewController alloc] init];
    SingerDetailModel *singDetailModel = [[SingerDetailModel alloc] init];
    singDetailModel = [self.array objectAtIndex:indexPath.row];
    singerSongVC.singerSongModel = [[SingerSongModel alloc] init];
    singerSongVC.singerSongModel.singer_id = singDetailModel.number;
    [self.navigationController pushViewController:singerSongVC animated:YES];


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
