//
//  SqlDateBase.m
//  A_program_music
//
//  Created by 姚天成 on 15/6/28.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "SqlDateBase.h"
#import "DiscoverModel.h"
#import "PlayModel.h"

@implementation SqlDateBase
//初始化数据库
+ (instancetype)shareSQL
{
    static SqlDateBase *dataBase = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        dataBase = [[SqlDateBase alloc] init];
    });
    return dataBase;
}

//1.导入数据库类库 libsqlite3.0.dylib
//2.创建单例类
//3.引入头文件  创建数据库对象music
static sqlite3 *music = nil;

//4.打开数据库
-(void)openDB{
    
    if (music != nil) {
        return;//如果数据库对象存在则不往下执行
    }
    //创建数据库文件路径
    NSArray *array =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [array lastObject];
    NSString *sqlitePath = [filePath stringByAppendingPathComponent:@"dataBase.sqlite"];
    NSLog(@"%@",sqlitePath);
    //打开数据库函数 将数据库对象数据库文件关联,并打开数据库
    //参数1 . 创建数据库路径
    //参数2 . 数据库对象,但由于内部为**对象,所以需要加取地址符 &
    int result = sqlite3_open(sqlitePath.UTF8String, &music);
    if (result == SQLITE_OK) {
        NSLog(@"打开数据库成功");
    }else{
        NSLog(@"打开失败");
    }
}

#pragma mark - 轮播图数据库
-(void)createDiscoverHeader{
    
    //写建表的sql语句(TEXT 代表字符串类型  INTEGER 代表NSInteger类型)(lanou08表名, number是默认字段 name,gender,age 为自建字段)
    NSString *sql = @"CREATE TABLE IF NOT EXISTS discoverHeader (number INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, pic_url TEXT, value TEXT, desc TEXT, author TEXT, listen_count TEXT, Listid TEXT)";
    //执行数据库语句
    int result = sqlite3_exec(music, sql.UTF8String, NULL, NULL, NULL);
    if (result == SQLITE_OK) {
        NSLog(@"创建发现轮播图成功");
    }else{
        NSLog(@"创建发现轮播图失败");
    }
    
}

//插入数据
-(void)insertDiscoverHeader:(DiscoverModel *)model{
    
    //SQL语句 number是主键:自动递增
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO discoverHeader (name, pic_url, value, desc, author, listen_count, Listid) VALUES('%@', '%@', '%@', '%@', '%@', '%@', '%@')",model.name,model.pic_url,model.value,model.desc,model.author,model.listen_count,model.Listid];
    
    int result = sqlite3_exec(music, sql.UTF8String, NULL, NULL, NULL);
    if (result == SQLITE_OK) {
        NSLog(@"插入发现表轮播图数据成功");
    }else{
        NSLog(@"插入发现表轮播图数据失败");
    }
}


//查询所有
-(NSMutableArray *)selectAllDiscoverHeader{
    
    NSString *sql = @"SELECT * FROM discoverHeader";
    //创建数据库跟随指针对象
    sqlite3_stmt *stmt = nil;
    //查询准备操作
    //参数3 . -1代表不限制sql语句长度
    //主要作用是将数据库对象db,sql语句,数据库跟随指针关联到一起,方便数据库查询操作.
    //参数4. & 数据库跟随指针对象
    //参数5. nil
    
    
    int result = sqlite3_prepare_v2(music, sql.UTF8String, -1, &stmt, nil);
    
    NSMutableArray *array = [NSMutableArray array];
    
    if (result == SQLITE_OK) {
        NSLog(@"查询发现表轮播图准备成功");
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            //取出表里每行中每个字段的数据
            const unsigned char *name =  sqlite3_column_text(stmt, 1);
            const unsigned char *pic_url = sqlite3_column_text(stmt, 2);
            const unsigned char *value =  sqlite3_column_text(stmt, 3);
            const unsigned char *desc = sqlite3_column_text(stmt, 4);
            const unsigned char *author =  sqlite3_column_text(stmt, 5);
            const unsigned char *listen_count = sqlite3_column_text(stmt, 6);
            const unsigned char *Listid = sqlite3_column_text(stmt, 7);
            
            //取出来数据放在model中
            DiscoverModel *model = [[DiscoverModel alloc] init];
            model.name = [NSString stringWithUTF8String:(const char *)name];
            model.pic_url = [NSString stringWithUTF8String:(const char *)pic_url];
            model.value = [NSString stringWithUTF8String:(const char *)value];
            model.desc = [NSString stringWithUTF8String:(const char *)desc];
            model.author = [NSString stringWithUTF8String:(const char *)author];
            model.listen_count = [NSString stringWithUTF8String:(const char *)listen_count];
            model.Listid = [NSString stringWithUTF8String:(const char *)Listid];
            
            
            //放进数组
            [array addObject:model];
        }
        
        
        return array;
        
        
    }else{
        NSLog(@"准备失败");
    }
    
    //释放stmt,清除内存
    sqlite3_finalize(stmt);
    return nil;
}

-(void)dropDiscoverHeader{
    NSString *sql = @"DROP TABLE discoverHeader";
    int result = sqlite3_exec(music, sql.UTF8String, NULL, NULL, nil);
    if (result == SQLITE_OK) {
        NSLog(@"删除发现表轮播图成功");
    }else{
        NSLog(@"删除发现表轮播图失败");
    }
    
    
}



#pragma mark - 新歌快递
-(void)createDiscoverNewSong{
    
    //写建表的sql语句(TEXT 代表字符串类型  INTEGER 代表NSInteger类型)(lanou08表名, number是默认字段 name,gender,age 为自建字段)
    NSString *sql = @"CREATE TABLE IF NOT EXISTS DiscoverNewSong (number INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, pic_url TEXT, value TEXT, desc TEXT, author TEXT, listen_count TEXT, Listid TEXT)";
    //执行数据库语句
    int result = sqlite3_exec(music, sql.UTF8String, NULL, NULL, NULL);
    if (result == SQLITE_OK) {
        NSLog(@"创建发现新歌快递表成功");
    }else{
        NSLog(@"创建发现新歌快递表失败");
    }
    
}

