//
//  NewSongViewController.m
//  A_program_music
//
//  Created by dlios on 15/6/23.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "NewSongViewController.h"
#import "DXAlertView.h"

@interface NewSongViewController ()


@property(nonatomic,retain)MusicCollectionViewFlowLayout *flowLayout;
@property(nonatomic,retain)MusicCollectionView *SongCollectionView;
@property(nonatomic,retain)MBProgressHUD *HUD;


@end

@implementation NewSongViewController

-(void)dealloc
{
    [_array release];
    [_array1 release];
    [_flowLayout release];
    [_SongCollectionView release];
    [_HUD release];
    [super dealloc];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =[UIColor whiteColor];
    
    self.flowLayout = [[MusicCollectionViewFlowLayout alloc] init];
//    self.flowLayout.itemSize = CGSizeMake(200, 200);
    self.flowLayout.sectionInset = UIEdgeInsetsMake(20, 20, 30, 20);
    self.flowLayout.minimumInteritemSpacing = 20;
    self.flowLayout.minimumLineSpacing = 45 * WIDTH;
    self.SongCollectionView = [[MusicCollectionView alloc] initWithFrame:[[UIScreen mainScreen]bounds] collectionViewLayout:self.flowLayout];
    self.SongCollectionView.dataSource = self;
    self.SongCollectionView.delegate = self;
    [self.view addSubview:self.SongCollectionView];
    self.SongCollectionView.backgroundColor = [UIColor whiteColor];
    [self.SongCollectionView registerClass:[NewSongCollectionViewCell class] forCellWithReuseIdentifier:@"newSong"];
    [self.SongCollectionView release];
    [self.flowLayout release];
    
    [self.SongCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerReuse"];
    
    self.array = [NSMutableArray array];

    self.array1 = [NSMutableArray array];
    
    
    
    self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.HUD.labelText = @"正在加载";
    [self.HUD show:YES];
    
    
    [[SqlDateBase shareSQL] openDB];

    if ([[SqlDateBase shareSQL] selectAllNewSongForm].count != 0&&[[SqlDateBase shareSQL] selectAllNewSongForm1].count != 0) {
        self.array = [[SqlDateBase shareSQL] selectAllNewSongForm];
        self.array1 = [[SqlDateBase shareSQL] selectAllNewSongForm1];
}
    
    
    
    [self getAfnInfo];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{

    return 2;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
//    [[SqlDateBase shareSQL] openDB];
    
        if (section == 0) {
     
        return self.array.count;
    }
    
        else{
         
        return self.array1.count;
    }
    

   
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NewSongCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"newSong" forIndexPath:indexPath];
   
    NewSongModel *songModel1 = [[NewSongModel alloc] init];
    songModel1 = [self.array1 objectAtIndex:indexPath.row];
    UIImageView *image1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    if (indexPath.section == 0) {
        
        NewSongModel *songModel = [[NewSongModel alloc] init];
        songModel = [self.array objectAtIndex:indexPath.row];
        NSURL *url = [NSURL URLWithString:songModel.pic];
        [image1 sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"smallZhanweitu"]];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, cell.frame.size.height - 5, cell.frame.size.width, 30)];
        [image1 addSubview:label];
        label.textAlignment = NSTextAlignmentCenter;
        
        label.text = songModel.title;
//        [songModel release];
        [label release];
        
    }
    
    else  {
        NSURL *url = [NSURL URLWithString:songModel1.pic];
        [image1 sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"zhanweitu-1"]];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, cell.frame.size.height , cell.frame.size.width, 30)];
        [image1 addSubview:label];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = songModel1.title;
        //label.textColor = [UIColor cyanColor];
        [label release];
        
    }

    [cell setBackgroundView:image1];
    
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0&&indexPath.row == 0) {
        return CGSizeMake(90*WIDTH, 90*HEIGHT);

    }
    if (indexPath.section == 0&&indexPath.row == 1) {
        return CGSizeMake(90*WIDTH, 90*HEIGHT);

    }
    if (indexPath.section == 0&&indexPath.row == 2) {
        return CGSizeMake(90*WIDTH, 90*HEIGHT);
        
    }
    
    else{
        
    return CGSizeMake(150*WIDTH, 150*HEIGHT);
        
    }
}

