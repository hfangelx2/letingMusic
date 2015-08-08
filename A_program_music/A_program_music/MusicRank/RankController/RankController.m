//
//  RankController.m
//  A_program_music
//
//  Created by 姚天成 on 15/6/19.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "RankController.h"

@interface RankController ()

@end

@implementation RankController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MusicButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(self.view.frame.size.width*0.05,self.view.frame.size.height*0.02 , self.view.frame.size.width*0.9, self.view.frame.size.height*0.23);
    [self.view addSubview:button1];
    button1.adjustsImageWhenHighlighted = NO;
    [button1 addTarget:self action:@selector(Pushrank) forControlEvents:UIControlEventTouchUpInside];
//    button1.backgroundColor = [UIColor redColor];
    [button1 setImage:[UIImage imageNamed:@"paihang"] forState:UIControlStateNormal];
//    
//    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, 100, 40)];
//    label1.text = @"排 行";
//    label1.font = [UIFont systemFontOfSize:20];
//    [label1 setTextColor:[UIColor whiteColor]];
//    [button1.imageView addSubview:label1];
//    [label1 release];
    
    MusicButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(self.view.frame.size.width*0.05,self.view.frame.size.height*0.27 , self.view.frame.size.width*0.9, self.view.frame.size.height*0.23);
    [self.view addSubview:button2];
    [button2 addTarget:self action:@selector(NewsongFirst) forControlEvents:UIControlEventTouchUpInside];
    button2.adjustsImageWhenHighlighted = NO;
    [button2 setImage:[UIImage imageNamed:@"shoufa"] forState:UIControlStateNormal];
    
//    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, 100, 40)];
//    label2.text = @"新歌首发";
//    label2.font = [UIFont systemFontOfSize:20];
//    [label2 setTextColor:[UIColor whiteColor]];
//    [button2.imageView addSubview:label2];
//    [label2 release];
    
    
    MusicButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    button3.frame = CGRectMake(self.view.frame.size.width*0.05,self.view.frame.size.height*0.52 , self.view.frame.size.width*0.9, self.view.frame.size.height*0.23);
    [self.view addSubview:button3];
    [button3 addTarget:self action:@selector(Singer) forControlEvents:UIControlEventTouchUpInside];
    [button3 setImage:[UIImage imageNamed:@"geshou"] forState:UIControlStateNormal];
    button3.adjustsImageWhenHighlighted = NO;
//    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, 100, 40)];
//    label3.text = @"歌手";
//    label3.font = [UIFont systemFontOfSize:20];
//    [label3 setTextColor:[UIColor whiteColor]];
//    [button3.imageView addSubview:label3];
//    [label3 release];
    
       
    
}

-(void)Pushrank
{
    RankViewController *rankVC = [[RankViewController alloc] init];
    [self.navigationController pushViewController:rankVC animated:YES];
    
}

-(void)NewsongFirst
{
    NewSongViewController *newSongVC = [[NewSongViewController alloc] init];
    [self.navigationController pushViewController:newSongVC animated:YES];

}

-(void)Singer
{
    SingerTopViewController *singerTopVC =[[SingerTopViewController alloc] init];
    [self.navigationController pushViewController:singerTopVC animated:YES];
    
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
