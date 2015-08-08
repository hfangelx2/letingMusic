
//
//  MusicSetViewController.m
//  A_program_music
//
//  Created by dlios on 15/6/27.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "MusicSetViewController.h"
#import "MainViewController.h"
#import "HelpController.h"

@interface MusicSetViewController ()

@property (strong, readwrite, nonatomic) UITableView *tableView;
@property(nonatomic,retain)UIImageView *imageview2;
@property(nonatomic,retain)UIButton *selectedButton;



@end

@implementation MusicSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    设置头像
    self.imageview2 = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.55, self.view.frame.size.height*0.15, self.view.frame.size.width*0.23, self.view.frame.size.width*0.23)];
    self.imageview2.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.imageview2];
    [self.imageview2 release];
    self.imageview2.image = [UIImage imageNamed:@"logo3"];
    //UITapGestureRecognizer *tap = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changePhone)] autorelease];
    //[self.imageview2 addGestureRecognizer:tap];
    self.imageview2.userInteractionEnabled = YES;
    self.imageview2.layer.masksToBounds = YES;
    self.imageview2.layer.cornerRadius = self.view.frame.size.width*0.23/2;
    
    //    我的收藏按钮
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.4, self.view.frame.size.height*0.3, self.view.frame.size.width*0.5, self.view.frame.size.height*0.1)];
    [button1 setTitle:@"我的收藏" forState:UIControlStateNormal];
//    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(pushToCollection:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    button1.adjustsImageWhenHighlighted = NO;
    [button1 release];
    [button1 setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:160/255.0 green:90/255.0 blue:205/255.0 alpha:0.3]] forState:UIControlStateSelected];
    
//    帮助指南按钮
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.4, self.view.frame.size.height*0.45, self.view.frame.size.width*0.5, self.view.frame.size.height*0.1)];
    [button2 setTitle:@"帮助指南" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(pushToHelp:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    [button2 setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:215/255.0 blue:0/255.0 alpha:0.3]] forState:UIControlStateSelected];
    [button2 release];

//    设置按钮
    UIButton *button3 = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.4, self.view.frame.size.height*0.6, self.view.frame.size.width*0.5, self.view.frame.size.height*0.1)];
    [button3 setTitle:@"设置" forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(pushToSet:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
    [button3 setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:0 green:0 blue:255/255.0 alpha:0.3]] forState:UIControlStateSelected];
    
    [button3 release];
    
    
//    关于我们
    
    UIButton *button4 = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.4, self.view.frame.size.height*0.75, self.view.frame.size.width*0.5, self.view.frame.size.height*0.1)];
    [button4 setTitle:@"返回主页" forState:UIControlStateNormal];
    [button4 addTarget:self action:@selector(pushTomain:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button4];
    [button4 setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:124/255.0 green:252/255.0 blue:0 alpha:0.3]] forState:UIControlStateSelected];
    [button4 release];
    
    
    
    
    
}
/*
-(void)changePhone
{
    
    [self showImagePickController];
    
}

-(void)showImagePickController
{
    UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
    //  选择类型 （照片库模式， 相机模式， 相机胶片模式）
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;//代理
    imagePicker.allowsEditing = YES;//是否允许编辑
    // 模态，进入相册
    [self presentViewController:imagePicker animated:YES completion:^{
        
    }];
    
    [imagePicker release];
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //获取到选中的照片 并显示 并赋值给view的属性headImageView
    self.imageview2.image = [info valueForKey:@"UIImagePickerControllerOriginalImage"];
    // 通过模态返回
    [picker dismissViewControllerAnimated:YES completion:^{
        
        
    }];
    
}

-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    // 通过模态消失
    [picker dismissViewControllerAnimated:YES completion:^{
        
        
    }];
}
*/
-(void)pushToCollection:(UIButton *)button
{
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
    CollectionVC *collectionVC = [[CollectionVC alloc] init];
    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:collectionVC] animated:YES];//改变主界面页面
    [self.sideMenuViewController hideMenuViewController];//返回主界面
    
    [self.sideMenuViewController.navigationController pushViewController:collectionVC animated:YES];
    
}

-(void)pushTomain:(UIButton *)button
{
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[MainViewController alloc] init]]
                                                 animated:YES];
    [self.sideMenuViewController hideMenuViewController];




}

-(void)pushToHelp:(UIButton *)button

{
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;

    HelpController *help = [[HelpController alloc] init];
    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:help] animated:YES];//改变主界面页面
    [self.sideMenuViewController hideMenuViewController];//返回主界面
    
    [self.sideMenuViewController.navigationController pushViewController:help animated:YES];


}

-(void)pushToSet:(UIButton *)button
{
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
    
    SetViewController *SetVC = [SetViewController  ShareSetHandle];
    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:SetVC] animated:YES];//改变主界面页面
    [self.sideMenuViewController hideMenuViewController];//返回主界面
    
    [self.sideMenuViewController.navigationController pushViewController:SetVC animated:YES];

}


//创建按钮颜色设置

-(UIImage *)imageWithColor:(UIColor *)color
{
    
//    开启基于位图的图形上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(self.view.frame.size.width*0.5, self.view.frame.size.height*0.1), NO, 0.0);
    
//    画一个color颜色的矩形框
    [color set];
    UIRectFill(CGRectMake(0, 0, self.view.frame.size.width*0.5, self.view.frame.size.height*0.1));
//    拿到图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    关闭上下文
    
    UIGraphicsEndImageContext();
    
    return image;
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
