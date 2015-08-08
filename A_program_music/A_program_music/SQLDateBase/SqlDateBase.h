//
//  SqlDateBase.h
//  A_program_music
//
//  Created by 姚天成 on 15/6/28.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "SingerModel.h"
#import "NewSongModel.h"
#import "FMDB.h"
#import "RankModel.h"
#import "StorgeModel.h"
#import "MusicVideoModel.h"
@interface SqlDateBase : NSObject

+ (instancetype)shareSQL;//初始化数据库
-(void)openDB;
-(void)createDiscoverHeader;
-(NSMutableArray *)selectAllDiscoverHeader;
-(void)insertDiscoverHeader:(DiscoverModel *)model;
-(void)dropDiscoverHeader;

-(void)createDiscoverNewSong;
-(void)insertDiscoverNewSong:(DiscoverModel *)model;
-(NSMutableArray *)selectAllDiscoverNewSong;
-(void)dropDiscoverNewSong;


-(void)createDiscoverSongList;
-(void)insertDiscoverSongList:(DiscoverModel *)model;
-(NSMutableArray *)selectAllDiscoverSongList;
-(void)dropDiscoverSongList;


-(void)createDiscoverOtherSong;
-(void)insertDiscoverOtherSong:(DiscoverModel *)model;
-(NSMutableArray *)selectAllDiscoverOtherSong;
-(void)dropDiscoverOtherSong;

-(void)createDiscoverTuiJian;
-(void)insertDiscoverTuiJian:(DiscoverModel *)model;
-(NSMutableArray *)selectAllDiscoverTuiJian;
-(void)dropDiscoverTuiJian;

-(void)createDiscoverSectionName;
-(void)insertDiscoverSectionName:(NSString *)name;
-(NSMutableArray *)selectAllDiscoverSectionName;
-(void)dropDiscoverSectionName;


-(void)createCollect;
-(void)insertCollect:(PlayModel *)model;
-(NSMutableArray *)selectCollect;
-(void)dropCollect;

//-------歌手页面-------
-(void)createSingerForm;
-(void)insertSingerForm:(SingerModel *)model;
-(NSMutableArray *)selectAllSingerForm;
-(void)dropsingerForm;

//--------新歌首发------------
-(void)createNewSongForm;
-(void)insertNewSongForm:(NewSongModel *)model;
-(NSMutableArray *)selectAllNewSongForm;
-(void)dropNewSongForm;

-(void)createNewSongForm1;
-(void)insertNewSongForm1:(NewSongModel *)model;
-(NSMutableArray *)selectAllNewSongForm1;
-(void)dropNewSongForm1;

//---------排行界面--------------
@property (nonatomic, retain) FMDatabaseQueue *queue;




//----------乐库界面-----------
-(void)createTableMusicStorge;
-(void)insertMusicStorge :(StorgeModel *)model;
-(void)dropTableMusicStorge;
-(NSMutableArray *)selectAllMusicStorge;

//-----------MV界面-------------
-(void)createTableMusicVideo;
-(void)insertMusicVideo :(MusicVideoModel *)model;
-(NSMutableArray *)selectAllMusicVideo;
-(void)dropTableMusicVideo;

-(void)createSearchTable;
-(void)insertSearch:(NSString *)str;
-(NSMutableArray *)selectAllSearch;
-(void)dropSearchTable;

@end
