//
//  SearchAlbumController.m
//  A_program_music
//
//  Created by 姚天成 on 15/6/21.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "SearchAlbumController.h"
#import "DiscoverSongListController.h"
@interface SearchAlbumController ()

@property(nonatomic,retain)MusicTableViewController *tableView;

@end

@implementation SearchAlbumController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[[MusicTableViewController alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height - 100) style:UITableViewStyleGrouped] autorelease];
    self.tableView.backgroundColor = [UIColor colorWithRed:143.0/255 green:172.0/255 blue:193.0/255 alpha:1];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.bounds.size.width, 0.01f)];
}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    
//    return 1;
//    
//}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *name = @"SearchAlbum";
    SearchAlbumCell *cell = [tableView dequeueReusableCellWithIdentifier:name];
    if (cell == nil) {
        cell = [[SearchAlbumCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:name];
    }
    cell.model = [self.array objectAtIndex:indexPath.row];
    //添加cell上右箭头
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;


}
//cell点击效果
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DiscoverSongListController *list = [[DiscoverSongListController alloc] init];
    SearchAlbumModel *model = [self.array objectAtIndex:indexPath.row];
    NSLog(@"%@",model._id);
    list.titleName = model.name;
    list.albumId = model._id;
    [self.navigationController pushViewController:list animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)setSearchName:(NSString *)searchName{

    [self getData:searchName];

}
-(void)getData:(NSString *)name{
    NSString *urlString= [NSString stringWithFormat:@"%@",name];
    
    NSString * encodedString = (NSString *)CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)urlString, NULL, NULL,  kCFStringEncodingUTF8 );
    
    NSString *url = [NSString stringWithFormat:@"http://so.ard.iyyin.com/albums/search?q=%@&page=1&size=50",encodedString];
    self.array = [NSMutableArray array];
    [AFNGet GetData:url block:^(id backData) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:backData];
        //NSLog(@"%@",backData);
        NSMutableArray *array = [dic objectForKey:@"data"];
        
        for (NSMutableDictionary *dic in array) {
            SearchAlbumModel *model = [[[SearchAlbumModel alloc] init] autorelease];
           // NSLog(@"%@",dic);
            [model setValuesForKeysWithDictionary:dic];
            [self.array addObject:model];
        }
       // NSLog(@"%@",self.array);
        [self.tableView reloadData];
        
    }];


}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 80;
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
