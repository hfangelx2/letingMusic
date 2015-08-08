//
//  StorgeController.m
//  A_program_music
//
//  Created by 姚天成 on 15/6/19.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "StorgeController.h"
#import <STKAudioPlayer.h>
#import "DXAlertView.h"
#import "PlayModel.h"

@interface StorgeController ()

@property(nonatomic,retain)NSMutableArray *remenArray;
@property(nonatomic,retain)NSMutableArray *remenTitleArray;
@property(nonatomic,retain)NSMutableArray *wusunArray;
@property(nonatomic,retain)NSMutableArray *wusunTitleArray;
@property(nonatomic,retain)NSMutableArray *changjingArray;
@property(nonatomic,retain)NSMutableArray *changjingTitleArray;
@property(nonatomic,retain)NSMutableArray *yuyanArray;
@property(nonatomic,retain)NSMutableArray *yuyanTitleArray;
@property(nonatomic,retain)NSMutableArray *xinqingArray;
@property(nonatomic,retain)NSMutableArray *xinqingTitleArray;
@property(nonatomic,retain)NSMutableArray *fenggeArray;
@property(nonatomic,retain)NSMutableArray *fenggeTitleArray;
@property(nonatomic,retain)NSMutableArray *teseArray;
@property(nonatomic,retain)NSMutableArray *teseTitleArray;
@property(nonatomic,retain)NSMutableArray *niandaiArray;
@property(nonatomic,retain)NSMutableArray *niandaiTitleArray;
@property(nonatomic,retain)NSMutableArray *idArray;
@property(nonatomic,retain)NSMutableArray *smArray;
@property(nonatomic,retain)NSMutableArray *parentnameArray;
@property(nonatomic,retain)NSMutableArray *songlist_nameArray;
@property(nonatomic,retain)NSMutableArray *small_pic_urlArray;
@property(nonatomic,retain)NSMutableArray *bigArray;
@property(nonatomic,retain)UILabel *labelHeader1;
@property(nonatomic,retain)NSMutableArray *remenIDArray;
@property(nonatomic,retain)NSMutableArray *wusunIDArray;
@property(nonatomic,retain)NSMutableArray *changjingIDArray;
@property(nonatomic,retain)NSMutableArray *yuyanIDArray;
@property(nonatomic,retain)NSMutableArray *xinqingIDArray;
@property(nonatomic,retain)NSMutableArray *fenggeIDArray;
@property(nonatomic,retain)NSMutableArray *teseIDArray;
@property(nonatomic,retain)NSMutableArray *niandaiIDArray;



@property(nonatomic,retain)MusicCollectionView *collectionView;


@end

@implementation StorgeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    //创建UICollectionViewFlowLayout
    UICollectionViewFlowLayout *flowOut= [[[UICollectionViewFlowLayout alloc] init] autorelease];
    
    
    //设置方块的大小
    flowOut.itemSize = CGSizeMake(110*WIDTH, 110*HEIGHT);
    
    //设置头视图
    flowOut.headerReferenceSize = CGSizeMake(375*WIDTH, 50*HEIGHT);
    
    //偏移量
    flowOut.sectionInset = UIEdgeInsetsMake(5.0*WIDTH, 5.0*HEIGHT, 40.0*WIDTH, 5.0*HEIGHT);
    
    //行间距
    flowOut.minimumLineSpacing = 25*HEIGHT;
    
    //创建UICollectionView
    _collectionView = [[[MusicCollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 555*HEIGHT) collectionViewLayout:flowOut] autorelease];
    
    //设置UICollectionView 的背景颜色
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_collectionView];
    
    _collectionView.delegate =self;
    _collectionView.dataSource =self;
    
    [_collectionView registerClass:[StorgeCollectionViewCell class] forCellWithReuseIdentifier:@"reuse"];
    
     [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerReuse"];
    
    
    
    self.remenArray = [NSMutableArray array];
    self.remenTitleArray=[NSMutableArray array];
    self.wusunArray = [NSMutableArray array];
    self.wusunTitleArray=[NSMutableArray array];
    self.changjingArray = [NSMutableArray array];
    self.changjingTitleArray=[NSMutableArray array];
    self.yuyanArray = [NSMutableArray array];
    self.yuyanTitleArray=[NSMutableArray array];
    self.xinqingArray = [NSMutableArray array];
    self.xinqingTitleArray=[NSMutableArray array];
    self.fenggeArray = [NSMutableArray array];
    self.fenggeTitleArray=[NSMutableArray array];
    self.teseArray = [NSMutableArray array];
    self.teseTitleArray=[NSMutableArray array];
    self.niandaiArray= [NSMutableArray array];
    self.niandaiTitleArray=[NSMutableArray array];
    
    self.remenIDArray = [NSMutableArray array];
    self.wusunIDArray = [NSMutableArray array];
    self.changjingIDArray = [NSMutableArray array];
    self.yuyanIDArray = [NSMutableArray array];
    self.xinqingIDArray = [NSMutableArray array];
    self.fenggeIDArray = [NSMutableArray array];
    self.teseIDArray = [NSMutableArray array];
    self.niandaiIDArray = [NSMutableArray array];
    
    self.parentnameArray = [NSMutableArray array];
    self.small_pic_urlArray = [NSMutableArray array];
    self.songlist_nameArray = [NSMutableArray array];
     self.idArray = [NSMutableArray array];
    [self cache];
       [self getData];
    
}

