//
//  MVXGVideoTableViewCell.m
//  A_program_music
//
//  Created by dlios on 15/6/26.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "MVXGVideoTableViewCell.h"

@implementation MVXGVideoTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubview];
    }
    return self;
}

-(void)createSubview
{
    self.backgroundColor = [UIColor colorWithRed:143.0/255 green:172.0/255 blue:193.0/255 alpha:1];
    
    CGSize  size =[UIScreen mainScreen].bounds.size;
    
    //---------------------设置相关MV图片------------------
    self.imgView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0,size.width - 225*WIDTH, 80*HEIGHT)] autorelease];
    self.imgView.backgroundColor = [UIColor cyanColor];
    [self.contentView addSubview:self.imgView];
    
    //----------------------设置相关MV的歌曲名称----------------
    self.labelSongName = [[[UILabel alloc] initWithFrame:CGRectMake(155*WIDTH, 35*HEIGHT, size.width - 205*WIDTH, 10*HEIGHT)] autorelease];
    self.labelSongName.font = [UIFont systemFontOfSize:12.0];
    _labelSongName.textColor = [UIColor whiteColor];
    [self.contentView addSubview:self.labelSongName];
    
    //-----------------------设置相关MV的歌手名称-----------------
    self.labelArtName = [[[UILabel alloc] initWithFrame:CGRectMake(155*WIDTH, 50*HEIGHT, size.width - 225*WIDTH, 10*HEIGHT)] autorelease];
    self.labelArtName.font = [UIFont systemFontOfSize:13.0];
    self.labelArtName.textColor = [UIColor whiteColor];
    [self.contentView addSubview:self.labelArtName];
}
-(void)setSongName:(NSString *)songName
{
    if (_songName != songName) {
        _songName = [songName copy];
    }
    self.labelSongName.text = self.songName;
}

-(void)setArtName:(NSString *)artName
{
    if (_artName != artName) {
        _artName = [artName copy];
    }
    self.labelArtName.text = self.artName;

}

-(void)setPicUrl:(NSString *)picUrl
{
    if (_picUrl != picUrl) {
        _picUrl = [picUrl copy];
    }
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:self.picUrl] placeholderImage:[UIImage imageNamed:@"zhanweitu"]];

}








- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
    
    
    
}

@end
