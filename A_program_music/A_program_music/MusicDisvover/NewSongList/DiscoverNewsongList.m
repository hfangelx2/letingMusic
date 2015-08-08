//
//  DiscoverNewsongList.m
//  A_program_music
//
//  Created by 姚天成 on 15/6/25.
//  Copyright © 2015年 CHD. All rights reserved.
//

#import "DiscoverNewsongList.h"

@interface DiscoverNewsongList ()
@property(nonatomic,retain)NSMutableArray *array;
@property(nonatomic,retain)MusicTableViewController *tableView;
@property(nonatomic,retain)NSMutableArray *playArray;
@property(nonatomic,retain)PlayingController *play;
@property(nonatomic,retain)MBProgressHUD *MB;
@property(nonatomic,retain)MusicView *headerView;
@property(nonatomic,retain)UIImageView *pic;
@property(nonatomic,copy)NSString *pic_url;
@property(nonatomic,retain)UIImageView *NoNetWorkView;
@end

@implementation DiscoverNewsongList

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:143.0/255 green:172.0/255 blue:193.0/255 alpha:1];
    self.tableView = [[[MusicTableViewController alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain] autorelease];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor colorWithRed:143.0/255 green:172.0/255 blue:193.0/255 alpha:1];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self creatPic];
    [self.view addSubview:self.tableView];
    self.MB = [[MBProgressHUD alloc] initWithView:self.view];
    [self.MB setYOffset:-50];
    [self.view addSubview:self.MB];
    [self.MB setLabelText:@"玩命加载中..."];
    [self.MB show:YES];
    self.tableView.contentInset = UIEdgeInsetsMake(200*WIDTH,
                                                    0*HEIGHT,
                                                    0*WIDTH,
                                                    0*HEIGHT);

    
}

-(void)creatPic{
    //self.headerView = [[[MusicView alloc] initWithFrame:CGRectMake(0, 2, self.view.frame.size.width, 135)] autorelease];
    self.pic = [[[UIImageView alloc] initWithFrame:CGRectMake(0*WIDTH, -200*HEIGHT, self.view.frame.size.width*WIDTH, 200*HEIGHT)] autorelease];
    self.pic.image = [UIImage imageNamed:@"zhanweitu-1"];

    
    //[self.headerView addSubview:self.pic];
    [self.tableView addSubview: self.pic];

}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // 在tableView滚动（tableView偏移量变化，即scrollView.contentOffset）的时候，让imageView随着偏移量改变而改变frame
    if (scrollView.contentOffset.y < -200) { // tableView向下滚动时候，偏移量是负数；反之，偏移量是正数
        
        CGRect tempFrame = self.pic.frame; //通过中间量来改变imageView的frame
        
        tempFrame.origin.y = scrollView.contentOffset.y; // 坐标y值随tablView的Y轴偏移量改变，结果为负数，故上移
        
        tempFrame.origin.x =(200 +scrollView.contentOffset.y) / 2; // 坐标x轴随tablView的Y轴偏移量与imageView的高度的差值改变，左移
        // 除以2是保证图片横向拉伸时是以中点为基准
        
        tempFrame.size.width = 375 - (200 +scrollView.contentOffset.y);//宽度随tablView的Y轴偏移量与imageView的高度的差值改变，结果为正数，变宽
        
        tempFrame.size.height = -(scrollView.contentOffset.y); // 高度随偏移量改变，结果为正数，故变长
        //NSLog(@"%f,%f",tempFrame.size.width,tempFrame.size.height);
        self.pic.frame = tempFrame;
    }
}

-(void)viewWillAppear:(BOOL)animated{
    //[self.MB show:YES];
    //[self.MB hide:YES afterDelay:0.5];
}
-(NSInteger)numberOfSectionsInTableView:(nonnull UITableView *)tableView{

    return 1;
}
-(NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *name = @"list";
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
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.play = [PlayingController PlayingBox];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.play.playArray = self.playArray;
    self.play.indexPath = indexPath.row;
    [self presentViewController:self.play animated:YES completion:^{
        
        
    }];
    
    
    
}
//重写set方法
-(void)setModel:(DiscoverModel *)model{
    if (_model != model) {
        [_model release];
        _model = [model retain];
    }
    [self getDate];
}

-(void)getDate{

    [AFNGet GetData:[NSString stringWithFormat:@"http://v1.ard.q.itlily.com/share/user_timeline?msg_ids=%@",_model.Listid] block:^(id backData) {
        
        // NSLog(@"%@",backData);
        NSMutableArray *data = [backData objectForKey:@"data"];
        NSMutableDictionary *temp = [data firstObject];
        NSMutableArray *array2 = [temp objectForKey:@"pics"];
        self.pic_url = [array2 firstObject];
        NSMutableArray *array = [temp objectForKey:@"songlist"];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        NSString *str = @"";
        NSString *tempStr = nil;
        if (array.count == 0) {
            dic = [temp objectForKey:@"song"];
            str = [dic objectForKey:@"song_id"];
        }else{
            for (NSMutableDictionary *tempDic in array) {
                tempStr = [NSString stringWithFormat:@"%@",[tempDic objectForKey:@"song_id"]];
                str = [NSString stringWithFormat:@"%@,%@",tempStr,str];
            }
        }
        self.navigationItem.title = _model.name;
        if([str hasPrefix:@","]){
            str = [str substringToIndex:[str length] - 1];
        }
        [AFNGet GetData:[NSString stringWithFormat:@"http://ting.hotchanson.com/songs/downwhite?song_id=%@",str] block:^(id backData) {
            //NSLog(@"%@",backData);
            [self.view bringSubviewToFront:self.tableView];
            NSMutableArray *array = [backData objectForKey:@"data"];
            self.array = [NSMutableArray array];
            for (NSMutableDictionary *dic in array) {
                OneSongModel *model = [[[OneSongModel alloc] init] autorelease];
                [model setValuesForKeysWithDictionary:dic];
                [self.array addObject:model];
            }
            [self.tableView reloadData];
            //隐藏小菊花
            [self.MB hide:YES];
            [self.pic sd_setImageWithURL:[NSURL URLWithString:self.pic_url]placeholderImage:[UIImage imageNamed:@"zhanweitu-1"]];
            NSLog(@"%@",self.pic_url);
        }blockError:^(NSError *error) {
            [self.MB hide:YES];
            NSLog(@"第二层失败");
        }];
    }blockError:^(NSError *error) {
        [self.MB hide:YES];
        NSLog(@"第一层失败");
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
