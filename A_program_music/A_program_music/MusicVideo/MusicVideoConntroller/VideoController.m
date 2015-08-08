//
//  VideoController.m
//  A_program_music
//
//  Created by 姚天成 on 15/6/19.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "VideoController.h"


@interface VideoController ()


@property(nonatomic,retain)UITableView *tableView;
@property(nonatomic,retain)NSMutableArray *urlArray;
@property(nonatomic,retain)MBProgressHUD *MBD;

@end

@implementation VideoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.arrayModel = [NSMutableArray array];
    self.albumImgArray = [NSMutableArray array];
    self.titleArray = [NSMutableArray array];
    self.posterPicArray = [NSMutableArray array];
    self.urlArray = [NSMutableArray array];
    self.IdArray = [NSMutableArray array];
     
    self.MBD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.MBD setYOffset:-50];
    [self.view addSubview:self.MBD];
    [self.MBD setLabelText:@"正在加载中......"];
    [self.MBD show:YES];
    
    
    self.tableView = [[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 560*HEIGHT) style:UITableViewStylePlain] autorelease];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
    self.tableView.delegate = self;
    self.tableView.dataSource =self;
    self.hotDic=[NSMutableDictionary dictionary];
    
    [_hotDic setObject:@"0" forKey:@"D-A"];
    [_hotDic setObject:@"POP_ALL" forKey:@"area"];
    [_hotDic setObject:@"0" forKey:@"offset"];
    [_hotDic setObject:@"20" forKey:@"size"];
    
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
   
    self.isUpLoading =NO;
    [self getData];
    [self addFooter];
}


//---------------请求数据--------------
-(void)getData
{
   
    
   [Connect ConnectRequestAFWithURL:Popular params:_hotDic requestHeader:RequestHeader httpMethod:@"GET" block:^(NSObject *result) {
       NSMutableDictionary *bigBic = (NSMutableDictionary *)result;
       self.bigArray = [NSMutableArray array];
       self.bigArray = [bigBic objectForKeyedSubscript:@"videos"];
       
     
       
       for (NSMutableDictionary *dic in self.bigArray) {
           MusicVideoModel *MVModel = [[[MusicVideoModel alloc] init] autorelease];
           [MVModel setValuesForKeysWithDictionary:dic];
           [self.arrayModel addObject:MVModel];
           [self.albumImgArray addObject:MVModel.albumImg];
           [self.titleArray addObject:MVModel.title];
           [self.posterPicArray addObject:MVModel.posterPic];
           [self.urlArray addObject:MVModel.url];
     //  [self.artistsNameArray addObject:[MVModel.artists objectAtIndex:1]];
           NSString *strID = [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]];
           MVModel.Idd = strID;
           [self.IdArray addObject:MVModel.Idd];
           [[SqlDateBase shareSQL]insertMusicVideo:MVModel];

        }
       [self.MBD hide:YES];
       [self.tableView.header endRefreshing];
       [self.tableView.footer endRefreshing];
       [self.tableView reloadData];
       
   }];
    
    
 
    
    
    
   
}



//------------设置每区cell的个数--------------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSLog(@"--------%ld",self.albumImgArray.count);
    
   
   return self.albumImgArray.count;
    
}


//--------------自定义cell-----------
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
static NSString *celldentifier = @"myCell";
    MusicVideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:celldentifier];
    if (cell == nil) {
        cell = [[[MusicVideoTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:celldentifier] autorelease];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    if ([[self.albumImgArray objectAtIndex:indexPath.row] isEqualToString:@""]) {
        cell.picUrl = [self.posterPicArray objectAtIndex:indexPath.row];
    }else  {
        
    cell.picUrl = [self.albumImgArray objectAtIndex:indexPath.row];
    
    }
    
    cell.title = [self.titleArray objectAtIndex:indexPath.row];
    
    return cell;

}

//----------------设置cell的行高----------------
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 170*HEIGHT;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    MVPlayViewController *mvPlayVC= [[[MVPlayViewController alloc] init] autorelease];
    mvPlayVC.mydelegate = self;
    mvPlayVC.videoUrl = [self.urlArray objectAtIndex:indexPath.row];
    mvPlayVC.titleNVC = [self.titleArray objectAtIndex:indexPath.row];
    mvPlayVC.idD = [self.IdArray objectAtIndex:indexPath.row];

    NSUserDefaults *nsuD = [NSUserDefaults standardUserDefaults];
    [nsuD setObject:[self.IdArray objectAtIndex:indexPath.row] forKey:@"id"];
    
    
    [self.mydelegate hideView];
    [self.navigationController pushViewController:mvPlayVC animated:YES];
}

-(void)displayView{

    [self.mydelegate displayView];
}


//上拉刷新
-(void)addFooter
{
    __block VideoController *premierVC=self;
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
     //   premierVC.isUpLoading=YES;
        
        
        _pageNumber = _pageNumber + 20;//接口offset的值 每次增加20
        NSString *newPage = [NSString stringWithFormat:@"%ld",_pageNumber ];
        [_hotDic setObject:newPage forKey:@"offset"];
        
        premierVC.nextPage ++;
        [premierVC getData];
        
        
    }];
    
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