-(void)getAfnInfo
{
    
    [AFNGet GetData:@"http://online.dongting.com/recomm/new_songs_more?page=1&size=30" block:^(id backData) {
        NSMutableDictionary *bigDic = backData;
        NSMutableArray *topArray = [bigDic objectForKey:@"singles"];
        //       self.array = [NSMutableArray array];
        [[SqlDateBase shareSQL] dropNewSongForm];
        [[SqlDateBase shareSQL] createNewSongForm];
        [[SqlDateBase shareSQL] dropNewSongForm1];
        [[SqlDateBase shareSQL] createNewSongForm1];
        [self.array removeAllObjects];
        [self.array1 removeAllObjects];
        
        for (NSMutableDictionary *dic in topArray) {
            NewSongModel *songModel = [[NewSongModel alloc] init];
            songModel.title = [dic objectForKey:@"title"];
            songModel.pic = [dic objectForKey:@"pic"];
            songModel.msg_id = [dic objectForKey:@"msg_id"];
            [self.array addObject:songModel];
            [[SqlDateBase shareSQL] insertNewSongForm:songModel];
            [songModel release];
        }
        
        NSMutableArray *secondArray = [bigDic objectForKey:@"data"];
        for (NSMutableDictionary *dic in secondArray) {
            NewSongModel *songModel = [[NewSongModel alloc] init];
            songModel.title = [dic objectForKey:@"title"];
            songModel.pic = [dic objectForKey:@"pic"];
            songModel.msg_id = [dic objectForKey:@"msg_id"];
            [self.array1 addObject:songModel];
            [[SqlDateBase shareSQL] insertNewSongForm1:songModel];

            [self.HUD hide:YES];
            [songModel release];

        }
        
        
        
        [self.SongCollectionView reloadData];
        
    } blockError:^(NSError *error) {
        [self.HUD hide:YES];
        DXAlertView *aView = [[DXAlertView alloc] initWithTitle:@"提示" contentText:@"网络连接失败" leftButtonTitle:nil rightButtonTitle:@"确定"];
        [aView show];
        
    }];
    

}



-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    //    kind 是显示区域类型
    
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headerReuse" forIndexPath:indexPath];
//        headerView.backgroundColor = [UIColor cyanColor];
  
    
    for (UIView  * aaa in headerView.subviews) {
        [aaa removeFromSuperview];
    }
    

    
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 200, 100)];
//        label.text = @"";
//        label.text = @"最新";
    
    
    if (indexPath.section == 0&&self.array.count>0) {
        
        label.text =@"最新分类";
        [label sizeToFit];
        
        
    }
    if (indexPath.section == 1&&self.array1.count>0) {
        label.text =@"最新单曲";
        [label sizeToFit];
        
    }

//    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
        [label sizeToFit];
        
        [headerView addSubview:label];
        [label release];
        return headerView;

    
 
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(self.view.frame.size.width*WIDTH, 40*HEIGHT);

}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DetailNewSViewController *detailNewSongVC = [[DetailNewSViewController alloc] init];
    detailNewSongVC.detailNewSongModel = [[DetailNewSongModel alloc] init];
     NewSongModel *songModel = [[NewSongModel alloc] init];
    detailNewSongVC.scrollArray = [NSMutableArray arrayWithArray:self.array1];
//    NSLog(@"%@",detailNewSongVC.scrollArray);
 
    if (indexPath.section == 0) {
        songModel = [self.array objectAtIndex:indexPath.row];
        detailNewSongVC.detailNewSongModel.msg_id = songModel.msg_id;
    }
    if (indexPath.section == 1) {
        songModel = [self.array1 objectAtIndex:indexPath.row];
        detailNewSongVC.detailNewSongModel.msg_id = songModel.msg_id;
    }
    

    [self.navigationController pushViewController:detailNewSongVC animated:YES];
//    [detailNewSongVC release];
//    [songModel release];

}














- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning
     
     
     
     ];
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
