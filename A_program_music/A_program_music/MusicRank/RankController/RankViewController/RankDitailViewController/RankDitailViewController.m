//
//  RankDitailViewController.m
//  A_program_music
//
//  Created by dlios on 15/6/20.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "RankDitailViewController.h"

@interface RankDitailViewController ()

@end

@implementation RankDitailViewController

-(void)dealloc
{
    [_tableView release];
    [_rankmodel release];
    [_array release];
    [_timer release];
    [_visualEfView release];
    [super dealloc];

}

-(void)viewWillAppear:(BOOL)animated
{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    


}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = self.rankmodel.title;
    self.tableView = [[[MusicTableViewController alloc] initWithFrame:[[UIScreen mainScreen]bounds] style:UITableViewStylePlain] autorelease];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
   
    
//  头视图
    UIImageView *imageview = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width*WIDTH, 160*HEIGHT)] autorelease];
    
    
     self.tableView.tableHeaderView = imageview; //    创建头部区域
    
    NSURL *url = [NSURL URLWithString:self.rankmodel.pic_url];
    [imageview sd_setImageWithURL:url placeholderImage:nil];
//   设置毛玻璃效果
    self.visualEfView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
        self.visualEfView.backgroundColor = [UIColor colorWithRed:0.05 green:0.05 blue:0.05 alpha:0.3];
    self.visualEfView.frame = imageview.frame;
    self.visualEfView.alpha = 0;
    [imageview addSubview:self.visualEfView];
    [self.visualEfView release];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(showProgress) userInfo:nil repeats:YES];
    UIImageView *aview = [[UIImageView alloc] initWithFrame:CGRectMake(140*WIDTH, 25*HEIGHT, 80*WIDTH, 80*HEIGHT)];
  
    [self.visualEfView addSubview:aview];
    [aview release];
    [aview sd_setImageWithURL:url placeholderImage:nil];
    
    MusicLabel *label1 = [[MusicLabel alloc] initWithFrame:CGRectMake(80*WIDTH, 115*HEIGHT, 200*WIDTH, 30*HEIGHT)];
    [self.visualEfView addSubview:label1];
    label1.font = [UIFont systemFontOfSize:18];
    label1.text = self.rankmodel.title;
    label1.textColor = [UIColor whiteColor];
    [label1 release];
    
    self.array = [NSMutableArray array];
    self.playArray = [NSMutableArray array];

    
    
    [self addHeader];
    [self addFooter];

    
    
  
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   static NSString *identifier = @"mycell";
    RankDitailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[RankDitailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
        
    }
    RankDitailModel *rankDitailmodel = [[RankDitailModel alloc] init];
    rankDitailmodel = [self.array objectAtIndex:indexPath.row];
    rankDitailmodel.number = [NSString stringWithFormat:@"%ld",indexPath.row+1];
    
    cell.rankDitailmodel = rankDitailmodel;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{


    return 60;
}

-(void)showProgress
{
    
    
    self.visualEfView.alpha = self.visualEfView.alpha+0.1 ;
    
    
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PlayingController *playVC = [PlayingController PlayingBox];
    
    playVC.playArray = self.playArray;
    playVC.indexPath = indexPath.row;
    
   [self presentViewController:playVC animated:YES completion:^{
       
       
   }];
    
}


-(void)addHeader
{
     
    __block RankDitailViewController *fineVC = self;//因为block块里用self会报警告,所以需要将self声明成block变量
    self.tableView.header =
    [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        fineVC.nextPage = 1;//记录页码的
        fineVC.upLoad = NO;//标记为下拉操作
        [fineVC createDate:fineVC.nextPage];//重新请求数据
        
        
    }];
    
    [self.tableView.header beginRefreshing];
}

#pragma mark —上拉加载更多
- (void)addFooter
{
    //      __unsafe_unretained typeof(self) vc = self;
    __block RankDitailViewController *vc = self;
    
    
    self.tableView.footer = [MJRefreshAutoNormalFooter  footerWithRefreshingBlock:^{
        vc.nextPage ++;
        vc.upLoad = YES;//标记为上拉操作
        [vc createDate:vc.nextPage];//请求数据
        
    }];
    
    
}

-(void)createDate:(NSInteger)nextPage
{

    // afn请求数据
     NSString *str1 = [NSString stringWithFormat:@"http://api.dongting.com/channel/ranklist/%@/songs?page=%ld",self.rankmodel.number,nextPage];
    NSLog(@"%@",str1);
    [ AFNGet GetData:str1  block:^(id backData) {
        NSMutableDictionary *bigDic = backData;
        NSMutableArray *array = [bigDic objectForKey:@"data"];
        
        if (self.upLoad == NO) {
            //说明是下拉，就要清空数组中的数据
            [self.array removeAllObjects];
        }
        for (NSMutableDictionary *dic in array) {
            RankDitailModel *rankDitailmodel = [[RankDitailModel alloc] init];
            PlayModel *playmodel = [[PlayModel alloc] init];
            rankDitailmodel.name = [dic objectForKey:@"name"];
            rankDitailmodel.singerName = [dic objectForKey:@"singerName"];
            rankDitailmodel.auditionList = [dic objectForKey:@"auditionList"];
            playmodel.song_name = [dic objectForKey:@"name"];
            playmodel.singer_name = [dic objectForKey:@"singerName"];
            playmodel.audition_list = [dic objectForKey:@"auditionList"];
            [self.array addObject:rankDitailmodel];
            [self.playArray addObject:playmodel];
            
        }
        NSInteger number = [[bigDic objectForKey:@"pageCount"] integerValue];
        if (nextPage-1 >= number) {
            self.tableView.footer.hidden = YES;
            return ;
        }
        
        
        [self.tableView reloadData];

        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
        
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
