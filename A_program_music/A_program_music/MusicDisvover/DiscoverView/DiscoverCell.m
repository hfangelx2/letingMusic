//
//  DiscoverCell.m
//  A_program_music
//
//  Created by 姚天成 on 15/6/19.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "DiscoverCell.h"

@interface DiscoverCell()

@property(nonatomic,retain)UIImageView *pic;
@property(nonatomic,retain)MusicLabel *listName;

@property(nonatomic,retain)MusicLabel *titleLabel;
@property(nonatomic,retain)MusicLabel *autherLabel;

@end


@implementation DiscoverCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatSubView];
    }
    return self;
}

-(void)creatSubView{
    
    self.pic = [[[UIImageView alloc] initWithFrame:CGRectMake(15, 8, 70, 70)] autorelease];
    self.pic.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.pic];
    
    self.titleLabel = [[[MusicLabel alloc] initWithFrame:CGRectMake(self.pic.frame.origin.x + self.pic.frame.size.width + 10, self.pic.frame.origin.y + 12, 150, 15)] autorelease];

    self.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:self.titleLabel];
    
    self.autherLabel = [[MusicLabel alloc] initWithFrame:CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height + 3, 200, 15)];

    self.autherLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.autherLabel];
    
    
    

}

-(void)setModel:(DiscoverModel *)model{


    self.autherLabel.text = model.desc;
    [self.pic sd_setImageWithURL:[NSURL URLWithString:model.pic_url]placeholderImage:[UIImage imageNamed:@"smallZhanweitu"]];
    self.titleLabel.text = model.name;
    
    

}
@end