//插入数据
-(void)insertDiscoverNewSong:(DiscoverModel *)model{
    
    //SQL语句 number是主键:自动递增
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO DiscoverNewSong (name, pic_url, value, desc, author, listen_count, Listid) VALUES('%@', '%@', '%@', '%@', '%@', '%@', '%@')",model.name,model.pic_url,model.value,model.desc,model.author,model.listen_count,model.Listid];
    
    int result = sqlite3_exec(music, sql.UTF8String, NULL, NULL, NULL);
    if (result == SQLITE_OK) {
        NSLog(@"插入发现表新歌快递数据成功");
    }else{
        NSLog(@"插入发现表新歌快递数据失败");
    }
}


//查询所有
-(NSMutableArray *)selectAllDiscoverNewSong{
    
    NSString *sql = @"SELECT * FROM DiscoverNewSong";
    //创建数据库跟随指针对象
    sqlite3_stmt *stmt = nil;
    //查询准备操作
    //参数3 . -1代表不限制sql语句长度
    //主要作用是将数据库对象db,sql语句,数据库跟随指针关联到一起,方便数据库查询操作.
    //参数4. & 数据库跟随指针对象
    //参数5. nil
    
    
    int result = sqlite3_prepare_v2(music, sql.UTF8String, -1, &stmt, nil);
    
    NSMutableArray *array = [NSMutableArray array];
    
    if (result == SQLITE_OK) {
        NSLog(@"查询发现表新歌快递准备成功");
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            //取出表里每行中每个字段的数据
            const unsigned char *name =  sqlite3_column_text(stmt, 1);
            const unsigned char *pic_url = sqlite3_column_text(stmt, 2);
            const unsigned char *value =  sqlite3_column_text(stmt, 3);
            const unsigned char *desc = sqlite3_column_text(stmt, 4);
            const unsigned char *author =  sqlite3_column_text(stmt, 5);
            const unsigned char *listen_count = sqlite3_column_text(stmt, 6);
            const unsigned char *Listid = sqlite3_column_text(stmt, 7);
            
            //取出来数据放在model中
            DiscoverModel *model = [[DiscoverModel alloc] init];
            model.name = [NSString stringWithUTF8String:(const char *)name];
            model.pic_url = [NSString stringWithUTF8String:(const char *)pic_url];
            model.value = [NSString stringWithUTF8String:(const char *)value];
            model.desc = [NSString stringWithUTF8String:(const char *)desc];
            model.author = [NSString stringWithUTF8String:(const char *)author];
            model.listen_count = [NSString stringWithUTF8String:(const char *)listen_count];
            model.Listid = [NSString stringWithUTF8String:(const char *)Listid];
            
            
            //放进数组
            [array addObject:model];
        }
        
        
        return array;
        
        
    }else{
        NSLog(@"准备失败");
    }
    
    //释放stmt,清除内存
    sqlite3_finalize(stmt);
    return nil;
    
}

-(void)dropDiscoverNewSong{
    NSString *sql = @"DROP TABLE DiscoverNewSong";
    int result = sqlite3_exec(music, sql.UTF8String, NULL, NULL, nil);
    if (result == SQLITE_OK) {
        NSLog(@"删除发现表新歌快递成功");
    }else{
        NSLog(@"删除发现表新歌快递失败");
    }
    
    
}


#pragma mark - 歌单
-(void)createDiscoverSongList{
    
    //写建表的sql语句(TEXT 代表字符串类型  INTEGER 代表NSInteger类型)(lanou08表名, number是默认字段 name,gender,age 为自建字段)
    NSString *sql = @"CREATE TABLE IF NOT EXISTS DiscoverSongList (number INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, pic_url TEXT, value TEXT, desc TEXT, author TEXT, listen_count TEXT, Listid TEXT)";
    //执行数据库语句
    int result = sqlite3_exec(music, sql.UTF8String, NULL, NULL, NULL);
    if (result == SQLITE_OK) {
        NSLog(@"创建发现歌单表成功");
    }else{
        NSLog(@"创建发现歌单表失败");
    }
    
}

//插入数据
-(void)insertDiscoverSongList:(DiscoverModel *)model{
    
    //SQL语句 number是主键:自动递增
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO DiscoverSongList (name, pic_url, value, desc, author, listen_count, Listid) VALUES('%@', '%@', '%@', '%@', '%@', '%@', '%@')",model.name,model.pic_url,model.value,model.desc,model.author,model.listen_count,model.Listid];
    
    int result = sqlite3_exec(music, sql.UTF8String, NULL, NULL, NULL);
    if (result == SQLITE_OK) {
        NSLog(@"插入发现表歌单数据成功");
    }else{
        NSLog(@"插入发现表歌单数据失败");
    }
}


