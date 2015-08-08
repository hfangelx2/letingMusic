

//
//  SingSongTableViewCell.m
//  A_program_music
//
//  Created by dlios on 15/6/24.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "SingSongTableViewCell.h"
#import "PlayModel.h"

@interface SingSongTableViewCell ()

@property(nonatomic,retain)MusicLabel *label1;
@property(nonatomic,retain)MusicLabel *label2;
@property(nonatomic,retain)MusicLabel *label3;
@property(nonatomic,retain)UIImageView *imageview1;

@end


@implementation SingSongTableViewCell

-(void)dealloc
{
    [_label1 release];
    [_label2 release];
    [_label3 release];
    [_imageview1 release];
   
    [super dealloc];
}










-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createCellInfo];
    }

    return self;
}

-(void)createCellInfo
{
    CGSize size = [UIScreen mainScreen].bounds.size;
    //歌名
    self.label1 = [[MusicLabel alloc] initWithFrame:CGRectMake(50*WIDTH, 5, size.width - 125*WIDTH, 20*HEIGHT)];
    [self addSubview:self.label1];
    self.label1.textColor = [UIColor whiteColor];
    self.label1.font = [UIFont systemFontOfSize:15];
    [self.label1 release];

    self.label2 = [[MusicLabel alloc] initWithFrame:CGRectMake(50*WIDTH, 30*HEIGHT, size.width - 75*WIDTH, 20*HEIGHT)];
    self.label2.font = [UIFont systemFontOfSize:12];
    [self addSubview:self.label2];
    self.label2.textColor = [UIColor whiteColor];

    [self.label2 release];
    //数字
    self.label3 = [[MusicLabel alloc] initWithFrame:CGRectMake(10*WIDTH, 15*HEIGHT, size.width - 345*WIDTH, 15*HEIGHT)];
    self.label3.font = [UIFont systemFontOfSize:12];
    self.label3.textColor = [UIColor whiteColor];

    [self addSubview:self.label3];
    [self.label3 release];
    
    self.imageview1 = [[UIImageView alloc] initWithFrame:CGRectMake(self.contentView.frame.size.width*1.0*WIDTH, self.contentView.frame.size.height*0.10*HEIGHT, self.contentView.frame.size.width*0.15*WIDTH, self.contentView.frame.size.height*1.0*HEIGHT)];
    
    [self addSubview:self.imageview1];
    [_imageview1 release];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(collectionLove)];
    [self.imageview1 addGestureRecognizer:tap];
    self.imageview1.userInteractionEnabled = YES;
    self.backgroundColor = [UIColor colorWithRed:143.0/255 green:172.0/255 blue:193.0/255 alpha:1];
    MusicView *view = [[[MusicView alloc] initWithFrame:CGRectMake(50*WIDTH, 57*HEIGHT, 375*WIDTH, 1)] autorelease];
    view.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:view];

}

-(void)setModel:(SingerSongModel *)model
{
    if (_model != model) {
        [_model release];
        _model = [model retain];
    }
    self.label1.text = _model.name;
    self.label2.text = _model.singerName;
      self.label3.text = _number;
    self.imageview1.image = [UIImage imageNamed:@"love"];
    self.changeColor = 0;

    
    NSMutableArray *array = [[CollectSQL shareSQL] selectAllSCPlayModel];
    for (PlayModel *model in array) {
        if ([model.singer_name isEqualToString:_model.singerName]&&[model.song_name isEqualToString:_model.name]) {
            
            self.imageview1.image = [UIImage imageNamed:@"love2"];
            
            self.changeColor = 1;
        }
        
        
    }
    
 
    
    
}

-(void)collectionLove
{
    
    PlayModel *playmodel = [[PlayModel alloc] init];
    playmodel.singer_name = self.model.singerName;
    playmodel.song_name = self.model.name;
    playmodel.audition_list = self.model.audition_list;
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
