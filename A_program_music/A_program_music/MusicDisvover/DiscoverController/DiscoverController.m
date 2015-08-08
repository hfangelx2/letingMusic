//
//  DiscoverController.m
//  A_program_music
//
//  Created by 姚天成 on 15/6/19.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "DiscoverController.h"
#import "DiscoverNewsongList.h"
#import "NewSongViewController.h"
#import "StrorgePlayViewController.h"
@interface DiscoverController ()
@property(nonatomic,retain)DiscoverNewSongController *Newsong;

@property(nonatomic,retain)NSMutableArray *TuiJianArray;
@property(nonatomic,retain)MBProgressHUD *MB;
@property(nonatomic,retain)DiscoverNewsongList *NewList;
@end

@implementation DiscoverController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatTableView];
    [self getPic];
    //请求网络数据
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.frame = [[UIScreen mainScreen] bounds];
    self.Newsong = [[DiscoverNewSongController alloc] init];
    self.MB = [[MBProgressHUD alloc] initWithView:self.view];
    [self.MB setYOffset:-50];
    [self.view addSubview:self.MB];
    [self.MB setLabelText:@"玩命加载中..."];
    //self.MB.dimBackground = YES;
    [self.MB show:YES];
    [self getData];
    
    [self addHeader];
    
}
-(void)addHeader
{
    
    __block DiscoverController *discoverVC = self;//因为block块里用self会报警告,所以需要将self声明成block变量
    self.tableview.header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [discoverVC getData];//重新请求数据
        
        
    }];

}
-(void)viewWillAppear:(BOOL)animated{
  //  [self.MB show:YES];
    

}