//查询所有
-(NSMutableArray *)selectAllDiscoverSongList{
    
    NSString *sql = @"SELECT * FROM DiscoverSongList";
    //创建数据库跟随指针对象
    sqlite3_stmt *stmt = nil;
    //查询准备操作
    //参数3 . -1代表不限制sql语句长度
    //主要作用是将数据库对象db,sql语句,数据库跟随指针关联到一起,方便数据库查询操作.
    //参数4. & 数据库跟随指针对象
    //参数5. nil
    
    
    int result = sqlite3_prepare_v2(music, sql.UTF8String, -1, &stmt, nil);
    
    NSMutableArray *array = [NSMutableArray array];
    
    if (result == SQLITE_OK) {
        NSLog(@"查询发现表歌单准备成功");
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            //取出表里每行中每个字段的数据
            const unsigned char *name =  sqlite3_column_text(stmt, 1);
            const unsigned char *pic_url = sqlite3_column_text(stmt, 2);
            const unsigned char *value =  sqlite3_column_text(stmt, 3);
            const unsigned char *desc = sqlite3_column_text(stmt, 4);
            const unsigned char *author =  sqlite3_column_text(stmt, 5);
            const unsigned char *listen_count = sqlite3_column_text(stmt, 6);
            const unsigned char *Listid = sqlite3_column_text(stmt, 7);
            
            //取出来数据放在model中
            DiscoverModel *model = [[DiscoverModel alloc] init];
            model.name = [NSString stringWithUTF8String:(const char *)name];
            model.pic_url = [NSString stringWithUTF8String:(const char *)pic_url];
            model.value = [NSString stringWithUTF8String:(const char *)value];
            model.desc = [NSString stringWithUTF8String:(const char *)desc];
            model.author = [NSString stringWithUTF8String:(const char *)author];
            model.listen_count = [NSString stringWithUTF8String:(const char *)listen_count];
            model.Listid = [NSString stringWithUTF8String:(const char *)Listid];
            
            
            //放进数组
            [array addObject:model];
        }
        
        
        return array;
        
        
    }else{
        NSLog(@"准备失败");
    }
    
    //释放stmt,清除内存
    sqlite3_finalize(stmt);
    return nil;
    
}

-(void)dropDiscoverSongList{
    NSString *sql = @"DROP TABLE DiscoverSongList";
    int result = sqlite3_exec(music, sql.UTF8String, NULL, NULL, nil);
    if (result == SQLITE_OK) {
        NSLog(@"删除发现表歌单成功");
    }else{
        NSLog(@"删除发现表歌单失败");
    }
    
    
}

#pragma mark - 其他歌单
-(void)createDiscoverOtherSong{
    
    //写建表的sql语句(TEXT 代表字符串类型  INTEGER 代表NSInteger类型)(lanou08表名, number是默认字段 name,gender,age 为自建字段)
    NSString *sql = @"CREATE TABLE IF NOT EXISTS DiscoverOtherSong (number INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, pic_url TEXT, value TEXT, desc TEXT, author TEXT, listen_count TEXT, Listid TEXT)";
    //执行数据库语句
    int result = sqlite3_exec(music, sql.UTF8String, NULL, NULL, NULL);
    if (result == SQLITE_OK) {
        NSLog(@"创建发现其他歌单表成功");
    }else{
        NSLog(@"创建发现其他歌单表失败");
    }
    
}

//插入数据
-(void)insertDiscoverOtherSong:(DiscoverModel *)model{
    
    //SQL语句 number是主键:自动递增
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO DiscoverOtherSong (name, pic_url, value, desc, author, listen_count, Listid) VALUES('%@', '%@', '%@', '%@', '%@', '%@', '%@')",model.name,model.pic_url,model.value,model.desc,model.author,model.listen_count,model.Listid];
    
    int result = sqlite3_exec(music, sql.UTF8String, NULL, NULL, NULL);
    if (result == SQLITE_OK) {
        NSLog(@"插入发现表其他歌单数据成功");
    }else{
        NSLog(@"插入发现表其他歌单数据失败");
    }
}


//查询所有
-(NSMutableArray *)selectAllDiscoverOtherSong{
    
    NSString *sql = @"SELECT * FROM DiscoverOtherSong";
    //创建数据库跟随指针对象
    sqlite3_stmt *stmt = nil;
    //查询准备操作
    //参数3 . -1代表不限制sql语句长度
    //主要作用是将数据库对象db,sql语句,数据库跟随指针关联到一起,方便数据库查询操作.
    //参数4. & 数据库跟随指针对象
    //参数5. nil
    
    
    int result = sqlite3_prepare_v2(music, sql.UTF8String, -1, &stmt, nil);
    
    NSMutableArray *array = [NSMutableArray array];
    
    if (result == SQLITE_OK) {
        NSLog(@"查询发现表其他歌单准备成功");
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            //取出表里每行中每个字段的数据
            const unsigned char *name =  sqlite3_column_text(stmt, 1);
            const unsigned char *pic_url = sqlite3_column_text(stmt, 2);
            const unsigned char *value =  sqlite3_column_text(stmt, 3);
            const unsigned char *desc = sqlite3_column_text(stmt, 4);
            const unsigned char *author =  sqlite3_column_text(stmt, 5);
            const unsigned char *listen_count = sqlite3_column_text(stmt, 6);
            const unsigned char *Listid = sqlite3_column_text(stmt, 7);
            
            //取出来数据放在model中
            DiscoverModel *model = [[DiscoverModel alloc] init];
            model.name = [NSString stringWithUTF8String:(const char *)name];
            model.pic_url = [NSString stringWithUTF8String:(const char *)pic_url];
            model.value = [NSString stringWithUTF8String:(const char *)value];
            model.desc = [NSString stringWithUTF8String:(const char *)desc];
            model.author = [NSString stringWithUTF8String:(const char *)author];
            model.listen_count = [NSString stringWithUTF8String:(const char *)listen_count];
            model.Listid = [NSString stringWithUTF8String:(const char *)Listid];
            
            
            //放进数组
            [array addObject:model];
        }
        
        
        return array;
        
        
    }else{
        NSLog(@"准备失败");
    }
    
    //释放stmt,清除内存
    sqlite3_finalize(stmt);
    return nil;
    
}

-(void)dropDiscoverOtherSong{
    NSString *sql = @"DROP TABLE DiscoverOtherSong";
    int result = sqlite3_exec(music, sql.UTF8String, NULL, NULL, nil);
    if (result == SQLITE_OK) {
        NSLog(@"删除发现表其他歌单成功");
    }else{
        NSLog(@"删除发现表其他歌单失败");
    }
    
    
}


