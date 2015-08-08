//
//  CollectSQL.m
//  A_program_music
//
//  Created by 姚天成 on 15/7/2.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "CollectSQL.h"
#import "FMDB.h"
#import "PlayModel.h"


@interface CollectSQL()
@property (nonatomic, retain) FMDatabaseQueue *queue;

@end


@implementation CollectSQL

+ (instancetype)shareSQL
{
    static CollectSQL *dataBase = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        dataBase = [[CollectSQL alloc] init];
    });
    return dataBase;
}
//4.打开数据库
-(instancetype)init{
    self = [super init];
    if (self) {
    NSString *file = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    file = [file stringByAppendingPathComponent:@"contact.sqlite"];
    self.queue = [FMDatabaseQueue databaseQueueWithPath:file];
    [self.queue inDatabase:^(FMDatabase *db) {
        BOOL result = [db executeUpdate:@"create table if not exists t_Collect (number INTEGER PRIMARY KEY AUTOINCREMENT, SongName TEXT, SingerName TEXT, pic_url TEXT, audition_list BLOB);"];
        if (result) {
            NSLog(@"创建收藏数据库成功");
        } else {
            NSLog(@"创建收藏数据库失败");
        }
        }];
    }
     return self;
}

- (void)insertSCMusicWithPlayModel:(PlayModel *)model
{
    
    //NSArray *songList = model.audition_list;
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model.audition_list];
    
    [self.queue inDatabase:^(FMDatabase *db) {

        BOOL result = [db executeUpdate:@"insert into t_Collect (SongName, SingerName, pic_url, audition_list) values (?, ?, ?, ?);", model.song_name, model.singer_name, model.pic_url, data];
        
        if (result) {
            NSLog(@"插入收藏成功");
        } else {
            NSLog(@"插入收藏失败");
        }
        
    }];
}

- (NSMutableArray *)selectAllSCPlayModel
{
    NSMutableArray *array = [NSMutableArray array];
    
    [self.queue inDatabase:^(FMDatabase *db) {
        
        FMResultSet *result = [db executeQuery:@"select * from t_Collect;"];
        
        while ([result next]) {
            
            
            NSString *SongName = [result stringForColumn:@"SongName"];
            NSString *SingerName = [result stringForColumn:@"SingerName"];
            NSString *pic_url = [result stringForColumn:@"pic_url"];

            NSData *data = [result dataForColumn:@"audition_list"];
            NSArray *audition_list = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            
            PlayModel *model = [[PlayModel alloc] init];
            model.song_name = SongName;
            model.singer_name = SingerName;
            model.pic_url = pic_url;
            model.audition_list = [NSMutableArray arrayWithArray:audition_list];
            
            [array addObject:model];
        }
    }];
    return array;
    
}

- (void)deleteAllSCPlayMusic
{
    [self.queue inDatabase:^(FMDatabase *db) {
        
     BOOL result = [db executeUpdate:@"delete from t_Collect"];
        if (result) {
            NSLog(@"删除收藏表成功");
        } else {
            NSLog(@"删除收藏表失败");
        }
        
    }];
}

-(void)deleteSCMusicWithPlayModel:(PlayModel *)model{
 
  
    [self.queue inDatabase:^(FMDatabase *db) {
       BOOL result = [db executeUpdate:@"DELETE FROM t_Collect WHERE SongName = ? AND SingerName = ?",model.song_name,model.singer_name];
//        [db executeUpdate:@"DELETE FROM User WHERE Name = ?",@"Jeffery"];
     
        if (result) {
            NSLog(@"删除%@成功",model.song_name);
        } else {
            NSLog(@"删除%@失败",model.song_name);
        }
        
    }];
}







@end
