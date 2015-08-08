//
//  SongListCell.m
//  A_program_music
//
//  Created by 姚天成 on 15/6/23.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "SongListCell.h"

@interface SongListCell()
@property(nonatomic,retain)MusicLabel *songName;
@property(nonatomic,retain)MusicLabel *singName;
@property(nonatomic,retain)MusicLabel *numberLabel;
@end


@implementation SongListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatSubView];
    }
    return self;

}
-(void)creatSubView{

    
    self.songName = [[[MusicLabel alloc] initWithFrame:CGRectMake(45 ,5,self.frame.size.width , self.frame.size.height/2)] autorelease];
    self.numberLabel = [[[MusicLabel alloc] initWithFrame:CGRectMake(self.songName.frame.origin.x - 40, self.songName.frame.origin.y, 35, self.songName.frame.size.height)] autorelease];
    self.numberLabel.textAlignment = NSTextAlignmentRight;
    self.numberLabel.font = [UIFont systemFontOfSize:15];
    self.singName = [[[MusicLabel alloc] initWithFrame:CGRectMake(self.songName.frame.origin.x, self.songName.frame.origin.y + 19, self.songName.frame.size.width, self.songName.frame.size.height)] autorelease];
    self.songName.font = [UIFont systemFontOfSize:15];
    self.singName.font = [UIFont systemFontOfSize:15];
//    self.singName.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.numberLabel];
    [self.contentView addSubview:self.songName];
    [self.contentView addSubview:self.singName];



}

-(void)setModel:(OneSongModel *)model{
    
    self.songName.text = model.song_name;
    self.singName.text = model.singer_name;
    
}

-(void)setNumber:(NSString *)number{
    self.numberLabel.text = number;
}


@end