#pragma mark - 推荐歌单
-(void)createDiscoverTuiJian{
    
    //写建表的sql语句(TEXT 代表字符串类型  INTEGER 代表NSInteger类型)(lanou08表名, number是默认字段 name,gender,age 为自建字段)
    NSString *sql = @"CREATE TABLE IF NOT EXISTS DiscoverTuiJian (number INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, pic_url TEXT, value TEXT, desc TEXT, author TEXT, listen_count TEXT, Listid TEXT)";
    //执行数据库语句
    int result = sqlite3_exec(music, sql.UTF8String, NULL, NULL, NULL);
    if (result == SQLITE_OK) {
        NSLog(@"创建发现推荐歌单表成功");
    }else{
        NSLog(@"创建发现推荐歌单表失败");
    }
    
}

//插入数据
-(void)insertDiscoverTuiJian:(DiscoverModel *)model{
    
    //SQL语句 number是主键:自动递增
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO DiscoverTuiJian (name, pic_url, value, desc, author, listen_count, Listid) VALUES('%@', '%@', '%@', '%@', '%@', '%@', '%@')",model.name,model.pic_url,model.value,model.desc,model.author,model.listen_count,model.Listid];
    
    int result = sqlite3_exec(music, sql.UTF8String, NULL, NULL, NULL);
    if (result == SQLITE_OK) {
        NSLog(@"插入发现表推荐歌单数据成功");
    }else{
        NSLog(@"插入发现表推荐歌单数据失败");
    }
}


//查询所有
-(NSMutableArray *)selectAllDiscoverTuiJian{
    
    NSString *sql = @"SELECT * FROM DiscoverTuiJian";
    //创建数据库跟随指针对象
    sqlite3_stmt *stmt = nil;
    //查询准备操作
    //参数3 . -1代表不限制sql语句长度
    //主要作用是将数据库对象db,sql语句,数据库跟随指针关联到一起,方便数据库查询操作.
    //参数4. & 数据库跟随指针对象
    //参数5. nil
    
    
    int result = sqlite3_prepare_v2(music, sql.UTF8String, -1, &stmt, nil);
    
    NSMutableArray *array = [NSMutableArray array];
    
    if (result == SQLITE_OK) {
        NSLog(@"查询发现表推荐歌单准备成功");
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            //取出表里每行中每个字段的数据
            const unsigned char *name =  sqlite3_column_text(stmt, 1);
            const unsigned char *pic_url = sqlite3_column_text(stmt, 2);
            const unsigned char *value =  sqlite3_column_text(stmt, 3);
            const unsigned char *desc = sqlite3_column_text(stmt, 4);
            const unsigned char *author =  sqlite3_column_text(stmt, 5);
            const unsigned char *listen_count = sqlite3_column_text(stmt, 6);
            const unsigned char *Listid = sqlite3_column_text(stmt, 7);
            
            //取出来数据放在model中
            DiscoverModel *model = [[DiscoverModel alloc] init];
            model.name = [NSString stringWithUTF8String:(const char *)name];
            model.pic_url = [NSString stringWithUTF8String:(const char *)pic_url];
            model.value = [NSString stringWithUTF8String:(const char *)value];
            model.desc = [NSString stringWithUTF8String:(const char *)desc];
            model.author = [NSString stringWithUTF8String:(const char *)author];
            model.listen_count = [NSString stringWithUTF8String:(const char *)listen_count];
            model.Listid = [NSString stringWithUTF8String:(const char *)Listid];
            
            
            //放进数组
            [array addObject:model];
        }
        
        
        return array;
        
        
    }else{
        NSLog(@"准备失败");
    }
    
    //释放stmt,清除内存
    sqlite3_finalize(stmt);
    return nil;
    
}

-(void)dropDiscoverTuiJian{
    NSString *sql = @"DROP TABLE DiscoverTuiJian";
    int result = sqlite3_exec(music, sql.UTF8String, NULL, NULL, nil);
    if (result == SQLITE_OK) {
        NSLog(@"删除发现表推荐歌单成功");
    }else{
        NSLog(@"删除发现表推荐歌单失败");
    }
    
    
}

#pragma mark - sectionName
-(void)createDiscoverSectionName{
    
    //写建表的sql语句(TEXT 代表字符串类型  INTEGER 代表NSInteger类型)(lanou08表名, number是默认字段 name,gender,age 为自建字段)
    NSString *sql = @"CREATE TABLE IF NOT EXISTS DiscoverSectionName (number INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT)";
    //执行数据库语句
    int result = sqlite3_exec(music, sql.UTF8String, NULL, NULL, NULL);
    if (result == SQLITE_OK) {
        NSLog(@"创建发现section标题表成功");
    }else{
        NSLog(@"创建发现section标题表失败");
    }
    
}

//插入数据
-(void)insertDiscoverSectionName:(NSString *)name{
    
    //SQL语句 number是主键:自动递增
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO DiscoverSectionName ( name) VALUES('%@')",name];
    
    int result = sqlite3_exec(music, sql.UTF8String, NULL, NULL, NULL);
    if (result == SQLITE_OK) {
        NSLog(@"插入发现表===数据成功");
    }else{
        NSLog(@"插入发现表===数据失败");
    }
}


//查询所有
-(NSMutableArray *)selectAllDiscoverSectionName{
    
    NSString *sql = @"SELECT * FROM DiscoverSectionName";
    //创建数据库跟随指针对象
    sqlite3_stmt *stmt = nil;
    //查询准备操作
    //参数3 . -1代表不限制sql语句长度
    //主要作用是将数据库对象db,sql语句,数据库跟随指针关联到一起,方便数据库查询操作.
    //参数4. & 数据库跟随指针对象
    //参数5. nil
    
    
    int result = sqlite3_prepare_v2(music, sql.UTF8String, -1, &stmt, nil);
    
    NSMutableArray *array = [NSMutableArray array];
    
    if (result == SQLITE_OK) {
        NSLog(@"查询发现表section标题准备成功");
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            //取出表里每行中每个字段的数据
            const unsigned char *name =  sqlite3_column_text(stmt, 1);
            
            
            //取出来数据放在model中
            
            NSString *name1 = [NSString stringWithUTF8String:(const char *)name];
            
            
            //放进数组
            [array addObject:name1];
        }
        
        
        return array;
        
        
    }else{
        NSLog(@"准备失败");
    }
    
    //释放stmt,清除内存
    sqlite3_finalize(stmt);
    return nil;
    
}