-(void)cache
{
    NSMutableArray *array1 = [NSMutableArray array];
    array1 = [[SqlDateBase shareSQL]selectAllMusicStorge];
    for (StorgeModel *model in array1) {
        [self.parentnameArray addObject:model.parentname];
        [self.songlist_nameArray addObject:model.songlist_name];
        [self.small_pic_urlArray addObject:model.small_pic_url];
        [self.idArray addObject:model.songlist_Id];
    }
    [self setData];


}

//------------设置section的个数------------
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return 8;
}

//-------------设置每个section里Items的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    
    if (section == 0) {
        
        return _remenArray.count;
    }
    
    if (section == 1) {
        return _wusunArray.count;
    }
    
    if (section == 2) {
        return _changjingArray.count;
    }
    
    if (section == 3) {
        return _yuyanArray.count;
    }
    
    if (section == 4) {
        return _xinqingArray.count;
    }
    
    if (section == 5) {
        return _fenggeArray.count;
    }
    
    if (section == 6) {
        return _teseArray.count;
    }
    
    if (section == 7) {
        return _niandaiArray.count;
    }else{
        
        return 0;
    }
    
}


//------------------设置section文字---------
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headerReuse" forIndexPath:indexPath];
    
    
    
    for (UIView  * aaa in headerView.subviews) {
        [aaa removeFromSuperview];
    }
    
    if (kind == UICollectionElementKindSectionHeader) {
        
        
        UILabel *aLabel = [[UILabel alloc] init];
        aLabel.frame = CGRectMake(5*WIDTH, 20*HEIGHT, self.view.frame.size.width - 305*WIDTH, 20*HEIGHT);
        [headerView addSubview:aLabel];
        aLabel.text = @"";
        
            
        
        headerView.backgroundColor = [UIColor whiteColor];
        
        if (self.parentnameArray.count > 1) {
        
        
        if (indexPath.section == 0) {
            
            aLabel.text =@"热门";
            [aLabel sizeToFit];
           
            
        }
        if (indexPath.section == 1) {
            aLabel.text =@"无损";
            [aLabel sizeToFit];
            
        }
        if (indexPath.section == 2) {
            aLabel.text =@"场景";
            [aLabel sizeToFit];
            
        }
      
         if (indexPath.section == 3) {
             aLabel.text =@"语言";
         [aLabel sizeToFit];
        
         }
         if (indexPath.section == 4) {
             aLabel.text =@"心情";
         [aLabel sizeToFit];
        
         }
         if (indexPath.section == 5) {
         aLabel.text =@"风格";
         [aLabel sizeToFit];
         }
         if (indexPath.section == 6) {
         aLabel.text =@"特色";
         [aLabel sizeToFit];
         }
         if (indexPath.section == 7) {
         aLabel.text =@"年代";
         [aLabel sizeToFit];
         }
        }
         return headerView;
        
    }
    return 0;
}




