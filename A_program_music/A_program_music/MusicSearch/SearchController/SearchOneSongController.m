//
//  SearchOneSongController.m
//  A_program_music
//
//  Created by 姚天成 on 15/6/21.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "SearchOneSongController.h"

@interface SearchOneSongController ()

@property(nonatomic,retain)MusicTableViewController *tableView;
@property(nonatomic,retain)PlayingController *play;
@property(nonatomic,retain)NSString *name;
@property(nonatomic,retain)NSMutableArray *playArray;

@property(nonatomic,assign)NSInteger page;
@property(nonatomic,assign)BOOL upLoad;
@property(nonatomic,assign)NSInteger pageCount;
@property(nonatomic,retain)MBProgressHUD *MB;

@end

@implementation SearchOneSongController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.play = [PlayingController PlayingBox];
    //创建tableview
    self.tableView = [[[MusicTableViewController alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height - 100) style:UITableViewStyleGrouped] autorelease];
    self.tableView.backgroundColor = [UIColor colorWithRed:143.0/255 green:172.0/255 blue:193.0/255 alpha:1];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self addHeader];
    [self addFooter];
    //菊花
    self.MB = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.MB.labelText = @"拼命加载中...";
    [self.MB show:YES];
    
    [self.view addSubview:self.tableView];
    self.array = [NSMutableArray array];
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.bounds.size.width, 0.01f)];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.array.count;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *name = @"SearchOneSong";
    SearchOneSongCell *cell = [tableView dequeueReusableCellWithIdentifier:name];
    if (cell == nil) {
        cell = [[SearchOneSongCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:name];
    }
    self.playArray = [NSMutableArray array];
    for (OneSongModel *model in self.array) {
        PlayModel *playModel = [[PlayModel alloc] init];
        playModel.song_name = model.song_name;
        playModel.singer_name = model.singer_name;
        playModel.audition_list = model.audition_list;
        [self.playArray addObject:playModel];
    }
    //cell.selectionStyle = UITableViewCellSelectionStyleNone; //（这种是没有点击后的阴影效果)
    if (self.array.count != 0) {
        OneSongModel *model = [self.array objectAtIndex:indexPath.row];
        //将model传入自定义cell中
        cell.model = model;
        //将number传进去
        cell.number = [NSString stringWithFormat:@"%ld.",indexPath.row + 1];
        NSMutableArray *array = [[CollectSQL shareSQL] selectAllSCPlayModel];
        
        if (array.count == 0) {
            cell.isCollect = NO;
                   NSLog(@"array  没值");
        }else
        {
            for (PlayModel *collect in array) {
                
                NSString *song_name = [NSString stringWithFormat:@"%@", model.song_name];
                NSString *singer_name = [NSString stringWithFormat:@"%@",model.singer_name];
                if ([collect.song_name isEqualToString:song_name] && [collect.singer_name isEqualToString:singer_name]) {
                    cell.isCollect  = YES;
                    cell.model = [self.array objectAtIndex:indexPath.row];
                             NSLog(@"判断 相同");
                    return cell;
                }
            }
            cell.isCollect = NO;
            cell.model = [self.array objectAtIndex:indexPath.row];
                NSLog(@"array 有值");
        }
    }
    
    
    
    //取消cell线
    return cell;


}



//重写set方法
-(void)setSearchName:(NSString *)searchName{
    self.name = searchName;
    [self getNetData:searchName page:1];

}

-(void)addHeader
{
    
    __block SearchOneSongController *searchOneSong = self;//因为block块里用self会报警告,所以需要将self声明成block变量
    self.tableView.header =
    [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        searchOneSong.page = 1;//记录页码的
        searchOneSong.upLoad = NO;//标记为下拉操作
        [searchOneSong getNetData:self.name page:searchOneSong.page];//重新请求数据
        
        [self.tableView.header beginRefreshing];
        
    }];
    
}

#pragma mark —上拉加载更多
- (void)addFooter
{
    //      __unsafe_unretained typeof(self) vc = self;
    __block SearchOneSongController *searchOneSong = self;
    
    
    self.tableView.footer = [MJRefreshAutoNormalFooter  footerWithRefreshingBlock:^{
        searchOneSong.page ++;
        
        searchOneSong.upLoad = YES;//标记为上拉操作
        [searchOneSong getNetData:self.name page:searchOneSong.page];//请求数据
        
        
    }];
    
    
    
}






//获取网络数据
-(void)getNetData:(NSString *)name page:(NSInteger)page{

    NSString *urlString= [NSString stringWithFormat:@"%@",name];
                          
    NSString * encodedString = (NSString *)CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)urlString, NULL, NULL,  kCFStringEncodingUTF8 );
    
    NSString *url = [NSString stringWithFormat:@"http://so.ard.iyyin.com/s/song_with_out?q=%@&page=%ld&size=50",encodedString,page];
    [AFNGet GetData:url block:^(id backData) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:backData];
        self.pageCount = [[dic objectForKey:@"pages"] integerValue];
        NSMutableArray *array = [dic objectForKey:@"data"];
        for (NSMutableDictionary *dic in array) {
            OneSongModel *model = [[[OneSongModel alloc] init] autorelease];
            [model setValuesForKeysWithDictionary:dic];
            [self.array addObject:model];
        }
        if (self.page - 1 >= self.pageCount) {
            self.tableView.footer.hidden = YES;
            return ;
        }
        [self.MB hide:YES];//隐藏菊花
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
        
        [self.tableView reloadData];

        
    }];
    
    
}
//cell 高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 60;
}
//cell点击效果
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.play.playArray = self.playArray;
    self.play.indexPath = indexPath.row;
    [self presentViewController:self.play animated:YES completion:^{
        
        
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