-(void)dropDiscoverSectionName{
    NSString *sql = @"DROP TABLE DiscoverSectionName";
    int result = sqlite3_exec(music, sql.UTF8String, NULL, NULL, nil);
    if (result == SQLITE_OK) {
        NSLog(@"删除发现表section标题成功");
    }else{
        NSLog(@"删除发现表section标题失败");
    }
    
    
}


#pragma mark - 收藏
-(void)createCollect{
    NSString *sql = @"CREATE TABLE IF NOT EXISTS Collect (number INTEGER PRIMARY KEY AUTOINCREMENT, singer_name TEXT, pic_url TEXT, song_name TEXT, audition_list blob not null)";
    //执行数据库语句
    int result = sqlite3_exec(music, sql.UTF8String, NULL, NULL, NULL);
    if (result == SQLITE_OK) {
        NSLog(@"创建收藏表成功");
    }else{
        NSLog(@"创建收藏表失败");
    }
    
}

//插入数据
-(void)insertCollect:(PlayModel *)model{
    
    //SQL语句 number是主键:自动递增
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model.audition_list];
    NSLog(@"%@",data);
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO Collect (singer_name, pic_url, song_name, audition_list) VALUES('%@', '%@', '%@', '%@')",model.singer_name,model.pic_url,model.song_name,data];
    //[music executeUpdate: @"insert into Collect ( audition_list) values (?);",data];
    int result = sqlite3_exec(music, sql.UTF8String, NULL, NULL, NULL);
    if (result == SQLITE_OK) {
        NSLog(@"插入收藏数据成功");
    }else{
        NSLog(@"插入收藏数据失败");
    }
}


//查询所有
-(NSMutableArray *)selectCollect{
    
    NSString *sql = @"SELECT * FROM Collect";
    //创建数据库跟随指针对象
    sqlite3_stmt *stmt = nil;
    //查询准备操作
    //参数3 . -1代表不限制sql语句长度
    //主要作用是将数据库对象db,sql语句,数据库跟随指针关联到一起,方便数据库查询操作.
    //参数4. & 数据库跟随指针对象
    //参数5. nil
    
    
    int result = sqlite3_prepare_v2(music, sql.UTF8String, -1, &stmt, nil);
    
    NSMutableArray *array = [NSMutableArray array];
    
    
    if (result == SQLITE_OK) {
        NSLog(@"查询收藏准备成功");
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            //取出表里每行中每个字段的数据
            const unsigned char *singer_name =  sqlite3_column_text(stmt, 1);
            const unsigned char *pic_url = sqlite3_column_text(stmt, 2);
            const unsigned char *song_name =  sqlite3_column_text(stmt, 3);
            NSData *audition_list = sqlite3_column_blob(stmt, 4);
            
            //取出来数据放在model中
            PlayModel *model = [[PlayModel alloc] init];
            model.singer_name = [NSString stringWithUTF8String:(const char *)singer_name];
            model.pic_url = [NSString stringWithUTF8String:(const char *)pic_url];
            model.song_name = [NSString stringWithUTF8String:(const char *)song_name];
            //model.audition_list = [music executeUpdate: @"insert into In_Editor ( picUrls) values (?);",audition_list];
            NSArray *imageArr = [NSKeyedUnarchiver unarchiveObjectWithData:audition_list];
            model.audition_list = [NSMutableArray arrayWithArray:imageArr];
            //放进数组
            [array addObject:model];
        }
        
        
        return array;
        
        
    }else{
        NSLog(@"准备失败");
    }
    
    //释放stmt,清除内存
    sqlite3_finalize(stmt);
    return nil;
    
}

-(void)dropCollect{
    NSString *sql = @"DROP TABLE Collect";
    int result = sqlite3_exec(music, sql.UTF8String, NULL, NULL, nil);
    if (result == SQLITE_OK) {
        NSLog(@"删除发现表推荐歌单成功");
    }else{
        NSLog(@"删除发现表推荐歌单失败");
    }
    
    
}









//
////修改
//-(void)updateDiscover:(DiscoverModel *)model name:(NSString *)name{
//
//    NSString *sql = [NSString stringWithFormat:@"UPDATE discover SET name = '%@', gender = '%@', age = '%ld' WHERE name = '%@'",stu.name,stu.gender,stu.age,name];
//    int result = sqlite3_exec(db, sql.UTF8String, NULL, NULL, NULL);
//    if (result == SQLITE_OK) {
//        NSLog(@"修改成功");
//    }else{
//        NSLog(@"修改失败");
//    }
//
//}

//删除
//-(void)deleteTable:(NSString *)name{
//
//    NSString *sql = [NSString stringWithFormat:@"DELETE FROM lanou08 WHERE name = '%@'",name];
//    int result = sqlite3_exec(db, sql.UTF8String, NULL, NULL, NULL);
//    if (result == SQLITE_OK) {
//        NSLog(@"删除成功");
//    }else{
//        NSLog(@"删除失败");
//    }
//
//
//}


#pragma 歌手页面缓存
//-----------------------------------------------------------------------------
-(void)createSingerForm{
    
    //写建表的sql语句(TEXT 代表字符串类型  INTEGER 代表NSInteger类型)(lanou08表名, number是默认字段 name,gender,age 为自建字段)
    NSString *sql = @"CREATE TABLE IF NOT EXISTS singerForm (number INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, pic_url TEXT)";
    //执行数据库语句
    int result = sqlite3_exec(music, sql.UTF8String, NULL, NULL, NULL);
    if (result == SQLITE_OK) {
//        NSLog(@"创建歌手表成功");
    }else{
//        NSLog(@"创建歌手表失败");
    }
    
}

