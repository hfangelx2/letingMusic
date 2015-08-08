//
//  DiscoverNewSongController.m
//  A_program_music
//
//  Created by 姚天成 on 15/6/24.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "DiscoverNewSongController.h"

@interface DiscoverNewSongController ()
@property(nonatomic,retain)SCNavTabBarController *navController;
@property(nonatomic,retain)ChineseController *chinese;
@property(nonatomic,retain)AmericaController *America;
@property(nonatomic,retain)KoreaController *korea;
@property(nonatomic,retain)MBProgressHUD *MB;
@end

@implementation DiscoverNewSongController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.chinese = [[[ChineseController alloc] init] autorelease];
    self.chinese.title = @"华语";
    self.America = [[[AmericaController alloc] init] autorelease];
    self.America.title = @"欧美";
    self.korea = [[[KoreaController alloc] init] autorelease];
    self.korea.title = @"日韩";
    self.navController = [[[SCNavTabBarController alloc] init] autorelease];
    self.navController.subViewControllers = @[_chinese, _America, _korea];
    //关闭显示向下抽屉小箭头
    self.navController.showArrowButton = NO;
    [self.navController addParentController:self];
   
    
}

-(void)setIdArray:(NSMutableArray *)idArray{

    self.chinese.IDD = [idArray objectAtIndex:0];
    self.America.IDD = [idArray objectAtIndex:1];
    self.korea.IDD = [idArray objectAtIndex:2];

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