//---------------自定义cell------------------
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    StorgeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"reuse" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:119.0/255 green:136.0/255 blue:153.0/255 alpha:1];
 
    if (indexPath.section == 0) {
    
        cell.picture = [_remenArray objectAtIndex:indexPath.row];
        cell.titleSmall = [_remenTitleArray objectAtIndex:indexPath.row];
    }
    if (indexPath.section == 1) {
        cell.picture = [_wusunArray objectAtIndex:indexPath.row];
        cell.titleSmall = [_wusunTitleArray objectAtIndex:indexPath.row];

    }
    if (indexPath.section == 2) {
        cell.picture = [_changjingArray objectAtIndex:indexPath.row];
        cell.titleSmall = [_changjingTitleArray objectAtIndex:indexPath.row];

    }
    if (indexPath.section == 3) {
        cell.picture = [_yuyanArray objectAtIndex:indexPath.row];
        cell.titleSmall = [_yuyanTitleArray objectAtIndex:indexPath.row];

    }
    if (indexPath.section == 4) {
        cell.picture = [_xinqingArray objectAtIndex:indexPath.row];
        cell.titleSmall = [_xinqingTitleArray objectAtIndex:indexPath.row];

    }
    if (indexPath.section == 5) {
        cell.picture = [_fenggeArray objectAtIndex:indexPath.row];
        cell.titleSmall = [_fenggeTitleArray objectAtIndex:indexPath.row];

    }
    if (indexPath.section == 6) {
        cell.picture = [_teseArray objectAtIndex:indexPath.row];
        cell.titleSmall = [_teseTitleArray objectAtIndex:indexPath.row];

    }
    if (indexPath.section == 7) {
        cell.picture = [_niandaiArray objectAtIndex:indexPath.row];
        cell.titleSmall = [_niandaiTitleArray objectAtIndex:indexPath.row];

    }
    
    
    //cell.picture = [self.small_pic_urlArray objectAtIndex:indexPath.row];
    
    
    return cell;
    
    
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
     StrorgePlayViewController *stroragePlay = [[[StrorgePlayViewController alloc] init] autorelease];
    
    if (indexPath.section==0&&indexPath.row == 0) {
        DXAlertView *alertV = [[DXAlertView alloc] initWithTitle:@"提示" contentText:@"很抱歉,由于版权问题,该歌单暂时无法播放" leftButtonTitle:nil rightButtonTitle:@"这样啊"];
        [alertV show];
        
        return;
    }
    if (indexPath.section == 0) {
        stroragePlay.titleA = [self.remenTitleArray objectAtIndex:indexPath.row];
        stroragePlay.ID = [self.remenIDArray objectAtIndex:indexPath.row];
        
    }
    if (indexPath.section == 1) {
        stroragePlay.titleA = [self.wusunTitleArray objectAtIndex:indexPath.row];
        stroragePlay.ID = [self.wusunIDArray objectAtIndex:indexPath.row];
    }
    if (indexPath.section == 2) {
        stroragePlay.titleA = [self.changjingTitleArray objectAtIndex:indexPath.row];
        stroragePlay.ID = [self.changjingIDArray objectAtIndex:indexPath.row];
        
    }
    if (indexPath.section == 3) {
        stroragePlay.titleA = [self.yuyanTitleArray objectAtIndex:indexPath.row];
        stroragePlay.ID = [self.yuyanIDArray objectAtIndex:indexPath.row];
        
    }  if (indexPath.section == 4) {
        stroragePlay.titleA = [self.xinqingTitleArray objectAtIndex:indexPath.row];
        stroragePlay.ID = [self.xinqingIDArray objectAtIndex:indexPath.row];
        
    }  if (indexPath.section == 5) {
        stroragePlay.titleA = [self.fenggeTitleArray objectAtIndex:indexPath.row];
        stroragePlay.ID = [self.fenggeIDArray objectAtIndex:indexPath.row];
        
    }  if (indexPath.section == 6) {
        stroragePlay.titleA = [self.teseTitleArray objectAtIndex:indexPath.row];
        stroragePlay.ID = [self.teseIDArray objectAtIndex:indexPath.row];
        
    }  if (indexPath.section == 7) {
        stroragePlay.titleA = [self.niandaiTitleArray objectAtIndex:indexPath.row];
        stroragePlay.ID = [self.niandaiIDArray objectAtIndex:indexPath.row];
        
    }
    
    
    
    [self.navigationController pushViewController:stroragePlay animated:YES];


}