//插入数据
-(void)insertSingerForm:(SingerModel *)model{
    
    //SQL语句 number是主键:自动递增
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO singerForm (title, pic_url) VALUES('%@', '%@')",model.title,model.pic_url];
    
    int result = sqlite3_exec(music, sql.UTF8String, NULL, NULL, NULL);
    if (result == SQLITE_OK) {
//        NSLog(@"插入歌手成功");
    }else{
//        NSLog(@"插入歌手失败");
    }
}


//查询所有
-(NSMutableArray *)selectAllSingerForm{
    
    NSString *sql = @"SELECT * FROM singerForm";
    //创建数据库跟随指针对象
    sqlite3_stmt *stmt = nil;
    //查询准备操作
    //参数3 . -1代表不限制sql语句长度
    //主要作用是将数据库对象db,sql语句,数据库跟随指针关联到一起,方便数据库查询操作.
    //参数4. & 数据库跟随指针对象
    //参数5. nil
    
    
    int result = sqlite3_prepare_v2(music, sql.UTF8String, -1, &stmt, nil);
    
    NSMutableArray *array = [NSMutableArray array];
    
    if (result == SQLITE_OK) {
//        NSLog(@"查询歌手成功");
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            //取出表里每行中每个字段的数据
            const unsigned char *title =  sqlite3_column_text(stmt, 1);
            const unsigned char *pic_url = sqlite3_column_text(stmt, 2);
            
            //取出来数据放在model中
            SingerModel *model = [[SingerModel alloc] init];
            model.title = [NSString stringWithUTF8String:(const char *)title];
            model.pic_url = [NSString stringWithUTF8String:(const char *)pic_url];
           
            
            //放进数组
            [array addObject:model];
        }
        
        
        return array;
        
        
    }else{
//        NSLog(@"准备失败");
    }
    
    //释放stmt,清除内存
    sqlite3_finalize(stmt);
    return nil;
}

-(void)dropsingerForm{
    NSString *sql = @"DROP TABLE singerForm";
    int result = sqlite3_exec(music, sql.UTF8String, NULL, NULL, nil);
    if (result == SQLITE_OK) {
//        NSLog(@"删除歌手成功");
    }else{
//        NSLog(@"删除歌手失败");
    }
    
    
}


#pragma 创建新歌首发表格

-(void)createNewSongForm{
    
    //写建表的sql语句(TEXT 代表字符串类型  INTEGER 代表NSInteger类型)(lanou08表名, number是默认字段 name,gender,age 为自建字段)
    NSString *sql = @"CREATE TABLE IF NOT EXISTS newSongForm (number INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, pic TEXT)";
    //执行数据库语句
    int result = sqlite3_exec(music, sql.UTF8String, NULL, NULL, NULL);
    if (result == SQLITE_OK) {
        //        NSLog(@"创建歌手表成功");
    }else{
        //        NSLog(@"创建歌手表失败");
    }
    
}

//插入数据
-(void)insertNewSongForm:(NewSongModel *)model{
    
    //SQL语句 number是主键:自动递增
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO newSongForm (title, pic) VALUES('%@', '%@')",model.title,model.pic];
    
    int result = sqlite3_exec(music, sql.UTF8String, NULL, NULL, NULL);
    if (result == SQLITE_OK) {
        //        NSLog(@"插入歌手成功");
    }else{
        //        NSLog(@"插入歌手失败");
    }
}


//查询所有
-(NSMutableArray *)selectAllNewSongForm{
    
    NSString *sql = @"SELECT * FROM newSongForm";
    //创建数据库跟随指针对象
    sqlite3_stmt *stmt = nil;
    //查询准备操作
    //参数3 . -1代表不限制sql语句长度
    //主要作用是将数据库对象db,sql语句,数据库跟随指针关联到一起,方便数据库查询操作.
    //参数4. & 数据库跟随指针对象
    //参数5. nil
    
    
    int result = sqlite3_prepare_v2(music, sql.UTF8String, -1, &stmt, nil);
    
    NSMutableArray *array = [NSMutableArray array];
    
    if (result == SQLITE_OK) {
        //        NSLog(@"查询歌手成功");
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            //取出表里每行中每个字段的数据
            const unsigned char *title =  sqlite3_column_text(stmt, 1);
            const unsigned char *pic = sqlite3_column_text(stmt, 2);
            
            //取出来数据放在model中
            NewSongModel *model = [[NewSongModel alloc] init];
            model.title = [NSString stringWithUTF8String:(const char *)title];
            model.pic = [NSString stringWithUTF8String:(const char *)pic];
            
            
            //放进数组
            [array addObject:model];
        }
        
        
        return array;
        
        
    }else{
        //        NSLog(@"准备失败");
    }
    
    //释放stmt,清除内存
    sqlite3_finalize(stmt);
    return nil;
}

-(void)dropNewSongForm{
    NSString *sql = @"DROP TABLE newSongForm";
    int result = sqlite3_exec(music, sql.UTF8String, NULL, NULL, nil);
    if (result == SQLITE_OK) {
        //        NSLog(@"删除歌手成功");
    }else{
        //        NSLog(@"删除歌手失败");
    }
    
    
}
//--------------------2---------------------

-(void)createNewSongForm1{
    
    //写建表的sql语句(TEXT 代表字符串类型  INTEGER 代表NSInteger类型)(lanou08表名, number是默认字段 name,gender,age 为自建字段)
    NSString *sql = @"CREATE TABLE IF NOT EXISTS newSongForm1 (number INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, pic TEXT)";
    //执行数据库语句
    int result = sqlite3_exec(music, sql.UTF8String, NULL, NULL, NULL);
    if (result == SQLITE_OK) {
        //        NSLog(@"创建歌手表成功");
    }else{
        //        NSLog(@"创建歌手表失败");
    }
    
}

//插入数据
-(void)insertNewSongForm1:(NewSongModel *)model{
    
    //SQL语句 number是主键:自动递增
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO newSongForm1 (title, pic) VALUES('%@', '%@')",model.title,model.pic];
    
    int result = sqlite3_exec(music, sql.UTF8String, NULL, NULL, NULL);
    if (result == SQLITE_OK) {
        //        NSLog(@"插入歌手成功");
    }else{
        //        NSLog(@"插入歌手失败");
    }
}


