


//
//  NewSongCollectionViewCell.m
//  A_program_music
//
//  Created by dlios on 15/6/24.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "NewSongCollectionViewCell.h"

@interface NewSongCollectionViewCell ()

@property(nonatomic,retain)UIImageView *imageview1;
@property(nonatomic,retain)MusicLabel *label1;

@end




@implementation NewSongCollectionViewCell


-(void)dealloc
{
    [_imageview1 release];
    [_label1 release];
    [_model release];
    [super dealloc];
}




-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createCellInfo];
    }

    return self;
}

-(void)createCellInfo
{
    
   
}












/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
