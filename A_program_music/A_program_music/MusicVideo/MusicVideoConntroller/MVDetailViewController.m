//
//  MVDetailViewController.m
//  A_program_music
//
//  Created by dlios on 15/6/26.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "MVDetailViewController.h"

@interface MVDetailViewController ()
@property(nonatomic,retain)NSMutableArray *bigArray1;
@property(nonatomic,copy)NSString *artName1;
@property(nonatomic,copy)NSString *descriptionA1;
@property(nonatomic,copy)NSString *playTimes1;
@property(nonatomic,copy)NSString *regdate1;
@property(nonatomic,copy)NSString *posterPic1;
@property(nonatomic,retain)NSMutableArray *XgMvArray1;
@property(nonatomic,retain)MusicTableViewController *tableView;
@property(nonatomic,assign)NSInteger panduan;
@property(nonatomic,retain)MusicLabel *labelArtName;
@property(nonatomic,retain)MusicLabel *labelPlayTimes;
@property(nonatomic,retain)MusicLabel *labelFabuTime;
@property(nonatomic,retain)UIImageView *imageV;
@property(nonatomic,retain)MusicLabel *labelArtN;


@end

@implementation MVDetailViewController

- (void)viewDidLoad {
    
    [self getData];//调用取值方法
    
    self.bigArray1 = [NSMutableArray array];
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:143.0/255 green:172.0/255 blue:193.0/255 alpha:1];
    
    //创建tableView
    self.tableView = [[[MusicTableViewController alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 337*HEIGHT) style:UITableViewStylePlain] autorelease];
    
    [self.view addSubview:self.tableView];
    
    self.tableView.backgroundColor = [UIColor colorWithRed:143.0/255 green:172.0/255 blue:193.0/255 alpha:1];
    
    self.tableView.delegate = self;//签订tableView协议
    
    self.tableView.dataSource = self;//签订tableView协议
    
    self.tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    
    
    
    self.imageV = [[[UIImageView alloc] initWithFrame:CGRectMake(10*WIDTH, 10*HEIGHT, 84*WIDTH, 84*HEIGHT)] autorelease];
    self.labelArtN = [[[MusicLabel alloc] initWithFrame:CGRectMake(100*WIDTH, 35*HEIGHT, 200*WIDTH, 10*HEIGHT)] autorelease];
    self.labelArtName = [[[MusicLabel alloc] initWithFrame:CGRectMake(100*WIDTH, 55*HEIGHT, 200*WIDTH, 10*HEIGHT)] autorelease];
     self.labelPlayTimes = [[[MusicLabel alloc]initWithFrame:CGRectMake(10*WIDTH, 120*HEIGHT, 150*WIDTH, 10*HEIGHT)] autorelease];
     self.labelFabuTime = [[[MusicLabel alloc] initWithFrame:CGRectMake(195*WIDTH, 120*HEIGHT, 200*WIDTH, 10*HEIGHT)] autorelease];
}







//------------------------设置cell的个数------------------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}


