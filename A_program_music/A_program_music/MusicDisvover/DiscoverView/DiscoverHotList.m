//
//  DiscoverHotList.m
//  A_program_music
//
//  Created by 姚天成 on 15/6/25.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "DiscoverHotList.h"

@interface DiscoverHotList()
@property(nonatomic,retain)UIImageView *pic;
@property(nonatomic,retain)MusicLabel *listName;
@property(nonatomic,retain)UIImageView *listenCountPic;
@property(nonatomic,retain)UIImageView *autherLabelPic;
@property(nonatomic,retain)MusicLabel *listenCount;
@property(nonatomic,retain)MusicLabel *autherLabel;
@property(nonatomic,retain)MusicLabel *titleLabel;
@end


@implementation DiscoverHotList

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
    
    
    
    
    self.titleLabel = [[[MusicLabel alloc] initWithFrame:CGRectMake(self.pic.frame.origin.x + self.pic.frame.size.width + 10, self.pic.frame.origin.y + 8, 220, 15)] autorelease];

    self.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:self.titleLabel];
    
    self.autherLabelPic = [[[UIImageView alloc] initWithFrame:CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height + 8, 20, 20)] autorelease];
    self.autherLabelPic.image = [UIImage imageNamed:@"sort_artist"];
    [self.contentView addSubview:self.autherLabelPic];
    
    self.autherLabel = [[MusicLabel alloc] initWithFrame:CGRectMake(self.autherLabelPic.frame.origin.x + self.autherLabelPic.frame.size.width + 7, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height + 13, 200, 15)];

    self.autherLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.autherLabel];
    
    self.listenCountPic = [[UIImageView alloc] initWithFrame:CGRectMake(self.autherLabelPic.frame.origin.x, self.autherLabelPic.frame.origin.y + self.autherLabelPic.frame.size.height + 5, 20, 20)];
    self.listenCountPic.image = [UIImage imageNamed:@"love2"];
    [self.contentView addSubview:self.listenCountPic];
    
    self.listenCount = [[MusicLabel alloc] initWithFrame:CGRectMake(self.listenCountPic.frame.origin.x + 25, self.listenCountPic.frame.origin.y + 5, 50, 10)];
    self.listenCount.font = [UIFont systemFontOfSize:8];
    [self.contentView addSubview:self.listenCount];
    

}
-(void)setModel:(DiscoverModel *)model{
    self.listenCount.text = model.listen_count;
    self.titleLabel.text = model.name;
    self.autherLabel.text = model.author;
    [self.pic sd_setImageWithURL:[NSURL URLWithString:model.pic_url]placeholderImage:[UIImage imageNamed:@"smallZhanweitu"]];

}

@end