//查询所有
-(NSMutableArray *)selectAllNewSongForm1{
    
    NSString *sql = @"SELECT * FROM newSongForm1";
    //创建数据库跟随指针对象
    sqlite3_stmt *stmt = nil;
    //查询准备操作
    //参数3 . -1代表不限制sql语句长度
    //主要作用是将数据库对象db,sql语句,数据库跟随指针关联到一起,方便数据库查询操作.
    //参数4. & 数据库跟随指针对象
    //参数5. nil
    
    
    int result = sqlite3_prepare_v2(music, sql.UTF8String, -1, &stmt, nil);
    
    NSMutableArray *array = [NSMutableArray array];
    
    if (result == SQLITE_OK) {
        //        NSLog(@"查询歌手成功");
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            //取出表里每行中每个字段的数据
            const unsigned char *title =  sqlite3_column_text(stmt, 1);
            const unsigned char *pic = sqlite3_column_text(stmt, 2);
            
            //取出来数据放在model中
            NewSongModel *model = [[NewSongModel alloc] init];
            model.title = [NSString stringWithUTF8String:(const char *)title];
            model.pic = [NSString stringWithUTF8String:(const char *)pic];
            
            
            //放进数组
            [array addObject:model];
        }
        
        
        return array;
        
        
    }else{
        //        NSLog(@"准备失败");
    }
    
    //释放stmt,清除内存
    sqlite3_finalize(stmt);
    return nil;
}

-(void)dropNewSongForm1{
    NSString *sql = @"DROP TABLE newSongForm1";
    int result = sqlite3_exec(music, sql.UTF8String, NULL, NULL, nil);
    if (result == SQLITE_OK) {
        //        NSLog(@"删除歌手成功");
    }else{
        //        NSLog(@"删除歌手失败");
    }
    
    
}


//--------------------排行界面缓存------------------------

/*
-(void)createRankForm{
    
    //写建表的sql语句(TEXT 代表字符串类型  INTEGER 代表NSInteger类型)(lanou08表名, number是默认字段 name,gender,age 为自建字段)
    NSString *sql = @"CREATE TABLE IF NOT EXISTS RankForm (number INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, pic_url TEXT , array blod)";
    //执行数据库语句
    int result = sqlite3_exec(music, sql.UTF8String, NULL, NULL, NULL);
    if (result == SQLITE_OK) {
        //        NSLog(@"创建歌手表成功");
    }else{
        //        NSLog(@"创建歌手表失败");
    }
    
}

//插入数据
-(void)insertRankForm:(RankModel *)model{
    
    [self.queue inDatabase:^(FMDatabase *db) {
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:@[@"singerName", @"songName"]];
        
        BOOL flag = [db executeUpdate:@"insert into RankForm(title, pic_url, array) values (?, ?, ?)", model.title, model.pic_url, data];
        
        if (flag) {
            NSLog(@"success");
        } else {
            NSLog(@"failure");
        }
       
        
}


//查询所有
-(NSMutableArray *)selectAllRankForm{
    
    NSString *sql = @"SELECT * FROM RankForm";
    //创建数据库跟随指针对象
    sqlite3_stmt *stmt = nil;
    //查询准备操作
    //参数3 . -1代表不限制sql语句长度
    //主要作用是将数据库对象db,sql语句,数据库跟随指针关联到一起,方便数据库查询操作.
    //参数4. & 数据库跟随指针对象
    //参数5. nil
    
    
    int result = sqlite3_prepare_v2(music, sql.UTF8String, -1, &stmt, nil);
    
    NSMutableArray *array = [NSMutableArray array];
    
    if (result == SQLITE_OK) {
        //        NSLog(@"查询歌手成功");
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            //取出表里每行中每个字段的数据
            const unsigned char *title =  sqlite3_column_text(stmt, 1);
            const unsigned char *pic_url = sqlite3_column_text(stmt, 2);
            
            //取出来数据放在model中
            NewSongModel *model = [[NewSongModel alloc] init];
            model.title = [NSString stringWithUTF8String:(const char *)title];
            model.pic_url = [NSString stringWithUTF8String:(const char *)pic_url];
            
            
            //放进数组
            [array addObject:model];
        }
        
        
        return array;
        
        
    }else{
        //        NSLog(@"准备失败");
    }
    
    //释放stmt,清除内存
    sqlite3_finalize(stmt);
    return nil;
}

-(void)dropRankForm{
    NSString *sql = @"DROP TABLE newSongForm1";
    int result = sqlite3_exec(music, sql.UTF8String, NULL, NULL, nil);
    if (result == SQLITE_OK) {
        //        NSLog(@"删除歌手成功");
    }else{
        //        NSLog(@"删除歌手失败");
    }
    
    
}
*/

//创建乐库表
-(void)createTableMusicStorge
{
NSString *sql = @"CREATE TABLE IF NOT EXISTS MusicStorge(number INTEGER PRIMARY KEY AUTOINCREMENT,sectionTitle TEXT,itemsTitle TEXT,picUrl TEXT,SongId TEXT)";
    int result = sqlite3_exec(music, sql.UTF8String, NULL, NULL, nil);
    if (result == SQLITE_OK) {
        NSLog(@"创建表成功");
    }else{
        NSLog(@"创建表失败");
    }

}


//插入
-(void)insertMusicStorge :(StorgeModel *)model
{
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO MusicStorge(sectionTitle,itemsTitle,picUrl,SongId) VALUES('%@','%@','%@','%@')",model.parentname,model.songlist_name,model.small_pic_url,model.songlist_Id];
    int result = sqlite3_exec(music, sql.UTF8String, NULL, NULL, nil);
    if (result == SQLITE_OK) {
        //NSLog(@"插入成功");
    }else{
        //NSLog(@"插入失败");
    }

}

