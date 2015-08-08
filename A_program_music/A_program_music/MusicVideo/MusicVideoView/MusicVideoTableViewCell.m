//
//  MusicVideoTableViewCell.m
//  A_program_music
//
//  Created by dlios on 15/6/23.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "MusicVideoTableViewCell.h"

@implementation MusicVideoTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createInfo];
    }
    return self;
}

-(void)createInfo
{
    CGSize  size =[UIScreen mainScreen].bounds.size;
    

    self.imageV = [[[UIImageView alloc] initWithFrame:CGRectMake(0*WIDTH, 0*HEIGHT, size.width, 170*HEIGHT)] autorelease];
   
    
    [self.contentView addSubview:self.imageV];
    
    self.labelTitle = [[[UILabel alloc] initWithFrame:CGRectMake(5*WIDTH, 140*HEIGHT, self.contentView.frame.size.width-50*WIDTH, 20*HEIGHT)] autorelease];
    [self.contentView addSubview:self.labelTitle];
    self.labelTitle.textColor = [UIColor whiteColor];
    
    [self.labelTitle setFont:[UIFont fontWithName:@"宋体-简-粗体" size:12.0]];

}


-(void)setPicUrl:(NSString *)picUrl
{

    if (_picUrl != picUrl) {
        _picUrl = [picUrl copy];
    }
    
    
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:self.picUrl] placeholderImage:[UIImage imageNamed:@"zhanweitu"]];

}

-(void)setTitle:(NSString *)title
{
    if (_title != title) {
        _title = [title copy];
    }
    self.labelTitle.text = self.title;
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
