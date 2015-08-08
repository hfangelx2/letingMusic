//
//  RankDitailTableViewCell.m
//  A_program_music
//
//  Created by dlios on 15/6/22.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "RankDitailTableViewCell.h"
#import "CollectSQL.h"
#import "PlayModel.h"
@implementation RankDitailTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createRankDitailInfo];
    }

    return self;
}

-(void)createRankDitailInfo
{
    CGSize size = [UIScreen mainScreen].bounds.size;
    self.backgroundColor = [UIColor colorWithRed:143.0/255 green:172.0/255 blue:193.0/255 alpha:1];
    //歌名
    self.label1 = [[UILabel alloc] initWithFrame:CGRectMake(50*WIDTH, 5, size.width - 125*WIDTH, 20*HEIGHT)];
    self.label1.font = [UIFont systemFontOfSize:15];
    self.label1.textColor = [UIColor whiteColor];
    [self addSubview:self.label1];
    [self.label1 release];
    //歌手
    self.label2 = [[UILabel alloc] initWithFrame:CGRectMake(50*WIDTH, 30*HEIGHT, size.width - 75*WIDTH, 20*HEIGHT)];
    self.label2.font = [UIFont systemFontOfSize:12];
    self.label2.textColor = [UIColor whiteColor];

    [self addSubview:self.label2];
    [self.label2 release];
    //数字
    self.label3 = [[UILabel alloc] initWithFrame:CGRectMake(10*WIDTH, 15*HEIGHT, size.width - 345*WIDTH, 15*HEIGHT)];
    self.label3.textColor = [UIColor whiteColor];

//    [[CollectSQL shareSQL] deleteAllSCPlayMusic];
    self.label3.font = [UIFont systemFontOfSize:12];
    [self addSubview:self.label3];
    [self.label3 release];
    //收藏
    self.imageview1 = [[UIImageView alloc] initWithFrame:CGRectMake(self.contentView.frame.size.width*1.0*WIDTH, self.contentView.frame.size.height*0.10*HEIGHT, self.contentView.frame.size.width*0.15*WIDTH, self.contentView.frame.size.height*1.0*HEIGHT)];
//    self.imageview1.image = [UIImage imageNamed:@"love"];
//    self.changeColor = 0;
    [self addSubview:self.imageview1];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(collectionLove)];
    [self.imageview1 addGestureRecognizer:tap];
    self.imageview1.userInteractionEnabled = YES;
    MusicView *view = [[[MusicView alloc] initWithFrame:CGRectMake(50*WIDTH, 57*HEIGHT, 375*WIDTH, 1)] autorelease];
    view.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:view];
}

-(void)setRankDitailmodel:(RankDitailModel *)rankDitailmodel
{
    if (_rankDitailmodel != rankDitailmodel) {
        [_rankDitailmodel release];
        _rankDitailmodel = [rankDitailmodel retain];
    }

    self.label1.text = _rankDitailmodel.name;
    self.label2.text = _rankDitailmodel.singerName;
    self.label3.text = [NSString stringWithFormat:@"%@.",_rankDitailmodel.number];
    self.imageview1.image = [UIImage imageNamed:@"love"];
    self.changeColor = 0;

    NSMutableArray *array = [[CollectSQL shareSQL] selectAllSCPlayModel];
    for (PlayModel *model in array) {
        if ([model.singer_name isEqualToString:_rankDitailmodel.singerName]&&[model.song_name isEqualToString:_rankDitailmodel.name]) {
            
            self.imageview1.image = [UIImage imageNamed:@"love2"];

            self.changeColor = 1;
        }
     /*   if ([model.singer_name containsString:_rankDitailmodel.singerName] &&[model.song_name containsString:_rankDitailmodel.name]) {
            self.imageview1.image = [UIImage imageNamed:@"love2"];
            self.changeColor = 1;

            return;
        }*/
        

    }
  
    

}


-(void)dealloc
{
    [_label1 release];
    [_label2 release];
    [_label3 release];
    [_imageview1 release];
    [_rankDitailmodel release];
    [super dealloc];
}

-(void)collectionLove
{
    PlayModel *playmodel = [[PlayModel alloc] init];
    playmodel.singer_name = self.rankDitailmodel.singerName;
    playmodel.song_name = self.rankDitailmodel.name;
    playmodel.audition_list = self.rankDitailmodel.auditionList;
    NSLog(@"%@",playmodel.song_name);
    if (self.changeColor == 0) {
         NSLog(@"11111");
        self.imageview1.image = [UIImage imageNamed:@"love2"];
        [[CollectSQL shareSQL] insertSCMusicWithPlayModel:playmodel];
       
        
    }
    
    if (self.changeColor == 1) {
        NSLog(@"222222");
        self.imageview1.image = [UIImage imageNamed:@"love"];
        [[CollectSQL shareSQL] deleteSCMusicWithPlayModel:playmodel];
        
        
    }
    
    self.changeColor = !self.changeColor;
    
    
    


}






/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