//创建TableView
-(void)creatTableView{
    
    _tableview = [[[MusicTableViewController alloc] initWithFrame:CGRectMake(0, self.scroll.frame.size.height + 5.0, self.view.frame.size.width, self.view.frame.size.height - 120)] autorelease];
    [self.view addSubview:_tableview];
    //签协议
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.backgroundColor = [UIColor whiteColor];
    //取消cell线
    [_tableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0 && indexPath.row == 0) {
        [self NewSongButtonAction];
    }else if (indexPath.section == 0 && indexPath.row == 1){
        NewSongViewController *newsong =[[[NewSongViewController alloc] init] autorelease];
        [self.navigationController pushViewController:newsong animated:YES];
    }else if(indexPath.section != 3){
        [self HotSongList:indexPath.section row:indexPath.row];
    }else if(indexPath.section == 3 && indexPath.row == 0){
        [self HotSongList:indexPath.section row:indexPath.row];
    }else{
        StrorgePlayViewController *stroragePlay = [[[StrorgePlayViewController alloc] init] autorelease];
        
        DiscoverModel *model = self.TuiJianArray[1] ;
        stroragePlay.titleA = model.name;
        stroragePlay.ID = @"0";
        
        [self.navigationController pushViewController:stroragePlay animated:YES];
#pragma mark - 需要付豪的分类详情.
    }
    NSLog(@"%@",indexPath);
    
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (self.SectionNameArray.count == 0) {
        return nil;
    }
    return  [self.SectionNameArray objectAtIndex:section];

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.SectionNameArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return self.NewSongPicArray.count;
    }
    if (section == 1) {
        return self.songListPic.count;
    }
    if (section == 2) {
        return self.otherSong.count;
    }
    if (section == 3) {
        return self.TuiJianArray.count - 1;
    }
    return 0;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *name = @"DiscoverNewMusic";
        DiscoverCell *cell = [tableView dequeueReusableCellWithIdentifier:name];
        
        if (cell == nil) {
            cell = [[[DiscoverCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:name] autorelease];
        }
        cell.model = [self.NewSongPicArray objectAtIndex:indexPath.row];
        //添加cell上右箭头
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        return cell;
    }else if(indexPath.section == 1){
        static NSString *name = @"DiscoverHotList";
        DiscoverHotList *cell = [tableView dequeueReusableCellWithIdentifier:name];
        
        if (cell == nil) {
            cell = [[[DiscoverHotList alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:name] autorelease];
        }
        cell.model = [self.songListPic objectAtIndex:indexPath.row];
        //添加cell上右箭头
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }else if(indexPath.section == 2){
        static NSString *name = @"DiscoverTuiJianList";
        DiscoverHotList *cell = [tableView dequeueReusableCellWithIdentifier:name];
        
        if (cell == nil) {
            cell = [[[DiscoverHotList alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:name] autorelease];
        }
        cell.model = [self.otherSong objectAtIndex:indexPath.row];
        //添加cell上右箭头
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }else if (indexPath.section == 3){
        static NSString *name = @"WangYouTuiJian";
        DiscoverCell *cell = [tableView dequeueReusableCellWithIdentifier:name];
        
        if (cell == nil) {
            cell = [[[DiscoverCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:name] autorelease];
        }
        cell.model = [self.TuiJianArray objectAtIndex:indexPath.row];
        //添加cell上右箭头
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        return cell;
    
    }
    
    return nil;
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 90.0;
}
//创建轮播图
-(void)getPic{
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    CGFloat wide = [UIScreen mainScreen].bounds.size.width;
    MusicView *view = [[[MusicView alloc] initWithFrame:CGRectMake(0, 0, wide, height / 4.7642)] autorelease];
    self.scroll = [[[MyScrollView alloc]initWithFrame:CGRectMake(10, 5, view.frame.size.width - 20, view.frame.size.height - 10)] autorelease];
    self.scroll.backgroundColor = [UIColor whiteColor];
    [view addSubview:self.scroll];
    //self.scroll.layer.cornerRadius = 20;
    self.tableview.tableHeaderView = view;
    

}
//删除数据库
-(void)deleteDateBase{
    NSFileManager *fileManager = [NSFileManager defaultManager];

    NSArray *array1 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [array1 lastObject];

    NSLog(@"%@", documentPath);
    [[SqlDateBase shareSQL] openDB];
   // self.technologyArray = [[DataHandle shareDataInfo]

    NSString *sqlitePath = [documentPath stringByAppendingPathComponent:@"dataBase.sqlite"];

    BOOL existResult = [fileManager fileExistsAtPath:sqlitePath];
    if(existResult){
        NSLog(@"文件已经存在");
        BOOL removeResult = [fileManager removeItemAtPath:sqlitePath error:nil];
        if(removeResult == YES){
            NSLog(@"删除成功");
        }
    }


    
}
-(void)creatDropDataBaseTable{
    [[SqlDateBase shareSQL] dropDiscoverHeader];
    [[SqlDateBase shareSQL] createDiscoverHeader];
    [[SqlDateBase shareSQL] dropDiscoverNewSong];
    [[SqlDateBase shareSQL] createDiscoverNewSong];
    [[SqlDateBase shareSQL] dropDiscoverSongList];
    [[SqlDateBase shareSQL] createDiscoverSongList];
    [[SqlDateBase shareSQL] dropDiscoverOtherSong];
    [[SqlDateBase shareSQL] createDiscoverOtherSong];
    [[SqlDateBase shareSQL] dropDiscoverTuiJian];
    [[SqlDateBase shareSQL] createDiscoverTuiJian];
    [[SqlDateBase shareSQL] dropDiscoverSectionName];
    [[SqlDateBase shareSQL] createDiscoverSectionName];

}
-(void)getDateFromDateBase{
    //打开数据库
    [[SqlDateBase shareSQL] openDB];
    //创建发现头部视图数据库表
    [[SqlDateBase shareSQL] createDiscoverHeader];
    [[SqlDateBase shareSQL] createDiscoverNewSong];
    [[SqlDateBase shareSQL] createDiscoverSongList];
    [[SqlDateBase shareSQL] createDiscoverOtherSong];
    [[SqlDateBase shareSQL] createDiscoverTuiJian];
    [[SqlDateBase shareSQL] createDiscoverSectionName];
    //取出所有值
    self.HeaderPicArray = [[SqlDateBase shareSQL] selectAllDiscoverHeader];
    self.NewSongPicArray = [[SqlDateBase shareSQL] selectAllDiscoverNewSong];
    self.songListPic = [[SqlDateBase shareSQL] selectAllDiscoverSongList];
    self.otherSong = [[SqlDateBase shareSQL] selectAllDiscoverOtherSong];
    self.TuiJianArray = [[SqlDateBase shareSQL] selectAllDiscoverTuiJian];
    self.SectionNameArray = [[SqlDateBase shareSQL] selectAllDiscoverSectionName];


}
//利用封装好的AFN解析数据
-(void)getData{
    //从数据库中获取数据
    [self getDateFromDateBase];
    [AFNGet GetData:@"http://online.dongting.com/recomm/recomm_modules" block:^(id backData) {
        //删除数据库方法
        //[self deleteDateBase];
        //网络请求成功后删除表
        [self creatDropDataBaseTable];
        self.allDic = [NSMutableDictionary dictionaryWithDictionary:backData];
        [self data];
        [self.tableview.header endRefreshing];
        [self.tableview reloadData];
    } blockError:^(NSError *error) {
        //停止定时器
        [self.scroll stopTimer];
        //赋值给轮播图
        if (self.HeaderPicArray.count != 0) {
            
            [self.scroll setImages:self.HeaderPicArray];
        }
        [self.tableview reloadData];
        [self.tableview.header endRefreshing];
        [self.MB hide:YES];
        
    }];
    

    
    
}
-(void)removeAllArray{
    [self.SectionNameArray removeAllObjects];
    [self.HeaderPicArray removeAllObjects];
    [self.NewSongPicArray removeAllObjects];
    [self.songListPic removeAllObjects];
    [self.otherSong removeAllObjects];
    [self.TuiJianArray removeAllObjects];
}
//解析数据
-(void)data{
    
    [self removeAllArray];
    NSMutableDictionary *dic = [self.allDic objectForKey:@"data"];
    NSMutableArray *array = [dic objectForKey:@"songlists"];

    NSMutableDictionary *dicForHeader = [array objectAtIndex:0];
    NSMutableArray *array1 = [dicForHeader objectForKey:@"data"];
    for (NSMutableDictionary *dic in array1) {
        DiscoverModel *model = [[DiscoverModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [self.HeaderPicArray addObject:model];
        [[SqlDateBase shareSQL] insertDiscoverHeader:model];
    }
    NSMutableDictionary *dic2 = [array objectAtIndex:2];
    NSLog(@"%@",dic2);
    [self.SectionNameArray addObject:[dic2 objectForKey:@"name"]];
    [[SqlDateBase shareSQL] insertDiscoverSectionName:[dic2 objectForKey:@"name"]];
    NSMutableArray *array2 = [dic2 objectForKey:@"data"];
    for (NSMutableDictionary *dic in array2) {
        DiscoverModel *model = [[DiscoverModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [self.NewSongPicArray addObject:model];
        NSLog(@"%@",model.name);
        [[SqlDateBase shareSQL] insertDiscoverNewSong:model];
    }

    NSMutableDictionary *dic3 = [array objectAtIndex:1];
    [self.SectionNameArray addObject:[dic3 objectForKey:@"name"]];
    [[SqlDateBase shareSQL] insertDiscoverSectionName:[dic3 objectForKey:@"name"]];
    NSMutableArray *array3 = [dic3 objectForKey:@"data"];
    for (NSMutableDictionary *dic in array3) {
        DiscoverModel *model = [[DiscoverModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [self.songListPic addObject:model];
        [[SqlDateBase shareSQL] insertDiscoverSongList:model];
    }
    
    NSMutableDictionary *dic4 = [array objectAtIndex:3];
    [self.SectionNameArray addObject:[dic4 objectForKey:@"name"]];
    [[SqlDateBase shareSQL] insertDiscoverSectionName:[dic4 objectForKey:@"name"]];
    NSMutableArray *array4 = [dic4 objectForKey:@"data"];
    for (NSMutableDictionary *dic in array4) {
        DiscoverModel *model = [[DiscoverModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [self.otherSong addObject:model];
        [[SqlDateBase shareSQL] insertDiscoverOtherSong:model];
    }
    
    NSMutableDictionary *dic5 = [array objectAtIndex:7];
    [self.SectionNameArray addObject:[dic5 objectForKey:@"name"]];
    [[SqlDateBase shareSQL] insertDiscoverSectionName:[dic5 objectForKey:@"name"]];
    NSMutableArray *array5 = [dic5 objectForKey:@"data"];
    for (NSMutableDictionary *dic in array5) {
        DiscoverModel *model = [[DiscoverModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [self.TuiJianArray addObject:model];
        NSLog(@"%@",model.name);
        [[SqlDateBase shareSQL] insertDiscoverTuiJian:model];
    }
#warning 暂时未解决下拉刷新导致轮播图跳图
        [self.scroll stopTimer];
        [self.scroll setImages:self.HeaderPicArray];
        [self.MB hide:YES];
}

//uitableview处理section的不悬浮，禁止section停留的方法，主要是这段代码
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 50;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

-(void)NewSongButtonAction{
    [AFNGet GetData:@"http://online.dongting.com/recomm/new_songlists" block:^(id backData) {
        NSMutableArray *tempArray = [NSMutableArray array];
        NSMutableArray *array = [backData objectForKey:@"data"];
        for (NSMutableDictionary *dic in array) {
            NSString *msg_id = [dic objectForKey:@"msg_id"];
            [tempArray addObject:msg_id];
        }
        self.Newsong.idArray = tempArray;
    }];
    [self.navigationController pushViewController:self.Newsong animated:YES];
}

-(void)HotSongList:(NSInteger)section row:(NSInteger)row{

    NSMutableArray *array = [NSMutableArray array];
    if (section == 1) {
        array = [NSMutableArray arrayWithArray:self.songListPic];
    }
    if (section == 2) {
        array = [NSMutableArray arrayWithArray:self.otherSong];
    }
    if (section == 3) {
        array = [NSMutableArray arrayWithArray:self.TuiJianArray];
    }
    self.NewList = [[[DiscoverNewsongList alloc] init] autorelease];
    self.NewList.model = [array objectAtIndex:row];;
    [self.navigationController pushViewController:_NewList animated:YES];

    

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