//----------------AFN方法取值---------------
-(void)getData
{
 

[AFNGet GetData:@"http://fm.api.ttpod.com/channellist?image_type=240_200&app=ttpod&v=v7.9.4.2015052918" block:^(id backData) {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:backData];
    
    self.bigArray = [NSMutableArray array];
    self.bigArray = [dic objectForKeyedSubscript:@"data"];
  
   
    [[SqlDateBase shareSQL]dropTableMusicStorge];
    [[SqlDateBase shareSQL]createTableMusicStorge];
    
    [self.parentnameArray removeAllObjects];
    [self.songlist_nameArray removeAllObjects];
    [self.small_pic_urlArray removeAllObjects];
    [self.idArray removeAllObjects];
    for (NSMutableDictionary *bigDic in self.bigArray) {
        StorgeModel *storgeModel = [[[StorgeModel alloc] init] autorelease];
        [storgeModel setValuesForKeysWithDictionary:bigDic];
       //storgeModel.songlist_Id = (NSString *)[[bigDic objectForKey:@"songlist_idsonglist_id"] integerValue];
        NSInteger intg = [[bigDic objectForKeyedSubscript:@"songlist_id"] integerValue];
        storgeModel.songlist_Id = [NSString stringWithFormat:@"%ld",intg];
        [self.smArray removeAllObjects];
        [self.smArray addObject:storgeModel];
        [self.parentnameArray addObject:storgeModel.parentname];
        
        [self.songlist_nameArray addObject:storgeModel.songlist_name];
        [self.small_pic_urlArray  addObject:storgeModel.small_pic_url];
        [self.idArray addObject:storgeModel.songlist_Id];
        
       
      [[SqlDateBase shareSQL] insertMusicStorge:storgeModel];
        
        }
    
      [self setData];
    [self.collectionView reloadData];
   
}];
}


