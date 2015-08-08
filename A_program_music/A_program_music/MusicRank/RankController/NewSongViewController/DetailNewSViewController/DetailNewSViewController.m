


//
//  DetailNewSViewController.m
//  A_program_music
//
//  Created by dlios on 15/6/24.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "DetailNewSViewController.h"
#import "DXAlertView.h"

@interface DetailNewSViewController ()

@property(nonatomic,retain)MusicTableViewController *tableview1;
@property(nonatomic,retain)MBProgressHUD *HUD;


@end

@implementation DetailNewSViewController

-(void)dealloc
{
    [_array release];
    [_allStrArray release];
    [_playArray release];
    [_scrollArray release];
    [_tableview1 release];
    [_HUD release];
    [super dealloc];

}

-(void)viewWillAppear:(BOOL)animated
{
    [self.tableview1 deselectRowAtIndexPath:[self.tableview1 indexPathForSelectedRow] animated:YES];
    
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:143.0/255 green:172.0/255 blue:193.0/255 alpha:1];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableview1 = [[[MusicTableViewController alloc] initWithFrame:[[UIScreen mainScreen]bounds] style:UITableViewStylePlain] autorelease];
    self.tableview1.dataSource = self;
    self.tableview1.delegate = self;
    [self.view addSubview:self.tableview1];
//    [_tableview1 release];
    self.tableview1.backgroundColor = [UIColor colorWithRed:143.0/255 green:172.0/255 blue:193.0/255 alpha:1];
    NewSongScrollView *scroll = [[NewSongScrollView alloc] initWithFrame:CGRectMake(0*WIDTH, 60*HEIGHT, self.view.frame.size.width, 180*HEIGHT)];
    self.tableview1.tableHeaderView = scroll;
    scroll.backgroundColor = [UIColor yellowColor];
    [scroll setImages:self.scrollArray];
    self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.HUD.labelText = @"正在加载";
    [self.HUD show:YES];
    [self getWebsetInfo];
//    NSLog(@"%@",self.scrollArray);
    self.tableview1.separatorStyle = 0;
    [scroll release];
    
    
}

-(void)getWebsetInfo
{
    
    self.array = [NSMutableArray array];
    self.playArray = [NSMutableArray array];
    NSString *str = [NSString stringWithFormat:@"http://v1.ard.q.itlily.com/share/user_timeline?msg_ids=%@",self.detailNewSongModel.msg_id];
    [AFNGet GetData:str block:^(id backData) {
        NSMutableDictionary *bigDic = backData;
        NSMutableArray *array = [bigDic objectForKey:@"data"];
        self.allStrArray = [NSMutableArray array];
        for (NSMutableDictionary *dic in array) {
            NSMutableArray *songListArray = [dic objectForKey:@"songlist"];
            for (NSMutableDictionary *smallDic in songListArray) {
                NSString *str = [smallDic objectForKey:@"song_id"];
                [self.allStrArray addObject:str];
                
            }
            
        }
        NSString *str1 = [self.allStrArray componentsJoinedByString:@","];
        NSString *str2 = [NSString stringWithFormat:@"http://ting.hotchanson.com/songs/downwhite?song_id=%@",str1];
     [AFNGet GetData:str2 block:^(id backData) {
         
         NSMutableDictionary *bigDic = backData;
         NSMutableArray *array = [bigDic objectForKey:@"data"];
         for (NSMutableDictionary *dic in array) {
             DetailNewSongModel *detailNSModel = [[DetailNewSongModel alloc] init];
             PlayModel *playModel = [[PlayModel alloc] init];
             detailNSModel.singer_name = [dic objectForKey:@"singer_name"];
             detailNSModel.album_name = [dic objectForKey:@"song_name"];
             detailNSModel.audition_list = [dic objectForKey:@"url_list"];
             
             playModel.song_name = [dic objectForKey:@"song_name"];
             playModel.singer_name = [dic objectForKey:@"singer_name"];
             playModel.audition_list = [dic objectForKey:@"url_list"];
             [self.playArray addObject:playModel];
             [self.array addObject:detailNSModel];
             [detailNSModel release];
             [playModel release];
             [self.HUD hide:YES];
         }
         [self.tableview1 reloadData];

         
         
     } blockError:^(NSError *error) {
       

     }];
        
    } blockError:^(NSError *error) {
        [self.HUD hide:YES];
        DXAlertView *alertView  =[[DXAlertView alloc] initWithTitle:@"提示" contentText:@"网络连接失败" leftButtonTitle:nil rightButtonTitle:@"确定"];
        [alertView show];

        
    }];
    
    
    
 }


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{


    return self.array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   static NSString *identifier = @"mycell";
    detailNSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[detailNSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
    }
    DetailNewSongModel *model = [[DetailNewSongModel alloc] init];
    model = [self.array objectAtIndex:indexPath.row];
    model.indexpath = indexPath;
    cell.detailNewSongModel = model;
   // cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PlayingController *playVC = [PlayingController PlayingBox];
    playVC.playArray = self.playArray;
    playVC.indexPath = indexPath.row;
//    [playVC release];
    [self presentViewController:playVC animated:YES completion:^{
        
        
    }];
}














- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 60;
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