//查询所有
-(NSMutableArray *)selectAllMusicStorge
{
NSString *sql = @"SELECT * FROM MusicStorge";
    sqlite3_stmt *stmt =nil;
    int result = sqlite3_prepare(music, sql.UTF8String, -1, &stmt, nil);
    NSMutableArray *array = [NSMutableArray array];
    
    if (result == SQLITE_OK) {
        NSLog(@"乐库准备成功");
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
            int number = sqlite3_column_int(stmt, 0);
            const unsigned char *sectionTitle = sqlite3_column_text(stmt, 1);
            const unsigned char *itemsTitle = sqlite3_column_text(stmt, 2);
            const unsigned char *picUrl = sqlite3_column_text(stmt, 3);
            const unsigned char *SongId = sqlite3_column_text(stmt, 4);
            
            StorgeModel *model = [[StorgeModel alloc] init];
            model.number = number;
            model.parentname = [NSString stringWithUTF8String:(const char*)sectionTitle];
            model.songlist_name = [NSString stringWithUTF8String:(const char*)itemsTitle];
            model.small_pic_url = [NSString stringWithUTF8String:(const char*)picUrl];
            model.songlist_Id = [NSString stringWithUTF8String:(const char*)SongId];
            
            [array addObject:model];
        }
        return array;
    }else{
        NSLog(@"准备失败");
    }
    sqlite3_finalize(stmt);
    return nil;

}


//删除表
-(void)dropTableMusicStorge
{
NSString *sql = @"DROP TABLE MusicStorge";
    int result = sqlite3_exec(music, sql.UTF8String, NULL, NULL, nil);
    if (result == SQLITE_OK) {
        NSLog(@"删除成功");
    }else{
        NSLog(@"删除失败");
    }

}







//创建乐库表
-(void)createTableMusicVideo
{
    NSString *sql = @"CREATE TABLE IF NOT EXISTS MusicVideo(number INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT,picUrl TEXT)";
    int result = sqlite3_exec(music, sql.UTF8String, NULL, NULL, nil);
    if (result == SQLITE_OK) {
        NSLog(@"创建表成功");
    }else{
        NSLog(@"创建表失败");
    }
    
}


//插入
-(void)insertMusicVideo :(MusicVideoModel *)model
{
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO MusicVideo(title,picUrl) VALUES('%@','%@')",model.title,model.albumImg];
    int result = sqlite3_exec(music, sql.UTF8String, NULL, NULL, nil);
    if (result == SQLITE_OK) {
        //NSLog(@"插入成功");
    }else{
        //NSLog(@"插入失败");
    }
    
}

//查询所有
-(NSMutableArray *)selectAllMusicVideo
{
    NSString *sql = @"SELECT * FROM MusicVideo";
    sqlite3_stmt *stmt =nil;
    int result = sqlite3_prepare(music, sql.UTF8String, -1, &stmt, nil);
    NSMutableArray *array = [NSMutableArray array];
    
    if (result == SQLITE_OK) {
        NSLog(@"MV准备成功");
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
           // int number = sqlite3_column_int(stmt, 0);
            const unsigned char *title = sqlite3_column_text(stmt, 1);
            const unsigned char *picUrl = sqlite3_column_text(stmt, 2);
            
            
            MusicVideoModel *model = [[MusicVideoModel alloc] init];
   
            model.title = [NSString stringWithUTF8String:(const char*)title];
            model.albumImg = [NSString stringWithUTF8String:(const char*)picUrl];
         
            [array addObject:model];
        }
        return array;
    }else{
        NSLog(@"MV准备失败");
    }
    sqlite3_finalize(stmt);
    return nil;
    
}


//删除表
-(void)dropTableMusicVideo
{
    NSString *sql = @"DROP TABLE MusicVideo";
    int result = sqlite3_exec(music, sql.UTF8String, NULL, NULL, nil);
    if (result == SQLITE_OK) {
        NSLog(@"删除成功");
    }else{
        NSLog(@"删除失败");
    }
    
}


//创建乐库表
-(void)createSearchTable
{
    NSString *sql = @"CREATE TABLE IF NOT EXISTS SearchTable(number INTEGER PRIMARY KEY AUTOINCREMENT,string TEXT)";
    int result = sqlite3_exec(music, sql.UTF8String, NULL, NULL, nil);
    if (result == SQLITE_OK) {
        NSLog(@"创建表成功");
    }else{
        NSLog(@"创建表失败");
    }
    
}


//插入
-(void)insertSearch:(NSString *)str
{
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO SearchTable(string) VALUES('%@')",str];
    int result = sqlite3_exec(music, sql.UTF8String, NULL, NULL, nil);
    if (result == SQLITE_OK) {
        NSLog(@"插入成功");
    }else{
        NSLog(@"插入失败");
    }
    
}

//查询所有
-(NSMutableArray *)selectAllSearch
{
    NSString *sql = @"SELECT * FROM SearchTable";
    sqlite3_stmt *stmt =nil;
    int result = sqlite3_prepare(music, sql.UTF8String, -1, &stmt, nil);
    NSMutableArray *array = [NSMutableArray array];
    
    if (result == SQLITE_OK) {
        NSLog(@"MV准备成功");
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
            // int number = sqlite3_column_int(stmt, 0);
            const unsigned char *string = sqlite3_column_text(stmt, 1);
            
            NSString *str = [NSString stringWithUTF8String:(const char*)string];
            
            [array addObject:str];
        }
        return array;
    }else{
        NSLog(@"MV准备失败");
    }
    sqlite3_finalize(stmt);
    return nil;
    
}


//删除表
-(void)dropSearchTable
{
    NSString *sql = @"DROP TABLE SearchTable";
    int result = sqlite3_exec(music, sql.UTF8String, NULL, NULL, nil);
    if (result == SQLITE_OK) {
        NSLog(@"删除成功");
    }else{
        NSLog(@"删除失败");
    }
}










@end
