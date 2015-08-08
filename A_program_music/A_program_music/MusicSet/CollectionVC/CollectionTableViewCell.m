


//
//  CollectionTableViewCell.m
//  A_program_music
//
//  Created by dlios on 15/7/3.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "CollectionTableViewCell.h"


@interface CollectionTableViewCell ()

@property(nonatomic,retain)MusicLabel *label1;
@property(nonatomic,retain)MusicLabel *label2;
@property(nonatomic,retain)MusicLabel *label3;





@end



@implementation CollectionTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createrInfo];
        
    }
    
    return self;





}


-(void)createrInfo
{
    CGSize size = [UIScreen mainScreen].bounds.size;
    self.backgroundColor = [UIColor colorWithRed:143.0/255 green:172.0/255 blue:193.0/255 alpha:1];
    self.label1 = [[MusicLabel alloc] initWithFrame:CGRectMake(10*WIDTH, 15*HEIGHT, size.width - 345*WIDTH, 15*HEIGHT)];//数字
    [self addSubview:self.label1];
    [self.label1 release];
    self.label1.font = [UIFont systemFontOfSize:12];
    self.label2 = [[MusicLabel alloc] initWithFrame:CGRectMake(50*WIDTH, 5, size.width - 125*WIDTH, 20*HEIGHT)];//歌名
    self.label2.font = [UIFont systemFontOfSize:15];
    [self addSubview:self.label2];
    [self.label2 release];
    self.label3 = [[MusicLabel alloc] initWithFrame:CGRectMake(50*WIDTH, 30*HEIGHT, size.width - 75*WIDTH, 20*HEIGHT)];//歌手
    self.label3.font = [UIFont systemFontOfSize:12];

    [self addSubview:self.label3];
    [self.label3 release];
    MusicView *view = [[[MusicView alloc] initWithFrame:CGRectMake(50*WIDTH, 57*HEIGHT, 375*WIDTH, 1)] autorelease];
    view.backgroundColor = [UIColor whiteColor];
    //[self.contentView addSubview:view];
}


-(void)setPlayModel:(PlayModel *)playModel
{
    if (_playModel != playModel) {
        [_playModel release];
        _playModel = [playModel retain];
    }
    self.label1.text = [NSString stringWithFormat:@"%@.",_number];
    self.label2.text = _playModel.song_name;
    self.label3.text = _playModel.singer_name;
    
   
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
