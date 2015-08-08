//
//  SearchController.h
//  A_program_music
//
//  Created by 姚天成 on 15/6/19.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "MusicViewController.h"
#import "SearchMainController.h"
#import "CloudView.h"


@protocol searchPageDelegate <NSObject>

-(void)viewDisplayView;
-(void)hideView1;
@end


@interface SearchController : MusicViewController<UITextFieldDelegate,CloudViewDelegate,searchMainDelegate>

@property(nonatomic,retain)NSMutableArray *AllSoArray;
@property(nonatomic,assign)id<searchPageDelegate>mydelegate;
@property(nonatomic,retain)SearchMainController *searchPage;



@end
