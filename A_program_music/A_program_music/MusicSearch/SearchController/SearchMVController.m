//
//  SearchMVController.m
//  A_program_music
//
//  Created by 姚天成 on 15/6/30.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "SearchMVController.h"
#import "SearchMVModel.h"


@interface SearchMVController()
@property(nonatomic,retain)UITableView *myTableView;
@property(nonatomic,retain)NSMutableArray *array;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,retain)MBProgressHUD *MB;
@property(nonatomic,assign)NSInteger pageNumber;
@property(nonatomic,retain)NSMutableDictionary *preDic;

@property(nonatomic,assign) NSInteger nextPage;//下拉加载 记录下一页
@property(nonatomic,assign) NSInteger headerPage;//上拉刷新

@property(nonatomic,assign) BOOL isUpLoading;//标记上啦还是下拉,yes为上啦
@end


@implementation SearchMVController


-(void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor colorWithRed:143.0/255 green:172.0/255 blue:193.0/255 alpha:1];
    self.myTableView=[[[MusicTableViewController alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height - 70) style:UITableViewStyleGrouped] autorelease];
    self.myTableView.backgroundColor=[UIColor colorWithRed:143.0/255 green:172.0/255 blue:193.0/255 alpha:1];
    //self.myTableView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.myTableView];
    
    self.myTableView.delegate=self;
    self.myTableView.dataSource=self;
    
    self.myTableView.separatorStyle=UITableViewCellSeparatorStyleNone;//cell隐藏线
    
    //菊花
    self.MB = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.MB.labelText = @"拼命加载中...";
    [self.MB show:YES];
    
    self.array=[NSMutableArray array];
    
    
    self.isUpLoading = NO;
    [self addFooter:1];
    
    self.myTableView.tableHeaderView = [[[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.bounds.size.width, 0.01f)] autorelease];
    
    
}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    
//    return 1;
//    
//}
-(void)setTitle1:(NSString *)title1{
    self.name = title1;
    [self searchDatashow];

}
//上啦刷新
-(void)addFooter:(NSInteger)number
{
    __block SearchMVController *premierVC=self;
    self.myTableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        premierVC.isUpLoading=YES;
        
        
        _pageNumber = _pageNumber + 20;
        NSString *newPage = [NSString stringWithFormat:@"%ld",_pageNumber ];
        NSLog(@"newPage = %@",newPage);
        // _preDic = [NSMutableDictionary dictionary];//接口字典
        
        [self.MB show:YES];
        [self searchDatashow];
        [_preDic setObject:newPage forKey:@"offset"];
        
        premierVC.nextPage ++;
        //[premierVC searchDatashow];
        
        
    }];
    
}




-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *myCell=@"cell";
    SearchDataViewCell *cell=[tableView dequeueReusableCellWithIdentifier:myCell];
    if (cell == nil) {
        cell = [[SearchDataViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myCell];
    }
    //cell.backgroundColor=[UIColor whiteColor];

    cell.model = [self.array objectAtIndex:indexPath.row];
    //NSLog(@"%@",cell.model.title);
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    //渐变效果
    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
    cell.alpha = 0;
    [UIView beginAnimations:@"rotation" context:NULL];
    [UIView setAnimationDuration:1];
    cell.alpha = 1;
    [UIView commitAnimations];
    
    return cell;
    
    
}
//多少cell
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%ld",self.array.count);
    return self.array.count;
    
}
//行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HEIGHT * 110;
    
}
//点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MVPlayViewController *mvPlayVC= [[[MVPlayViewController alloc] init] autorelease];
    SearchMVModel *searchModel=[self.array objectAtIndex:indexPath.row];
    mvPlayVC.idD = searchModel.idd;
    [self.myDelegate hideview];
    [self.navigationController pushViewController:mvPlayVC animated:YES];
    
}



//请求数据
-(void)searchDatashow
{
    NSString *data=self.name;
    
    NSString *dataUTF8=[data stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"%@",self.name);
    NSMutableDictionary *searDic=[NSMutableDictionary dictionary];
    [searDic setObject:@"0" forKey:@"D-A"];
    [searDic setObject:dataUTF8 forKey:@"keyword"];
    [searDic setObject:[NSString stringWithFormat:@"%ld", _pageNumber] forKey:@"offset"];
    [searDic setObject:@"20" forKey:@"size"];
    //  D-A=0&keyword=%E8%94%A1%E4%BE%9D%E6%9E%97&offset=0&size=20
    //D-A=0&keyword=T-ARA                      &offset=0&size=20
    
    
    [Connect ConnectRequestAFWithURL:SearchMV params:searDic requestHeader:RequestHeader httpMethod:@"GET" block:^(NSObject *result) {
        //NSLog(@"result = %@",result);
        
        NSMutableArray *myArray=[(NSMutableDictionary *)result objectForKey:@"videos"];
        
        //NSLog(@"result ========== %@",result);
        for (NSMutableDictionary *dic in myArray) {
            SearchMVModel *searDataModel=[[SearchMVModel alloc]init];
            searDataModel.idd=[dic objectForKey:@"id"];
            //searDataModel.type=[dic objectForKey:@"type"];
            searDataModel.title=[dic objectForKey:@"title"];
            searDataModel.artistName=[dic objectForKey:@"artistName"];
            searDataModel.albumImg=[dic objectForKey:@"albumImg"];
            searDataModel.posterPic = [dic objectForKey:@"posterPic"];
            [self.array addObject:searDataModel];
            
            
            //NSLog(@"hhhhhhhh%@",searDataModel.title);
        }
        if (self.array.count==0) {
            UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"没有查到相关MV信息或您的网络连接不稳定" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [self.MB hide:YES];//隐藏菊花
            [alertV show];
        }else
        {
            [self.MB hide:YES];//隐藏菊花
            [self.myTableView.footer endRefreshing];
            [self.myTableView reloadData];
        }
    }];
    
    
    
}




@end