//--------------------自定义cell方法--------------------
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    static NSString *celldentifire = @"myCell";
    MVDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:celldentifire];
    if (indexPath.row == 0) {
        
        
    if (cell == nil) {
        cell = [[[MVDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:celldentifire ] autorelease];
        }
        
        cell.backgroundColor = [UIColor colorWithRed:143.0/255 green:172.0/255 blue:193.0/255 alpha:1];
  
        //--------------------设置MV下面头像的UIimageView---------------
        
       
       // [imageView sd_setImageWithURL:[NSURL URLWithString:self.posterPic1]];
        [self.imageV sd_setImageWithURL:[NSURL URLWithString:self.posterPic1] placeholderImage:[UIImage imageNamed:@"sort_artist"]];
        
        self.imageV.layer.masksToBounds = YES;
        
        self.imageV.layer.cornerRadius = 42*HEIGHT;
        
        [cell.contentView addSubview:self.imageV];
        
        
        //----------------------------设置艺人label-----------------------
        
        self.labelArtN.font = [UIFont systemFontOfSize:10.0];
        
        self.labelArtN.text =@"艺人:";
        
        self.labelArtN.textColor = [UIColor whiteColor];
        
        [cell.contentView addSubview:self.labelArtN];
        
        
        //--------------------------设置艺人名字label----------------------
        
        _labelArtName.font = [UIFont systemFontOfSize:10.0];
        
        _labelArtName.text = self.artName1;
        
        _labelArtName.textColor = [UIColor whiteColor];
        
        [cell.contentView addSubview:_labelArtName];
        
        //------------------------设置播放次数--------------------
       
        _labelPlayTimes.font = [UIFont systemFontOfSize:10.0];
        
        if (self.panduan == 1) {//做一个判断,在取值成功后给self.panduan赋值为1,否则下面的方法会走两次,有一个null的重影.
            
        _labelPlayTimes.text = [NSString stringWithFormat:@"播放次数:  %@",self.playTimes1];
        }
        _labelPlayTimes.textColor = [UIColor whiteColor];
       
        [cell.contentView addSubview:_labelPlayTimes];
        
        //-----------------------设置发布日期---------------------
       
        
        self.labelFabuTime.font = [UIFont systemFontOfSize:10.0];
        
        if (self.panduan == 1) {//做一个判断,在取值成功后给self.panduan赋值为1,否则下面的方法会走两次,有一个null的重影.
            
            self.labelFabuTime.text = [NSString stringWithFormat:@"发布时间:  %@",self.regdate1];
        }
        
        _labelFabuTime.textColor = [UIColor whiteColor];
      
        [cell.contentView addSubview:self.labelFabuTime];
        
    }else if(indexPath.row == 1)
    {
        
        if (cell == nil) {
            
            cell = [[[MVDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:celldentifire ] autorelease];
        }
        
        //----------------------------设置MVV简介-----------------------
        self.labelMvDetail = [[UILabel alloc] initWithFrame:CGRectMake(10*WIDTH, 0, cell.contentView.frame.size.width-20*WIDTH, 0)];
        
        self.labelMvDetail.text = self.descriptionA1;
        
        _labelMvDetail.textColor = [UIColor whiteColor];
        
        self.labelMvDetail.font = [UIFont systemFontOfSize:12.0];
        
        self.labelMvDetail.backgroundColor = [UIColor colorWithRed:143.0/255 green:172.0/255 blue:193.0/255 alpha:1];

        //labelMvDetail.textInputContextIdentifier
        self.labelMvDetail.numberOfLines = 0;
        
        CGRect textFream = self.labelMvDetail.frame;
        
        self.labelMvDetail.frame = CGRectMake(10*WIDTH, 0, cell.contentView.frame.size.width-20*WIDTH, textFream.size.height = [self.labelMvDetail.text boundingRectWithSize:CGSizeMake(textFream.size.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:self.labelMvDetail.font,NSFontAttributeName, nil] context:nil].size.height*HEIGHT);
        
        self.labelMvDetail.frame = CGRectMake(10*WIDTH, 0, cell.contentView.frame.size.width-20*WIDTH, textFream.size.height*HEIGHT);
        
        [self.labelMvDetail sizeToFit];
        
        cell.backgroundColor = [UIColor colorWithRed:143.0/255 green:172.0/255 blue:193.0/255 alpha:1];
        
        [cell.contentView addSubview:self.labelMvDetail];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        
        return 130;
        
    }else
        
    {
        
        return self.labelMvDetail.frame.size.height;
        
    }
    
}


//------------------取值------------------
-(void)getData
{
 
    NSMutableDictionary *askerDic = [NSMutableDictionary dictionary];
    
    [askerDic setObject:@"0" forKey:@"D-A"];
    
    [askerDic setObject:self.ID forKey:@"id"];
    
    [askerDic setObject:@"true" forKey:@"relatedVideos"];
    
    [askerDic setObject:@"true" forKey:@"supportHtml"];
    
    [Connect ConnectRequestAFWithURL:VIDEODETAIL params:askerDic requestHeader:RequestHeader httpMethod:@"GET" block:^(NSObject *result) {
        NSMutableDictionary *dic = (NSMutableDictionary *)result;
        
        self.artName1 = [dic objectForKey:@"artistName"];
        
        self.descriptionA1 =[dic objectForKey:@"description"];
        
        self.playTimes1 = [NSString stringWithFormat:@"%@",[dic objectForKey:@"totalViews"]];
        
        self.regdate1 = [dic objectForKey:@"regdate"];
        
        self.posterPic1= [dic objectForKey:@"posterPic"];
        
        self.panduan = 1;
        
        [self.tableView reloadData];
        
    }];

}

//----------------------重写set方法---------------
-(void)setID:(NSString *)ID
{

    if (_ID != ID) {
        
        [_ID release];
        
        _ID = [ID copy];
        
    }
    
    self.labelArtName.text = @"";
    
    self.labelPlayTimes.text =@"";
    
    self.labelFabuTime.text = @"";
    
    [self getData];
    
    [self.tableView reloadData];
    
    [self viewWillAppear:YES];
}









- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    
    [_bigArray1 release];
    
    [_artName1 release];
    
    [_descriptionA1 release];
    
    [_playTimes1 release];
    
    [_regdate1 release];
    
    [_posterPic1 release];
    
    [_XgMvArray1 release];
    
    [super dealloc];
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
