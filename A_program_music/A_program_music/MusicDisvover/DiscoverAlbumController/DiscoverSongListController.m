//
//  DiscoverSongListController.m
//  A_program_music
//
//  Created by 姚天成 on 15/6/24.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "DiscoverSongListController.h"
#import "SearchOneSongCell.h"

#import "AlbumModel.h"

@interface DiscoverSongListController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,retain)NSMutableArray *playArray;
@property(nonatomic,retain)PlayingController *play;
@property(nonatomic,retain)UIImageView *pic;
@property(nonatomic,retain)MBProgressHUD *MB;
@property(nonatomic,retain)MusicTableViewController *tableview;
@property(nonatomic,retain)NSMutableArray *array;
@end

@implementation DiscoverSongListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:143.0/255 green:172.0/255 blue:193.0/255 alpha:1];
    self.array = [NSMutableArray array];
    self.tableview = [[[MusicTableViewController alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height - 20) style:UITableViewStylePlain] autorelease];
    self.tableview.backgroundColor = [UIColor colorWithRed:143.0/255 green:172.0/255 blue:193.0/255 alpha:1];
    self.tableview.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:self.tableview];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
   
}
//cell 高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}
-(void)creatPic{

    self.pic = [[[UIImageView alloc] initWithFrame:CGRectMake(0*WIDTH, 0, self.view.frame.size.width*WIDTH, 200*HEIGHT)] autorelease];
    
    [self.tableview.tableHeaderView addSubview: self.pic];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *name = @"albumlist";
    SearchOneSongCell *cell = [tableView dequeueReusableCellWithIdentifier:name];
    if (cell == nil) {
        cell = [[SearchOneSongCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:name];
    }
    cell.backgroundColor = [UIColor colorWithRed:143.0/255 green:172.0/255 blue:193.0/255 alpha:1];
    cell.album = [self.array objectAtIndex:indexPath.row];
    cell.number = [NSString stringWithFormat:@"%ld.",indexPath.row + 1];
    self.playArray = [NSMutableArray array];
    for (AlbumModel *model in self.array) {
        PlayModel *playModel = [[PlayModel alloc] init];
        playModel.song_name = model.name;
        playModel.singer_name = model.singerName;
        playModel.audition_list = model.auditionList;
        [self.playArray addObject:playModel];
    }
    return cell;


}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.play = [PlayingController PlayingBox];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.play.playArray = self.playArray;
    self.play.indexPath = indexPath.row;
    [self presentViewController:self.play animated:YES completion:^{
        
        
    }];

}


-(void)setAlbumId:(NSString *)albumId{
    self.navigationItem.title = _titleName;
    NSLog(@"%@",albumId);
    [self getdate:albumId];
    self.MB = [[MBProgressHUD alloc] initWithView:self.view];
    [self.MB setYOffset:-50];
    [self.view addSubview:self.MB];
    [self.MB setLabelText:@"玩命加载中..."];
    //self.MB.dimBackground = YES;
    [self.MB show:YES];

}
-(void)getdate:(NSString *)ID{

    [AFNGet GetData:[NSString stringWithFormat:@"http://api.dongting.com/song/album/%@",ID] block:^(id backData) {
        [self creatPic];
        NSMutableDictionary *dic = [backData objectForKey:@"data"];
//        NSLog(@"%@",dic);
        NSString *pic_url = [dic objectForKey:@"picUrl"];
        [self.pic sd_setImageWithURL:[NSURL URLWithString:pic_url] placeholderImage:[UIImage imageNamed:@"NoPlaying"]];
        NSMutableArray *array = [dic objectForKey:@"songList"];
        for (NSMutableDictionary *dic in array) {
            AlbumModel *model = [[AlbumModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            NSLog(@"%@",model.singerName);
            [self.array addObject:model];
        }
        [self.tableview reloadData];
        [self.MB hide:YES];
    } blockError:^(NSError *error) {
        
        
    }];






}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
