//
//  SingerTopViewController.m
//  A_program_music
//
//  Created by dlios on 15/6/23.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "SingerTopViewController.h"
#import "SingerTopCollectionViewCell.h"
#import "SingerDetailViewController.h"
#import "DXAlertView.h"
@interface SingerTopViewController ()

@property(nonatomic,retain)NSMutableArray *singerArray;
@property(nonatomic,retain)MusicCollectionView *singerCV;
@property(nonatomic,retain)MBProgressHUD *HUD;


@end

@implementation SingerTopViewController

-(void)dealloc
{
    [_singerArray release];
    [_singerCV release];
    [_HUD release];
    [super dealloc];
}






- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =[UIColor whiteColor];
    
    MusicCollectionViewFlowLayout *flowLayout = [[MusicCollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(100*WIDTH, 120*HEIGHT);
    flowLayout.sectionInset = UIEdgeInsetsMake(10*WIDTH, 20*HEIGHT, 10*WIDTH, 20*HEIGHT);
    flowLayout.minimumInteritemSpacing = 10.0;
    flowLayout.minimumLineSpacing = 10.0;
    self.singerCV = [[MusicCollectionView alloc] initWithFrame:[[UIScreen mainScreen]bounds] collectionViewLayout:flowLayout];
    [self.view addSubview:self.singerCV];
    self.singerCV.dataSource = self;
    self.singerCV.delegate = self;
    [self.singerCV registerClass:[SingerTopCollectionViewCell class] forCellWithReuseIdentifier:@"singer"];
    self.singerCV.backgroundColor =[UIColor whiteColor];
    self.singerArray = [NSMutableArray array];
    self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.HUD.labelText = @"正在加载";
    [self.HUD show:YES];
    
    [[SqlDateBase shareSQL] openDB];
    if ([[SqlDateBase shareSQL] selectAllSingerForm].count != 0) {
        
        self.singerArray = [[SqlDateBase shareSQL] selectAllSingerForm];
    }

    

//    [self.singerCV release];
   
    
    [self afnGetInfo];
    
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
        return self.singerArray.count;
  
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SingerTopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"singer" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    SingerModel *model = [[SingerModel alloc] init];
    model = [self.singerArray objectAtIndex:indexPath.row];
    
    cell.model = model;
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SingerDetailViewController *singerDetailVC = [[SingerDetailViewController alloc] init];
    SingerModel *model = [[SingerModel alloc] init];
    model = [self.singerArray objectAtIndex:indexPath.row];
    
    singerDetailVC.singermodel = model;
    [self.navigationController pushViewController:singerDetailVC animated:YES];
   

}


-(void)afnGetInfo
{
//    [[SqlDateBase shareSQL] openDB];
//    self.singerArray = [NSMutableArray array];

    
    [AFNGet GetData:@"http://v1.ard.tj.itlily.com/ttpod?a=getnewttpod&id=46&app=ttpod&v=v7.9.4.2015052918&uid=&mid=iPhone5C&f=f320&s=s310&imsi=&hid=&splus=8.3&active=1&net=2&openudid=be1f25173f9be5d1454353a8fc39c8659b1c8f50&idfa=63406252-6848-4643-9CB3-2BC90F4A311D&utdid=VXllpMbdd2oDABsdVak%2BsCvi&alf=201200&bundle_id=com.ttpod.music" block:^(id backData) {
        NSMutableDictionary *bigDic = backData;
        NSMutableArray *array =[bigDic objectForKey:@"data"];
        
        [[SqlDateBase shareSQL] dropsingerForm];
        [[SqlDateBase shareSQL] createSingerForm];
        [self.singerArray removeAllObjects];
//        [self.formArray removeAllObjects];
        for (NSMutableDictionary *dic in array) {
            SingerModel *model = [[SingerModel alloc] init];
            model.title = [dic objectForKey:@"title"];
            model.pic_url = [dic objectForKey:@"pic_url"];
            model.number = [dic objectForKey:@"id"];
            [self.singerArray addObject:model];
            [[SqlDateBase shareSQL] insertSingerForm:model];
            
            [self.HUD hide:YES];
        }
        
        [self.singerCV reloadData];

        
    } blockError:^(NSError *error) {
        [self.HUD hide:YES];
        DXAlertView *alertView  =[[DXAlertView alloc] initWithTitle:@"提示" contentText:@"网络连接失败" leftButtonTitle:nil rightButtonTitle:@"确定"];
        [alertView show];
        [alertView release];
        
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
