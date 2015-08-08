//
//  SearchSingerCell.m
//  A_program_music
//
//  Created by 姚天成 on 15/6/21.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "SearchSingerCell.h"

@interface SearchSingerCell()

@property(nonatomic,retain)UIImageView *singerPic;
@property(nonatomic,retain)MusicLabel *singerName;
@property(nonatomic,retain)MusicLabel *singerDetail;

@end



@implementation SearchSingerCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatSubView];
    }

    return self;
}
#pragma mark - 写到歌手自定义cell了!!!
-(void)creatSubView{
    
    self.singerPic = [[[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 60, 60)] autorelease];
    self.singerName = [[[MusicLabel alloc] initWithFrame:CGRectMake(self.singerPic.frame.origin.x + 80, self.singerPic.frame.origin.y + 15, 200, 20)] autorelease];
    self.singerDetail = [[[MusicLabel alloc] initWithFrame:CGRectMake(self.singerName.frame.origin.x, self.singerName.frame.origin.y + 23, self.frame.size.width - 100, self.singerName.frame.size.height)] autorelease];
    self.singerDetail.font = [UIFont systemFontOfSize:14];
    self.singerDetail.textColor = [UIColor whiteColor];
    //self.singerDetail.font = [UIFont fontWithName:@"Menlo-Bold" size:17];
    [self.contentView addSubview:self.singerPic];
    [self.contentView addSubview:self.singerName];
    [self.contentView addSubview:self.singerDetail];
     self.singerPic.layer.masksToBounds = YES;
    self.singerPic.layer.cornerRadius = 30;
    
    self.singerPic.contentMode = UIViewContentModeScaleToFill;
    self.backgroundColor = [UIColor colorWithRed:143.0/255 green:172.0/255 blue:193.0/255 alpha:1];
    

}

-(void)setModel:(SearchSingerModel *)model{

    [self.singerPic sd_setImageWithURL:[NSURL URLWithString:model.pic_url]placeholderImage:[UIImage imageNamed:@"smallZhanweitu"]];
    
    self.singerName.text = model.singer_name;
    NSString *str = [NSString stringWithFormat:@"%@首单曲 %@张专辑",model.song_num,model.album_num];
    self.singerDetail.text = str;
    


}

@end
