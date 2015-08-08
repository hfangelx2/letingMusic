//
//  MVXGViewController.m
//  A_program_music
//
//  Created by dlios on 15/6/26.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "MVXGViewController.h"

@interface MVXGViewController ()

@property(nonatomic,retain)MusicTableViewController *tableView;
@property(nonatomic,retain)NSMutableArray *XgMvArray;
@property(nonatomic,retain)NSMutableArray *titleArray;
@property(nonatomic,retain)NSMutableArray *artNameArray;
@property(nonatomic,retain)NSMutableArray *IDArray;
@property(nonatomic,retain)NSMutableArray *albumImgArray;
@property(nonatomic,retain)NSMutableArray *urlArray;
@property(nonatomic,retain)NSMutableArray *modelArray;
@property(nonatomic,copy)NSString *artName2;
@property(nonatomic,retain)NSMutableArray *artArray2;


@end

@implementation MVXGViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.XgMvArray = [NSMutableArray array];
    self.titleArray = [NSMutableArray array];
    self.artNameArray = [NSMutableArray array];
    self.IDArray = [NSMutableArray array];
    self.albumImgArray = [NSMutableArray array];
    self.urlArray = [NSMutableArray array];
    self.modelArray =[NSMutableArray array];
    self.artArray2 = [NSMutableArray array];
    
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    //设置tableView
    self.tableView = [[[MusicTableViewController alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 337*HEIGHT) style:UITableViewStylePlain] autorelease];
    self.tableView.backgroundColor = [UIColor colorWithRed:143.0/255 green:172.0/255 blue:193.0/255 alpha:1];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self getData];
  
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 80*HEIGHT;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *celldentifire =@"myCell";
    MVXGVideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:celldentifire];
    if (cell == nil) {
        cell = [[[MVXGVideoTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:celldentifire] autorelease];
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.songName = [self.titleArray objectAtIndex:indexPath.row];
    cell.artName = [self.artArray2 objectAtIndex:indexPath.row];
    cell.picUrl = [self.albumImgArray objectAtIndex:indexPath.row];
    
    return cell;

}

-(void)getData
{
  
 
 NSMutableDictionary *askerDic = [NSMutableDictionary dictionary];
 [askerDic setObject:@"0" forKey:@"D-A"];
 
 [askerDic setObject:self.ID forKey:@"id"];
   
 [askerDic setObject:@"true" forKey:@"relatedVideos"];
 [askerDic setObject:@"true" forKey:@"supportHtml"];
    
 
 [Connect ConnectRequestAFWithURL:VIDEODETAIL params:askerDic requestHeader:RequestHeader httpMethod:@"GET" block:^(NSObject *result) {
 NSMutableDictionary *bigDic = (NSMutableDictionary *)result;
     self.XgMvArray = [NSMutableArray array];
     self.XgMvArray = [bigDic objectForKey:@"relatedVideos"];
     for (NSMutableDictionary *dic in self.XgMvArray) {
         MVXGModel *xgModel = [[[MVXGModel alloc] init] autorelease];
         [xgModel setValuesForKeysWithDictionary:dic];
         [self.modelArray addObject:xgModel];
         [self.albumImgArray addObject:xgModel.albumImg];
         [self.titleArray addObject:xgModel.title];
         [self.urlArray addObject:xgModel.url];
         xgModel.ID =[NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]];
         [self.IDArray addObject:xgModel.ID];
         
         self.artNameArray = [dic objectForKey:@"artists"];
         for (NSMutableDictionary *artDic in self.artNameArray) {
             self.artName2 = [artDic objectForKey:@"artistName"];
             [self.artArray2 addObject:self.artName2];
         }
       
         
     }
  
         [self.tableView reloadData];
  
 
 
    }];

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    self.ID = [self.IDArray objectAtIndex:indexPath.row];
    
    [self.myDelegate presdent:self.ID];
    
    [self.titleArray removeAllObjects];
    [self.urlArray removeAllObjects];
    [self.albumImgArray removeAllObjects];
    [self.artArray2 removeAllObjects];
    [self.IDArray removeAllObjects];
    [self.tableView reloadData];
    [self getData];
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
