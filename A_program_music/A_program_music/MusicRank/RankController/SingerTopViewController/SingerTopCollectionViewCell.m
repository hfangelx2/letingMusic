
//
//  SingerTopCollectionViewCell.m
//  A_program_music
//
//  Created by dlios on 15/6/23.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "SingerTopCollectionViewCell.h"

@interface SingerTopCollectionViewCell ()

@property(nonatomic,retain)UIImageView *imageview;
@property(nonatomic,retain)UILabel *label;

@end



@implementation SingerTopCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if ( self) {
        [self createCellInfo];
    }

    return self;
}

-(void)createCellInfo
{
    self.imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0*WIDTH, 0*HEIGHT, self.frame.size.width*WIDTH, (self.frame.size.height-20)*HEIGHT)];
    
    [self addSubview:self.imageview];
    [self.imageview release];
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0*WIDTH, (self.frame.size.height-20)*HEIGHT, self.frame.size.width*WIDTH, 20*HEIGHT)];
   
    [self addSubview:self.label];
    [self.label release];
    

}

-(void)setModel:(SingerModel *)model
{
    if (_model != model) {
        [_model release];
        _model = [model retain];
    }
    
    self.label.text = _model.title;
    NSURL *url = [NSURL URLWithString:model.pic_url];
    [self.imageview sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"smallZhanweitu"]];

}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
