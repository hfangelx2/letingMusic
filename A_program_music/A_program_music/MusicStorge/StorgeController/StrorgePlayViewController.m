//
//  StrorgePlayViewController.m
//  A_program_music
//
//  Created by dlios on 15/6/29.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "StrorgePlayViewController.h"
#import "PlayingController.h"
#import "PlayModel.h"

@interface StrorgePlayViewController ()
@property (nonatomic,retain)MusicTableViewController *tableView;
@property(nonatomic,retain)NSMutableArray *bigArray;
@property(nonatomic,retain)NSMutableArray *modelArray;
@property(nonatomic,retain)NSMutableArray *nameArray;
@property(nonatomic,retain)NSMutableArray *singerNameArray;
@property(nonatomic,retain)NSMutableArray *playMArray;
@property(nonatomic,retain)MBProgressHUD *MBD;
@end

@implementation StrorgePlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    [self getData:self.page];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = self.titleA;
    
    self.tableView = [[MusicTableViewController alloc] initWithFrame:[[UIScreen mainScreen] bounds] style: UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.modelArray = [NSMutableArray array];
    self.nameArray = [NSMutableArray array];
    self.singerNameArray = [NSMutableArray array];
    
    self.playMArray = [NSMutableArray array];
    self.MBD= [[MBProgressHUD alloc] initWithView:self.view];
    [self.MBD setYOffset:-50];
    [self.view addSubview:self.MBD];
    [self.MBD setLabelText:@"正在加载中..."];
    [self.MBD show:YES];
    [self addfooter];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.nameArray.count;
    

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *celldentifire =@"myCell";
    StrorgePlayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:celldentifire];
    if (cell == nil) {
        cell = [[[StrorgePlayTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:celldentifire] autorelease];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    for ( NSInteger i = 1; i < self.nameArray.count+1; i++) {
        
        if (indexPath.row == (i-1)) {
            cell.labelNumber.text = [NSString stringWithFormat:@"%ld",i];
        }
        
    }
   
//    cell.labelSongName.text = [self.nameArray objectAtIndex:indexPath.row];
//    cell.labelSingerName.text = [self.singerNameArray objectAtIndex:indexPath.row];
    self.model = [self.modelArray objectAtIndex:indexPath.row];
    cell.storgeModel = self.model;
    
    
    
    return cell;


}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 57;

}

-(void)getData:(NSInteger)page
{
  
    [AFNGet GetData:[NSString stringWithFormat:@"http://api.dongting.com/channel/channel/%@/songs?size=50&page=%ld",self.ID,self.page] block:^(id backData) {
        NSString *str123 = [NSString stringWithFormat:@"http://api.dongting.com/channel/channel/%@/songs?size=50&page=%ld",self.ID,self.page];
        NSLog(@"wangzhiaaaaaaaaaa%@",str123);
        NSMutableDictionary *dicBig = backData;
        self.bigArray = [dicBig objectForKey:@"data"];
        for (NSMutableDictionary *dic in self.bigArray) {
            self.model = [[[StorgePlayModel alloc] init] autorelease];
            [self.model setValuesForKeysWithDictionary:dic];
            self.model.singerName = [dic objectForKey:@"singerName"];
            self.model.name = [dic objectForKey:@"name"];
           self.model.auditionList = [dic objectForKey:@"auditionList"];
            [self.modelArray addObject:self.model];
            PlayModel *playM = [[[PlayModel alloc] init] autorelease];
            playM.song_name = self.model.name;
            playM.singer_name = self.model.singerName;
            playM.audition_list = [dic objectForKey:@"auditionList"];
            [self.playMArray addObject:playM];
            self.pageCount = [[dicBig objectForKey:@"pageCount"] integerValue];
            [self.nameArray addObject:self.model.name];
           
            
        }
        if (self.page-1 >=self.pageCount ) {
            self.tableView.footer.hidden = YES;
            return ;
        }
        
        [self.tableView reloadData];
        [self.MBD hide:YES];
        
             [self.tableView.footer endRefreshing];
    }];

    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    PlayingController *playVC = [PlayingController PlayingBox];
    
    playVC.playArray = [NSMutableArray arrayWithArray:self.playMArray];
    playVC.indexPath = indexPath.row;
    
   [self presentViewController:playVC animated:YES completion:^{
     
   }];
     
    
}

-(void)addfooter
{
  
    //      __unsafe_unretained typeof(self) vc = self;
    __block StrorgePlayViewController *vc = self;
    
    
    self.tableView.footer = [MJRefreshAutoNormalFooter  footerWithRefreshingBlock:^{
        vc.page ++;
      
        vc.upLoad = YES;//标记为上拉操作
        [vc getData:vc.page];//请求数据
        
        
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
