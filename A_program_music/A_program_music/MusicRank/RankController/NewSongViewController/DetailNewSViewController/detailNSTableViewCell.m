//
//  detailNSTableViewCell.m
//  A_program_music
//
//  Created by dlios on 15/6/26.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "detailNSTableViewCell.h"
#import "PlayModel.h"

@interface detailNSTableViewCell ()

@property(nonatomic,retain)MusicLabel *label1;
@property(nonatomic,retain)MusicLabel *label2;
@property(nonatomic,retain)MusicLabel *label3;
@property(nonatomic,retain)UIImageView *imageview1;


@end

@implementation detailNSTableViewCell

-(void)dealloc
{
    [_label1 release];
    [_label2 release];
    [_label3 release];
//    [_detailNewSongModel release];
    [_imageview1 release];
    [super dealloc];
}



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createDetailNewSongInfo];
    }
    return self;
}

-(void)createDetailNewSongInfo
{
    CGSize size = [UIScreen mainScreen].bounds.size;
    MusicView *view = [[[MusicView alloc] initWithFrame:CGRectMake(50*WIDTH, 57*HEIGHT, 375*WIDTH, 1)] autorelease];
    view.backgroundColor = [UIColor whiteColor];

    [self.contentView addSubview:view];
    self.label1 = [[MusicLabel alloc] initWithFrame:CGRectMake(10*WIDTH, 15*HEIGHT, size.width - 345*WIDTH, 15*HEIGHT)];
    self.label1.font = [UIFont systemFontOfSize:12];
    [self addSubview:self.label1];
    self.label1.textColor = [UIColor whiteColor];
    [self.label1 release];
    self.label2 = [[MusicLabel alloc] initWithFrame:CGRectMake(50*WIDTH, 5, size.width - 125*WIDTH, 20*HEIGHT)];
    [self addSubview:self.label2];
    self.label2.font = [UIFont systemFontOfSize:15];
    self.label2.textColor = [UIColor whiteColor];
    [self.label2 release];
    //歌手
    self.label3 = [[MusicLabel alloc] initWithFrame:CGRectMake(50*WIDTH, 30*HEIGHT, size.width - 75*WIDTH, 20*HEIGHT)];
    [self addSubview:self.label3];
    self.label3.font = [UIFont systemFontOfSize:12];
    self.label3.textColor = [UIColor whiteColor];
    [self.label3 release];
    
    self.imageview1 = [[UIImageView alloc] initWithFrame:CGRectMake(self.contentView.frame.size.width*1.0*WIDTH, self.contentView.frame.size.height*0.10*HEIGHT, self.contentView.frame.size.width*0.15*WIDTH, self.contentView.frame.size.height*1.0*HEIGHT)];
    [self addSubview:self.imageview1];
    [_imageview1 release];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(collectionLove)];
    [self.imageview1 addGestureRecognizer:tap];
    self.imageview1.userInteractionEnabled = YES;
    self.backgroundColor = [UIColor colorWithRed:143.0/255 green:172.0/255 blue:193.0/255 alpha:1];

}


-(void)setDetailNewSongModel:(DetailNewSongModel *)detailNewSongModel
{
    if (_detailNewSongModel != detailNewSongModel) {
        [_detailNewSongModel release];
        _detailNewSongModel = [detailNewSongModel retain];
    }
  
    
    NSString *str = [NSString stringWithFormat:@"%@",_detailNewSongModel.album_name];
    self.label2.text = str;
    self.label3.text = _detailNewSongModel.singer_name;
    NSString *str1 = [NSString stringWithFormat:@"%ld.",_detailNewSongModel.indexpath.row+1];
    
    self.label1.text = str1;
    self.imageview1.image = [UIImage imageNamed:@"love"];

    self.changeColor = 0;

    NSMutableArray *array = [[CollectSQL shareSQL] selectAllSCPlayModel];
    for (PlayModel *model in array) {
        if ([model.singer_name isEqualToString:_detailNewSongModel.singer_name]&&[model.song_name isEqualToString:_detailNewSongModel.album_name]) {
            
            self.imageview1.image = [UIImage imageNamed:@"love2"];
            
            self.changeColor = 1;
        }
        
        
    }

    
    
    
    
    
    
    
}

-(void)collectionLove
{
    PlayModel *playmodel = [[PlayModel alloc] init];
    playmodel.singer_name = self.detailNewSongModel.singer_name;
    playmodel.song_name = self.detailNewSongModel.album_name;
    playmodel.audition_list = self.detailNewSongModel.audition_list;
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
