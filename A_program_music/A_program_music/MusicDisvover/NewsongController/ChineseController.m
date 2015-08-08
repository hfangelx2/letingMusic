//
//  ChineseController.m
//  A_program_music
//
//  Created by 姚天成 on 15/6/24.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "ChineseController.h"

@interface ChineseController ()
@property(nonatomic,retain)NSString *ID;
@property(nonatomic,retain)NSMutableArray *array;
@property(nonatomic,retain)MusicTableViewController *tableView;
@property(nonatomic,retain)PlayingController *play;
@property(nonatomic,retain)NSMutableArray *playArray;
@property(nonatomic,retain)MBProgressHUD *MB;
@end

@implementation ChineseController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:143.0/255 green:172.0/255 blue:193.0/255 alpha:1];
    self.tableView = [[[MusicTableViewController alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height - 108) style:UITableViewStylePlain] autorelease];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    self.MB = [[MBProgressHUD alloc] initWithView:self.view];
    [self.MB setYOffset:-50];
    [self.view addSubview:self.MB];
    [self.MB setLabelText:@"玩命加载中..."];
    //self.MB.dimBackground = YES;
    [self.MB show:YES];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.array.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *name = @"chinese";
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
-(void)setIDD:(NSString *)IDD{

    self.ID = IDD;
    [self getNetData];

}
-(void)getNetData{

    [AFNGet GetData:[NSString stringWithFormat:@"http://v1.ard.q.itlily.com/share/user_timeline?msg_ids=%@",self.ID] block:^(id backData) {
        self.view.backgroundColor = [UIColor colorWithRed:143.0/255 green:172.0/255 blue:193.0/255 alpha:1];
        NSMutableArray *array = [backData objectForKey:@"data"];
        NSMutableDictionary *dic = [array firstObject];
        NSMutableArray *temp = [dic objectForKey:@"songlist"];
#warning 伟大的拼接!
        NSString *str = @"";
        NSString *tempStr = nil;
        for (NSMutableDictionary *tempDic in temp) {
            tempStr = [NSString stringWithFormat:@"%@",[tempDic objectForKey:@"song_id"]];
            str = [NSString stringWithFormat:@"%@,%@",tempStr,str];
        }
        str = [str substringToIndex:[str length] - 1];
        NSLog(@"%@",str);
        [AFNGet GetData:[NSString stringWithFormat:@"http://ting.hotchanson.com/songs/downwhite?song_id=%@",str]block:^(id backData) {
           NSMutableArray *array = [backData objectForKey:@"data"];
            self.array = [NSMutableArray array];
            for (NSMutableDictionary *dic in array) {
                OneSongModel *model = [[[OneSongModel alloc] init] autorelease];
                [model setValuesForKeysWithDictionary:dic];
                [self.array addObject:model];
            }
            [self.tableView reloadData];
            [self.MB hide:YES afterDelay:1];
            //NSLog(@" 华语%@",self.array)
        }blockError:^(NSError *error) {
            [self.MB hide:YES];
            //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"network-disabled"]];
            
        }];
        
        
        
    }blockError:^(NSError *error) {
        
        [self.MB hide:YES];
    }
     ];

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
