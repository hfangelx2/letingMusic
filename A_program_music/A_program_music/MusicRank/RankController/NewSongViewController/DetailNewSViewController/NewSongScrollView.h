//
//  NewSongScrollView.h
//  A_program_music
//
//  Created by dlios on 15/6/30.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "MusicScrollView.h"

@interface NewSongScrollView : MusicScrollView

- (void)setImages:(NSMutableArray *)names;
@property (nonatomic, retain) UIScrollView *scroll;
@property (nonatomic, assign)NSInteger page;
@property(nonatomic,retain)NSTimer *myTimer;
-(void)stopTimer;


//@property(nonatomic,retain)NSMutableArray *scrollArray;



@end
