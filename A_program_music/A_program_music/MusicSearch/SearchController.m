//
//  SearchController.m
//  A_program_music
//
//  Created by 姚天成 on 15/6/19.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "SearchController.h"

@interface SearchController ()


@property(nonatomic,retain)UITextField *searchText;
@property(nonatomic,retain)MusicLabel *label1;
@property(nonatomic,retain)MusicLabel *label2;
@property(nonatomic,retain)MusicLabel *label3;
@property(nonatomic,retain)MusicLabel *label4;
@property(nonatomic,retain)MusicLabel *label5;
@property(nonatomic,retain)CloudView *cloud;
@property(nonatomic,retain)NSTimer *myTimer;

@end

@implementation SearchController

-(void)viewWillAppear:(BOOL)animated{
    
   self.searchText.text = @"";
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[MusicBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(backToMain)];
    self.view.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:250/255.0 alpha:1];
    
   
    self.searchText = [[[[UITextField alloc] initWithFrame:CGRectMake(13, 70, self.view.frame.size.width - 25, 30)] autorelease] autorelease];
    self.searchText.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.searchText];
    
    self.searchText.borderStyle = UITextBorderStyleRoundedRect;
    
    self.searchText.placeholder = @"请输入需要查找的歌曲/歌手";
    //将键盘的return换成搜索
    self.searchText.returnKeyType = UIReturnKeySearch;
    
    //输入框中是否有个叉号，在什么时候显示，用于一次性删除输入框中的内容
    self.searchText.clearButtonMode = UITextFieldViewModeAlways;
    
    self.searchText.delegate = self;
    
    [self getData];
    //加个前缀图片
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"onlinemusic_search_associate"]];
    self.searchText.leftView = image;
    self.searchText.leftViewMode = UITextFieldViewModeAlways;
    
    
    //UIImageView *DajiaZaiSou = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"onlinemusic_search_hotwords"]];
    //DajiaZaiSou.frame = CGRectMake(70, 150, 16, 16);
    //[self.view addSubview:DajiaZaiSou];
    MusicLabel *DajiaZaiSouLabel = [[MusicLabel alloc] initWithFrame:CGRectMake(43, 120, 70, 16)];
    DajiaZaiSouLabel.text = @"大家在搜";
    DajiaZaiSouLabel.textColor = [UIColor lightGrayColor];
    [self.view addSubview:DajiaZaiSouLabel];

    
//    CGRect frame = CGRectMake(43, 120, 16, 16);
//    frame.size = [UIImage imageNamed:@"icon_upbar_icon_playing.gif"].size;
//    // 读取gif图片数据
//    NSData *gif = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"icon_upbar_icon_playing" ofType:@"gif"]];
//    // view生成
//    UIWebView *webView = [[UIWebView alloc] initWithFrame:frame];
//    webView.userInteractionEnabled = NO;//用户不可交互
//    [webView loadData:gif MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
//    [self.view addSubview:webView];
    
    
    
}


-(MusicLabel *)creatLabel:(CGRect)Frame andLabel:(MusicLabel *)label{

    label = [[[MusicLabel alloc] initWithFrame:Frame] autorelease];
    return label;
 
}
//创建标签云
-(void)creatCloudTag:(NSMutableArray *)array{
   
    self.cloud = [[CloudView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 300) andNodeCount:array];
    self.cloud.delegate = self;
    
    [self.view addSubview:self.cloud];
}
//标签云点击方法
-(void)didSelectedNodeButton:(CloudButton *)button
{
    self.searchPage = [[[SearchMainController alloc] init] autorelease];
    self.searchPage.myDelegate = self;
    NSString *str = [self.AllSoArray objectAtIndex:button.tag];
    self.searchPage.name = str;
    [self.navigationController pushViewController:self.searchPage animated:YES];
    
}
-(void)moveTag{
    [self.cloud animationUpdate];

}


//模态
-(void)backToMain{

    //[self.mydelegate viewDisplayView];
    [self.navigationController popViewControllerAnimated:YES];

}

-(void)getData{
    [[SqlDateBase shareSQL] openDB];
    [[SqlDateBase shareSQL] createSearchTable];
    self.AllSoArray = [NSMutableArray array];
    self.AllSoArray = [[SqlDateBase shareSQL] selectAllSearch];
    [self creatCloudTag:self.AllSoArray];
   // if (self.AllSoArray.count > 11) {
        [[SqlDateBase shareSQL] dropSearchTable];
        [[SqlDateBase shareSQL] createSearchTable];
   // }
    [self.AllSoArray removeAllObjects];
    [AFNGet GetData:@"http://so.ard.iyyin.com/sug/billboard" block:^(id backData) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:backData];
        NSMutableArray *array = [dic objectForKey:@"data"];
        for (NSMutableDictionary *dic in array) {
            NSString *str = [dic objectForKey:@"val"];
            [self.AllSoArray addObject:str];
            [[SqlDateBase shareSQL] insertSearch:str];
        }
        [self creatCloudTag:self.AllSoArray];
    }blockError:^(NSError *error) {
        
        [self creatCloudTag:self.AllSoArray];
    }];

}
-(void)SearchMainHideView{
    
    [self.mydelegate hideView1];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([textField.text isEqualToString:@""]) {
        
    }else{
    self.searchPage = [[[SearchMainController alloc] init] autorelease];
        self.searchPage.myDelegate = self;
    self.searchPage.name = textField.text;
    [self.navigationController pushViewController:self.searchPage animated:YES];
    }
    [textField resignFirstResponder];
    return NO;

    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
