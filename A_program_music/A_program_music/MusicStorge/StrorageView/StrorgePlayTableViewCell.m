//
//  StrorgePlayTableViewCell.m
//  A_program_music
//
//  Created by dlios on 15/6/29.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "StrorgePlayTableViewCell.h"
#import "DXAlertView.h"
#import "PlayModel.h"



@implementation StrorgePlayTableViewCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubView];
    }
    return self;
    
}

-(void)createSubView
{
    
    
    self.backgroundColor = [UIColor colorWithRed:143.0/255 green:172.0/255 blue:193.0/255 alpha:1];
    CGSize size = [UIScreen mainScreen].bounds.size;
    
    self.labelSongName = [[UILabel alloc] initWithFrame:CGRectMake(50*WIDTH, 5, size.width - 125*WIDTH, 20*HEIGHT)];
    self.labelSongName.font = [UIFont systemFontOfSize:15.0];
    [self.contentView addSubview:self.labelSongName];
    self.labelSongName.textColor = [UIColor whiteColor];
    
    
    self.labelSingerName = [[UILabel alloc] initWithFrame:CGRectMake(50*WIDTH, 30*HEIGHT, size.width - 75*WIDTH, 20*HEIGHT)];
    self.labelSingerName.font = [UIFont systemFontOfSize:12.0];
    self.labelSingerName.textColor = [UIColor whiteColor];
    [self.contentView addSubview:self.labelSingerName];
    
    
    self.labelNumber = [[UILabel alloc] initWithFrame:CGRectMake(20*WIDTH, 15*HEIGHT, size.width - 345*WIDTH, 15*HEIGHT)];
    self.labelNumber.font = [UIFont systemFontOfSize:15.0];
    self.labelNumber.textColor = [UIColor whiteColor];
    [self.contentView addSubview:self.labelNumber];
  
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.frame = CGRectMake(self.contentView.frame.size.width*1.0*WIDTH, self.contentView.frame.size.height*0.10*HEIGHT, self.contentView.frame.size.width*0.15*WIDTH, self.contentView.frame.size.height*1.0*HEIGHT);
    [self.button setImage:[UIImage imageNamed:@"love"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.button];
    self.panduan =0;
    
    UIView *viewA = [[UIView alloc] initWithFrame:CGRectMake(50*WIDTH, 57*HEIGHT, 375*WIDTH, 1)];
    viewA.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:viewA];
    
    [self.button addTarget:self action:@selector(buttonCollect) forControlEvents:UIControlEventTouchUpInside];
    

}

-(void)setStorgeModel:(StorgePlayModel *)storgeModel
{
    if (_storgeModel != storgeModel) {
        [_storgeModel release];
        _storgeModel = [storgeModel retain];
    }
    
    self.labelSingerName.text = storgeModel.singerName;
    self.labelSongName.text = storgeModel.name;
    
    
    
    NSMutableArray *array = [[CollectSQL shareSQL] selectAllSCPlayModel];
    for (PlayModel *model in array) {
        if ([model.singer_name isEqualToString:self.labelSingerName.text]&&[model.song_name isEqualToString:self.labelSongName.text]) {
            
            [self.button setImage:[UIImage imageNamed:@"love2"] forState:UIControlStateNormal ];
            NSLog(@"1111111%@",self.storgeModel.singerName);
            self.panduan = 1;
        }
        
    }

}










-(void)buttonCollect
{
   // self.storgeModel = [[[StorgePlayModel alloc] init] autorelease];
    PlayModel *playmodel = [[PlayModel alloc] init];
    playmodel.singer_name = self.storgeModel.singerName;
    playmodel.song_name = self.storgeModel.name;
    playmodel.audition_list = self.storgeModel.auditionList;
    NSLog(@"00000000%@",self.storgeModel.singerName);
    if (self.panduan == 0) {
    
        [[CollectSQL shareSQL] insertSCMusicWithPlayModel:playmodel];
        
        [self.button setImage:[UIImage imageNamed:@"love2"] forState:UIControlStateNormal];
        self.panduan = 1;
        DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"提示" contentText:@"已添加收藏" leftButtonTitle:nil rightButtonTitle:@"嗯呢"];
        [alert show];

    }else if (self.panduan == 1) {
        
        [[CollectSQL shareSQL]deleteSCMusicWithPlayModel:playmodel];
         [self.button setImage:[UIImage imageNamed:@"love"] forState:UIControlStateNormal];
        self.panduan = 0;
        DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"提示" contentText:@"已取消收藏" leftButtonTitle:nil rightButtonTitle:@"好嘞"];
        [alert show];
        
        
    }
    
    
}















- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
