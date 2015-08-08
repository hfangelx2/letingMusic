//
//  RankTableViewCell.m
//  A_program_music
//
//  Created by dlios on 15/6/19.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "RankTableViewCell.h"


@interface RankTableViewCell()


@property(nonatomic,retain)MusicLabel *label1;
@property(nonatomic,retain)MusicLabel *label2;
@property(nonatomic,retain)MusicLabel *label3;
@property(nonatomic,retain)MusicLabel *label4;

@property(nonatomic,retain)UIImageView *myImageView1;


@end


@implementation RankTableViewCell

-(void)dealloc
{
//    [_label1 release];
//    [_label2 release];
//    [_label3 release];
//    [_label4 release];
    [_model release];
  
    [super dealloc];
    
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createRankCellInfo];
    }

    return self;
}


-(void)createRankCellInfo
{
    
    self.label1 = [[MusicLabel alloc] initWithFrame:CGRectMake(150*WIDTH, 30*HEIGHT, 200*WIDTH, 30*HEIGHT)];
    self.label1.font = [UIFont systemFontOfSize:18];

    [self addSubview:self.label1];
    [self.label1 release];
    
    self.label2 = [[MusicLabel alloc] initWithFrame:CGRectMake(150*WIDTH, 70*HEIGHT, 200*WIDTH, 20*HEIGHT)];

    self.label2.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.label2];
    [self.label2 release];
    
    self.label3 = [[MusicLabel alloc] initWithFrame:CGRectMake(150*WIDTH, 100*HEIGHT, 200*WIDTH, 20*HEIGHT)];

    self.label3.font = [UIFont systemFontOfSize:14];

    [self addSubview:self.label3];
    [self.label3 release];
    
    self.label4 = [[MusicLabel alloc] initWithFrame:CGRectMake(150*WIDTH, 130*HEIGHT, 200*WIDTH, 20*HEIGHT)];

    self.label4.font = [UIFont systemFontOfSize:14];

    [self addSubview:self.label4];
    [self.label4 release];
    
    self.myImageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(10*WIDTH, 30*HEIGHT, 120*WIDTH, 120*HEIGHT)];
    self.myImageView1.backgroundColor = [UIColor cyanColor];
    [self addSubview:self.myImageView1];
    [self.myImageView1 release];
    
    
    

}


-(void)setModel:(RankModel *)model
{
    if (_model != model) {
        [_model release];
        _model = [model retain];
        
    }
    
    self.label1.text = _model.title;
    NSMutableDictionary *dic1 = [_model.array objectAtIndex:0];
    NSString *str1 = [dic1 objectForKey:@"songName"];
    NSString *str2 = [dic1 objectForKey:@"singerName"];
    self.label2.text = [NSString stringWithFormat:@"%@ - %@",str1,str2];
    
    NSMutableDictionary *dic2 = [_model.array objectAtIndex:1];
    NSString *str3 = [dic2 objectForKey:@"songName"];
    NSString *str4 = [dic2 objectForKey:@"singerName"];
    self.label3.text = [NSString stringWithFormat:@"%@ - %@",str3,str4];
    
    NSMutableDictionary *dic3 = [_model.array objectAtIndex:2];
    NSString *str5 = [dic3 objectForKey:@"songName"];
    NSString *str6 = [dic3 objectForKey:@"singerName"];
    self.label4.text = [NSString stringWithFormat:@"%@ - %@",str5,str6];
    
    
    
    NSString *str = _model.pic_url;
    NSURL *url = [NSURL URLWithString:str];
    [self.myImageView1 sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"smallZhanweitu"]];

 


}










/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
