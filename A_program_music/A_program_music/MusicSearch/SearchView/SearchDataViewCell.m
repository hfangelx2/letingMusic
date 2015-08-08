//
//  SearchDataViewCell.m
//  NewMyMusicAPP
//
//  Created by 08- 张志强 on 15/6/26.
//  Copyright (c) 2015年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "SearchDataViewCell.h"


@implementation SearchDataViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self searchMake];
    }
    
    return self;
}

-(void)searchMake
{
    
        self.backgroundColor = [UIColor colorWithRed:143.0/255 green:172.0/255 blue:193.0/255 alpha:1];
    self.albumImg = [[UIImageView alloc]init];
    self.albumImg.frame=CGRectMake(WIDTH * 5,HEIGHT * 5,WIDTH * 170,HEIGHT * 100);
    self.albumImg.contentMode = UIViewContentModeScaleToFill;
    [self.albumImg setClipsToBounds:YES];
    [self.albumImg setContentMode:UIViewContentModeScaleToFill];
    [self.contentView addSubview:self.albumImg];
    
    self.titleLable = [[[UILabel alloc]initWithFrame:CGRectMake(WIDTH * 190,HEIGHT * 30,WIDTH * 190,HEIGHT * 30)]autorelease];
    self.titleLable.backgroundColor=[UIColor clearColor];
    self.titleLable.font=[UIFont systemFontOfSize:14];

    self.titleLable.numberOfLines=0;
    self.titleLable.textColor=[UIColor blackColor];
    self.titleLable.textAlignment=NSTextAlignmentLeft;
    [self.contentView addSubview:self.titleLable];
    
    self.artistNameLable= [[[UILabel alloc]initWithFrame:CGRectMake(WIDTH * 190,HEIGHT * 50,WIDTH * 190,HEIGHT * 30)]autorelease];
    self.artistNameLable.backgroundColor=[UIColor clearColor];
    self.artistNameLable.font=[UIFont systemFontOfSize:14];

    self.artistNameLable.numberOfLines=0;
    self.artistNameLable.textColor=[UIColor whiteColor];
    self.artistNameLable.textAlignment=NSTextAlignmentLeft;
    [self addSubview:self.artistNameLable];
    
}

-(void)setModel:(SearchMVModel *)model
{
    //NSLog(@"走吧走吧走吧");
    if (_model != model) {
        [_model release];
        _model = [model retain];
    }
    self.titleLable.text=self.model.title;
    self.artistNameLable.text = self.model.artistName;
    
    if (self.model.albumImg.length == 0) {
        NSURL *url = [NSURL URLWithString:self.model.posterPic];
        [self.albumImg sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"zhanweitu-1"]];
        
    }else{
        
        NSURL *url = [NSURL URLWithString:self.model.albumImg];
        [self.albumImg sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"zhanweitu-1"]];
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
