

//
//  SingerSongViewController.m
//  A_program_music
//
//  Created by dlios on 15/6/24.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "SingerSongViewController.h"

@interface SingerSongViewController ()

@property(nonatomic,retain)MusicTableViewController *tableview1;
@property(nonatomic,retain)UIImageView *imageview1;


@end

@implementation SingerSongViewController

-(void)viewWillAppear:(BOOL)animated
{   [super viewWillAppear:animated];
    self.imageview1.frame = CGRectMake(0, -200*HEIGHT, self.view.frame.size.width, 200*HEIGHT);

   
    
    [self.tableview1 deselectRowAtIndexPath:[self.tableview1 indexPathForSelectedRow] animated:YES];
        
        
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.view.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:250/255.0 alpha:1];
    self.tableview1 = [[MusicTableViewController alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableview1.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:250/255.0 alpha:1];
    [self.view addSubview:self.tableview1];
    self.tableview1.delegate = self;
    self.tableview1.dataSource = self;
    self.array = [NSMutableArray array];
    self.playArray = [NSMutableArray array];
    
    self.tableview1.contentInset = UIEdgeInsetsMake(200*WIDTH,
                                                   0,
                                                   0,
                                                   0);
  
    
    self.tableview1.separatorStyle = 0;
    
//    self.upLoad = NO;
    [self addHeader];
    [self addFooter];
    
    [self getImageInfo];
    
   
}

-(void)addHeader
{
    
    __block SingerSongViewController *fineVC = self;//因为block块里用self会报警告,所以需要将self声明成block变量
    self.tableview1.header =
    [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        fineVC.page = 1;//记录页码的
        fineVC.upLoad = NO;//标记为下拉操作
        [fineVC getAFNInfo:fineVC.page];//重新请求数据
        
        
    }];
    
    [self.tableview1.header beginRefreshing];
}

#pragma mark —上拉加载更多
- (void)addFooter
{
    //      __unsafe_unretained typeof(self) vc = self;
    __block SingerSongViewController *vc = self;
    
    
    self.tableview1.footer = [MJRefreshAutoNormalFooter  footerWithRefreshingBlock:^{
        vc.page ++;
        
        vc.upLoad = YES;//标记为上拉操作
        [vc getAFNInfo:vc.page];//请求数据
       
        
    }];
    
   
    
}


-(void)getAFNInfo:(NSInteger )page
{
    
    
    NSString *str = [NSString stringWithFormat:@"http://api.dongting.com/song/singer/%@/songs?page=%ld",self.singerSongModel.singer_id,page];
    
   [AFNGet GetData:str block:^(id backData) {
       NSMutableDictionary *bigDic = backData;
       
       self.pageCount = [[bigDic objectForKey:@"pageCount"] integerValue];
       
       NSMutableArray *array = [bigDic objectForKey:@"data"];
       if (self.upLoad == NO) {
           //说明是下拉，就要清空数组中的数据
           [self.array removeAllObjects];
       }
       for (NSMutableDictionary *dic in array) {
           SingerSongModel *singerSongModel = [[SingerSongModel alloc] init];
           PlayModel *playModel = [[PlayModel alloc] init];
        singerSongModel.singerName = [dic objectForKey:@"singerName"];
        singerSongModel.name = [dic objectForKey:@"name"];
           singerSongModel.audition_list = [dic objectForKey:@"auditionList"];
           playModel.singer_name = [dic objectForKey:@"singerName"];
           playModel.song_name = [dic objectForKey:@"name"];
           playModel.audition_list = [dic objectForKey:@"auditionList"];
           [self.array addObject:singerSongModel];
           [self.playArray addObject:playModel];
        }
       
       if (self.page-1 >=self.pageCount ) {
           self.tableview1.footer.hidden = YES;
           return ;
       }
       
       [self.tableview1 reloadData];
       [self.tableview1.header endRefreshing];
       [self.tableview1.footer endRefreshing];
       
   }];


}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   static NSString *identifier = @"mycell";
    SingSongTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[SingSongTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    SingerSongModel *model = [[SingerSongModel alloc] init];
    model = [self.array objectAtIndex:indexPath.row];
    cell.number = [NSString stringWithFormat:@"%ld",(indexPath.row+1)];
    
    cell.model = model;
    //cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


-(void)getImageInfo
{
    NSString *str = [NSString stringWithFormat:@"http://api.dongting.com/song/singer/%@?detail=true",self.singerSongModel.singer_id];
  [AFNGet GetData:str block:^(id backData) {
      NSMutableDictionary *bigDic = backData;
      NSMutableDictionary *midDic = [bigDic objectForKey:@"data"];
      
      self.pic = [midDic objectForKey:@"picUrl"];
     // NSString *picurl = [midDic objectForKey:@"picUrl"];
      self.imageview1 = [[[UIImageView alloc] initWithFrame:CGRectMake(0, -200*HEIGHT, self.view.frame.size.width, 200*HEIGHT)] autorelease];
      NSURL *url = nil;
     // NSLog(@"%@",self.pic);
      if ([self.pic isEqual:[NSNull null]]) {
          self.imageview1.image = [UIImage imageNamed:@"zhanweitu-1"];
      }else{
          url = [NSURL URLWithString:self.pic];
          [self.imageview1 sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"1"]];
          
      }
      
//      self.tableview1.tableHeaderView = self.imageview1;
      
      [self.tableview1 addSubview:self.imageview1];
      
      [self.tableview1 reloadData];
  }];




}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PlayingController *playVC = [PlayingController PlayingBox];
    playVC.playArray = self.playArray;
    playVC.indexPath = indexPath.row;
    
   [self presentViewController:playVC animated:YES completion:^{
       
       
   }];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // 在tableView滚动（tableView偏移量变化，即scrollView.contentOffset）的时候，让imageView随着偏移量改变而改变frame
    if (scrollView.contentOffset.y < -200*HEIGHT) { // tableView向下滚动时候，偏移量是负数；反之，偏移量是正数
        
        CGRect tempFrame = self.imageview1.frame; //通过中间量来改变imageView的frame
        
        tempFrame.origin.y = scrollView.contentOffset.y*HEIGHT; // 坐标y值随tablView的Y轴偏移量改变，结果为负数，故上移
        
        tempFrame.origin.x =((200 +scrollView.contentOffset.y) / 2)*WIDTH; // 坐标x轴随tablView的Y轴偏移量与imageView的高度的差值改变，左移
        // 除以2是保证图片横向拉伸时是以中点为基准
        
        tempFrame.size.width = (375 - (200 +scrollView.contentOffset.y))*WIDTH;//宽度随tablView的Y轴偏移量与imageView的高度的差值改变，结果为正数，变宽
        
        tempFrame.size.height = -(scrollView.contentOffset.y)*HEIGHT; // 高度随偏移量改变，结果为正数，故变长
        
        self.imageview1.frame = tempFrame;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return 60;
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
