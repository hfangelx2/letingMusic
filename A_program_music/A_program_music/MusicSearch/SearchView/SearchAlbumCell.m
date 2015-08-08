//
//  SearchAlbumCell.m
//  A_program_music
//
//  Created by 姚天成 on 15/6/22.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "SearchAlbumCell.h"

@interface SearchAlbumCell()

@property(nonatomic,retain)UIImageView *album_pic;
@property(nonatomic,retain)MusicLabel *album_name;
@property(nonatomic,retain)MusicLabel *album_detail;


@end





@implementation SearchAlbumCell

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
    self.album_pic = [[UIImageView alloc] initWithFrame:CGRectMake(15, 5, 75, 75)];
    self.album_name = [[MusicLabel alloc] initWithFrame:CGRectMake(self.album_pic.frame.origin.x + self.album_pic.frame.size.width + 20, self.album_pic.frame.origin.y + 23, 180, 15)];
    self.album_detail = [[MusicLabel alloc] initWithFrame:CGRectMake(self.album_name.frame.origin.x, self.album_name.frame.origin.y + 20, self.album_name.frame.size.width, self.album_name.frame.size.height)];
    self.album_detail.font = [UIFont systemFontOfSize:14];
    self.album_detail.textColor = [UIColor whiteColor];
    //MusicView *lineView = [[MusicView alloc] initWithFrame:CGRectMake(self.album_pic.frame.size.width + 5, self.frame.size.width - self.album_name.frame.origin.y, self.frame.size.width - self.album_name.frame.size.width, 2)];
    //lineView.backgroundColor = [UIColor redColor];
    //[self.contentView addSubview:lineView];
    [self.contentView addSubview:self.album_pic];
    [self.contentView addSubview:self.album_name];
    [self.contentView addSubview:self.album_detail];




}



-(void)setModel:(SearchAlbumModel *)model{

    [self.album_pic sd_setImageWithURL:[NSURL URLWithString:model.pic200]placeholderImage:[UIImage imageNamed:@"smallZhanweitu"]];
    self.album_name.text = model.name;
    //NSLog(@"%@",self.album_name.text);
    NSString *str = [NSString stringWithFormat:@"%@ %@",model.singer_name,model.publish_time];
    self.album_detail.text = str;


}
@end
