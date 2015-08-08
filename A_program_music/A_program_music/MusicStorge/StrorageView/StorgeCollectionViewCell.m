//
//  StorgeCollectionViewCell.m
//  A_program_music
//
//  Created by dlios on 15/6/20.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "StorgeCollectionViewCell.h"




@interface StorgeCollectionViewCell ()

@property(nonatomic,retain)MusicLabel *labelSmallTitle;
@property(nonatomic,retain)MusicLabel *labelBigTitle;

@end

@implementation StorgeCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self =  [super initWithFrame:frame];
    if (self) {
        [self createSubView];
    }
    return self;
    
}

-(void)createSubView
{
    
    self.imageV = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
    [self.contentView addSubview:self.imageV];
    self.labelSmallTitle = [[[MusicLabel alloc] initWithFrame:CGRectMake(0*WIDTH, 115*HEIGHT, 110*WIDTH, 20*HEIGHT)] autorelease];
 
    self.labelSmallTitle.font = [UIFont systemFontOfSize:12.0];
    [self.contentView addSubview:self.labelSmallTitle];
    
    
    self.labelBigTitle = [[[MusicLabel alloc] initWithFrame:CGRectMake(0, 0, 20*WIDTH, 20*HEIGHT)]autorelease];
   // self.labelBigTitle.text = @"热门";
    self.labelBigTitle.font = [UIFont systemFontOfSize:15.0];
    //[ addSubview:self.labelBigTitle];
    
    
    
}





-(void)setPicture:(NSString *)picture
{
 
    if (_picture != picture) {
        _picture = [picture copy];
    }
    
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:self.picture]placeholderImage:[UIImage imageNamed:@"smallZhanweitu"]];
  
}

-(void)setTitleSmall:(NSString *)titleSmall
{
    if (_titleSmall != titleSmall) {
        _titleSmall = [titleSmall copy];
    }

    self.labelSmallTitle.text = self.titleSmall;

}

-(void)setTitleBig:(NSString *)titleBig
{
    if (_titleBig != titleBig) {
        _titleBig = [titleBig copy];
    }

    
}




@end
