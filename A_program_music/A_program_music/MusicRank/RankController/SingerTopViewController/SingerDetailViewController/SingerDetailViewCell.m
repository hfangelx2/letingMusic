//
//  SingerDetailViewCell.m
//  A_program_music
//
//  Created by dlios on 15/6/23.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "SingerDetailViewCell.h"

@interface SingerDetailViewCell ()

@property(nonatomic,retain)UIImageView *imageview1;
@property(nonatomic,retain)MusicLabel *label1;


@end



@implementation SingerDetailViewCell


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
   
    self.imageview1 =[[[UIImageView alloc] initWithFrame:CGRectMake(10*WIDTH, 10*HEIGHT, 60*WIDTH, 60*HEIGHT)] autorelease];
    
    [self addSubview:self.imageview1];
    self.imageview1.layer.masksToBounds = YES;
    self.imageview1.layer.cornerRadius = 30*WIDTH;
    
    self.label1 = [[MusicLabel alloc] initWithFrame:CGRectMake(90*WIDTH, 10*HEIGHT, 200*WIDTH, 60*HEIGHT)];
   
    [self addSubview:self.label1];
    self.label1.font = [UIFont systemFontOfSize:25*WIDTH];
    

}

-(void)setDetailModel:(SingerDetailModel *)detailModel
{
    if (_detailModel != detailModel) {
        [_detailModel release];
        _detailModel = [detailModel retain];
        
    }
    self.label1.text = _detailModel.singer_name;
    
    NSURL *url = [NSURL URLWithString:_detailModel.pic_url];
    [self.imageview1 sd_setImageWithURL:url placeholderImage:nil];

}








/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