//----------------赋值--------------------
-(void)setData
{
    
    [_remenArray removeAllObjects];
    [_remenIDArray removeAllObjects];
    [_remenTitleArray removeAllObjects];
    [_wusunArray removeAllObjects];
    [_wusunIDArray removeAllObjects];
    [_wusunTitleArray removeAllObjects];
    [_changjingArray removeAllObjects];
    [_changjingIDArray removeAllObjects];
    [_changjingTitleArray removeAllObjects];
    [_yuyanArray removeAllObjects];
    [_yuyanIDArray removeAllObjects];
    [_yuyanTitleArray removeAllObjects];
    [_xinqingArray removeAllObjects];
    [_xinqingIDArray removeAllObjects];
    [_xinqingTitleArray removeAllObjects];
    [_fenggeArray removeAllObjects];
    [_fenggeIDArray removeAllObjects];
    [_fenggeTitleArray removeAllObjects];
    [_teseArray removeAllObjects];
    [_teseIDArray removeAllObjects];
    [_teseTitleArray removeAllObjects];
    [_niandaiArray removeAllObjects];
    [_niandaiIDArray removeAllObjects];
    [_niandaiTitleArray removeAllObjects];
    
    

    for (int i = 0; i < _parentnameArray.count; i++) {
        if ([[self.parentnameArray objectAtIndex:i] isEqualToString:@"热门"]) {
            [self.remenArray addObject:[self.small_pic_urlArray objectAtIndex:i]];
            [self.remenTitleArray addObject:[self.songlist_nameArray objectAtIndex:i]];
            [self.remenIDArray addObject:[self.idArray objectAtIndex:i]];
       //     NSLog(@"remenArray%ld",self.remenTitleArray.count);
            
            
        }
        if ([[_parentnameArray objectAtIndex:i] isEqualToString:@"无损"]) {
            [_wusunArray addObject:[_small_pic_urlArray objectAtIndex:i]];
            [self.wusunTitleArray addObject:[self.songlist_nameArray objectAtIndex:i]];
            [self.wusunIDArray addObject:[self.idArray objectAtIndex:i]];
            
            
         //   NSLog(@"wusunArray%ld",self.wusunTitleArray.count);
        }
        
        if ([[_parentnameArray objectAtIndex:i] isEqualToString:@"场景"]) {
            [_changjingArray addObject:[_small_pic_urlArray objectAtIndex:i]];
            [_changjingTitleArray addObject:[_songlist_nameArray objectAtIndex:i]];
            [_changjingIDArray addObject:[_idArray objectAtIndex:i]];
        }
        if ([[_parentnameArray objectAtIndex:i] isEqualToString:@"语言"]) {
            [_yuyanArray addObject:[_small_pic_urlArray objectAtIndex:i]];
            [_yuyanTitleArray addObject:[_songlist_nameArray objectAtIndex:i]];
            [_yuyanIDArray addObject:[_idArray objectAtIndex:i]];
        }
        if ([[_parentnameArray objectAtIndex:i] isEqualToString:@"心情"]) {
            [_xinqingArray addObject:[_small_pic_urlArray objectAtIndex:i]];
            [_xinqingTitleArray addObject:[_songlist_nameArray objectAtIndex:i]];
            [_xinqingIDArray addObject:[_idArray objectAtIndex:i]];
        }
        if ([[_parentnameArray objectAtIndex:i] isEqualToString:@"风格"]) {
            [_fenggeArray addObject:[_small_pic_urlArray objectAtIndex:i]];
            [_fenggeTitleArray addObject:[_songlist_nameArray objectAtIndex:i]];
            [_fenggeIDArray addObject:[_idArray objectAtIndex:i]];
        }
        if ([[_parentnameArray objectAtIndex:i] isEqualToString:@"特色"]) {
            [_teseArray addObject:[_small_pic_urlArray objectAtIndex:i]];
            [_teseTitleArray addObject:[_songlist_nameArray objectAtIndex:i]];
            [_teseIDArray addObject:[_idArray objectAtIndex:i]];
            
        }if ([[_parentnameArray objectAtIndex:i] isEqualToString:@"年代"]) {
            [_niandaiArray addObject:[_small_pic_urlArray objectAtIndex:i]];
            [_niandaiTitleArray addObject:[_songlist_nameArray objectAtIndex:i]];
            [_niandaiIDArray addObject:[_idArray objectAtIndex:i]];
        }
  
    }
}





/*
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    StPlayViewController *stPlayVC = [[[StPlayViewController alloc] init] autorelease];

    stPlayVC.IdUrl = [self.idArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:stPlayVC animated:YES];

}
*/









- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)dealloc
{
    [_remenArray release];
    [_remenIDArray release];
    [_remenTitleArray release];
    [_wusunArray release];
    [_wusunIDArray release];
    [_wusunTitleArray release];
    [_changjingArray release];
    [_changjingIDArray release];
    [_changjingTitleArray release];
    [_yuyanArray release];
    [_yuyanIDArray release];
    [_yuyanTitleArray release];
    [_xinqingArray release];
    [_xinqingIDArray release];
    [_xinqingTitleArray release];
    [_teseArray release];
    [_teseIDArray release];
    [_teseTitleArray release];
    [_niandaiArray release];
    [_niandaiIDArray release];
    [_niandaiTitleArray release];
    [_fenggeArray release];
    [_fenggeIDArray release];
    [_fenggeTitleArray release];
    [_idArray release];
    [_smArray release];
    [_small_pic_urlArray release];
    [_parentnameArray release];
    [_songlist_nameArray release];
    [_bigArray release];

    [super dealloc];
}

@end
