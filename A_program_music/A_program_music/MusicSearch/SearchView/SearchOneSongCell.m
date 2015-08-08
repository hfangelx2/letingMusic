//
//  SearchOneSongCell.m
//  A_program_music
//
//  Created by 姚天成 on 15/6/21.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "SearchOneSongCell.h"


@interface SearchOneSongCell()


@property(nonatomic,retain)MusicLabel *songName;
@property(nonatomic,retain)MusicLabel *singName;
@property(nonatomic,retain)MusicLabel *numberLabel;
@property(nonatomic,retain)UIImageView *loveView;
@property(nonatomic,assign)BOOL changeColor;
@end


@implementation SearchOneSongCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatSubView];
    }
    return self;


}
-(void)creatSubView{
    CGSize size = [UIScreen mainScreen].bounds.size;
    self.backgroundColor = [UIColor colorWithRed:143.0/255 green:172.0/255 blue:193.0/255 alpha:1];
    self.songName = [[[MusicLabel alloc] initWithFrame:CGRectMake(50*WIDTH, 5, size.width - 125*WIDTH, 20*HEIGHT)] autorelease];
    self.songName.textColor = [UIColor whiteColor];
    self.numberLabel = [[[MusicLabel alloc] initWithFrame:CGRectMake(10*WIDTH, 15*HEIGHT, size.width - 345*WIDTH, 15*HEIGHT)] autorelease];
    
    
    
    self.numberLabel.textColor = [UIColor whiteColor];
    self.singName = [[[MusicLabel alloc] initWithFrame:CGRectMake(50*WIDTH, 30*HEIGHT, size.width - 75*WIDTH, 20*HEIGHT)] autorelease];
    self.singName.textColor = [UIColor whiteColor];
    
    
    
    self.loveView = [[[UIImageView alloc] init] autorelease];
    
    self.loveView.frame = CGRectMake(self.contentView.frame.size.width*1.0*WIDTH, self.contentView.frame.size.height*0.10*HEIGHT, self.contentView.frame.size.width*0.15*WIDTH, self.contentView.frame.size.height*1.0*HEIGHT);
    [self.contentView addSubview:self.loveView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(collectionLove)];
    [self.loveView addGestureRecognizer:tap];
    self.loveView.userInteractionEnabled = YES;
    
    
    
    MusicView *view = [[[MusicView alloc] initWithFrame:CGRectMake(50*WIDTH, 57*HEIGHT, 375*WIDTH, 1)] autorelease];
    view.backgroundColor = [UIColor whiteColor];
    _isCollect = 0;
    [self.contentView addSubview:view];
    self.songName.font = [UIFont systemFontOfSize:15];
    self.singName.font = [UIFont systemFontOfSize:12];
    self.numberLabel.font = [UIFont systemFontOfSize:12.0];
    self.singName.textColor = [UIColor whiteColor];
    [self.contentView addSubview:self.numberLabel];
    [self.contentView addSubview:self.songName];
    [self.contentView addSubview:self.singName];
    
    

}
-(void)setModel:(OneSongModel *)model{
    if (_model != model) {
        [_model release];
        _model = [model retain];
    }
    self.songName.text = model.song_name;
    self.singName.text = model.singer_name;
    if (_isCollect == NO) {
        self.loveView.image = [UIImage imageNamed:@"love"];
    }else{
        self.loveView.image = [UIImage imageNamed:@"love2"];
    }
    

}

-(void)setNumber:(NSString *)number{
    self.numberLabel.text = number;
}

-(void)setAlbum:(AlbumModel *)album{

    self.songName.text = album.name;
    self.singName.text = album.singerName;
}

-(void)collectionLove{
    PlayModel *model = [[PlayModel alloc] init];
    model.song_name = _model.song_name;
    model.singer_name = _model.singer_name;
    model.audition_list = _model.audition_list;
    
    if (_isCollect == NO) {
        self.loveView.image = [UIImage imageNamed:@"love2"];
        [[CollectSQL shareSQL] insertSCMusicWithPlayModel:model];
        _isCollect = YES;
    }else if(_isCollect == YES){
        self.loveView.image = [UIImage imageNamed:@"love"];
        [[CollectSQL shareSQL] deleteSCMusicWithPlayModel:model];
        _isCollect = NO;
        
    }

}

@end
