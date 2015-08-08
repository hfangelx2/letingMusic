//
//  SearchSongListCell.m
//  A_program_music
//
//  Created by 姚天成 on 15/6/24.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "SearchSongListCell.h"

@interface SearchSongListCell()

@property(nonatomic,retain)UIImageView *songList_pic;
@property(nonatomic,retain)MusicLabel *songList_name;
@property(nonatomic,retain)MusicLabel *songList_detail;


@end



@implementation SearchSongListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatSubView];
    }
    return self;
}
//创建cell
-(void)creatSubView{
    self.backgroundColor = [UIColor colorWithRed:143.0/255 green:172.0/255 blue:193.0/255 alpha:1];
    self.songList_pic = [[UIImageView alloc] initWithFrame:CGRectMake(15, 5, 75, 75)];
    self.songList_name = [[MusicLabel alloc] initWithFrame:CGRectMake(self.songList_pic.frame.origin.x + self.songList_pic.frame.size.width + 20, self.songList_pic.frame.origin.y + 23, 180, 15)];
    
    [self.contentView addSubview:self.songList_pic];
    [self.contentView addSubview:self.songList_name];

    
    
    
    
}



-(void)setModel:(SearchSongListModel *)model{
    
    [self.songList_pic sd_setImageWithURL:[NSURL URLWithString:model.pic_url]placeholderImage:[UIImage imageNamed:@"smallZhanweitu"]];
    self.songList_name.text = model.title;
    
    
}



@end
