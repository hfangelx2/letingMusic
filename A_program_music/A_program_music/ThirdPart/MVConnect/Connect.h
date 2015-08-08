//
//  Connect.h
//  音悦台1.0
//
//  Created by 邴天宇 on 15/3/18.
//  Copyright (c) 2015年 邴天宇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
/**
 * 请求头
 */
#define RequestHeader  @{@"app-id":@"10201026",\
@"device-id":@"f850f42b9702326817be2db897127319",\
@"Authorization":@"Basic MTAyMDE6ODZmMjYyOWFlMjMwMzhkZTI3ZGE1NjI5MTgxZjE3OTM=",\
@"DeviceInfo":@"deviceinfo=%7B%22aid%22%3A%2210201026%22%2C%22os%22%3A%22Android%22%2C%22ov%22%3A%224.2.1%22%2C%22rn%22%3A%22480*800%22%2C%22dn%22%3A%22M040%22%2C\%22cr%22%3A%2246002%22%2C%22as%22%3A%22WIFI%22%2C%22uid%22%3A%22f850f42b9702326817be2db897127319%22%2C%22clid%22%3A100001000%7D",\
@"Device-N":@"JUU0JUI4JUFEJUU1JTlCJUJEJUU3JUE3JUJCJUU1JThBJUE4XyUyMldJRkklMjJfJTIyamFtZXMlMjI=",\
@"Device-V":@"QW5kcm9pZF80LjIuMV84MDAqMTI4MF8xMDAwMDEwMDA=",\
@"tt":@"f445048914b4dffbc423a70c548bfc87",\
@"pp":@"559dc431e61cf35eb1decbfdc0b7c080",\
@"Host":@"mapi.yinyuetai.com",\
@"Connection":@"Keep-Alive",\
@"User-Agent":@"Mozilla/5.0(Linux;U; Android 2.2.1; en-us; Nexus One Build/FRG83) AppleWebKit/533.1(KHTML,like Gecko) Version/4.0 Mobile Safari/533.1",\
@"Cookie":@"route=95f0b44eeadc95313b008be0d3f8f669; JSESSIONID=aaaWCoBfrH4I-a-JXU-Nu"\
}
/**
 *官方推荐
 */
#define Officicl @"http://mapi.yinyuetai.com/suggestions/front_page.json?"
/**
 *  MV 首播
 */
#define FirstRun @"http://mapi.yinyuetai.com/video/list.json?"
/**
 *  近日热播
 */
#define Today @"http://mapi.yinyuetai.com/video/list.json?"
/**                         http://mapi.yinyuetai.com/video/list.json?D-A=0&area=POP_ALL&offset=0&size=20
 *  正在流行
 */
#define Popular @"http://mapi.yinyuetai.com/video/list.json?"
/**
 *   猜你喜欢
 */
#define GuessYou @"http://mapi.yinyuetai.com/video/get_guess_videos.json?"
/**
 *  榜单 list 详情
 */
#define PLAYLISTdetail @"http://mapi.yinyuetai.com/playlist/show.json?"
/**
 *  V榜
 */

#define VBangLeft @"http://mapi.yinyuetai.com/vchart/trend.json?"
#define VBangRight @"http://mapi.yinyuetai.com/vchart/show.json?"
/**
 * 活动拼接  网址a = id
 */
#define ACTIVITY @"http://www.yinyuetai.com/c?a="
/**
 * Type VIDEO 详情 界面网络请求
 */
#define VIDEODETAIL @"http://mapi.yinyuetai.com/video/show.json?"
/**
 * VIDEO用户评论
 */
#define UserComment @"http://mapi.yinyuetai.com/video/comment/list.json?"
/**
 *  活动 用户评论
 */
#define ACTComment @"http://mapi.yinyuetai.com/playlist/comment/list.json?"
/**
 *  搜索 热门
 */
#define SearchHot @"http://mapi.yinyuetai.com/search/top_keyword.json"
/*
 *  MV 搜索 网址
 */
//http://mapi.yinyuetai.com/search/video.json?D-A=0&keyword=TFBOYS&offset=0&size=20
#define SearchMV @"http://mapi.yinyuetai.com/search/video.json?"
/**
 *  悦单 搜索网址
 */
//http://mapi.yinyuetai.com/search/playlist.json?D-A=0&keyword=TFBOYS&offset=0&size=20
#define SearchYD @"http://mapi.yinyuetai.com/search/playlist.json?"

typedef void(^CompletionLoad)(NSObject *result);

/**
 *悦单页面
 */
//#define YueDan @"http://mapi.yinyuetai.com/video/show.json?"
#define YueDan @"http://mapi.yinyuetai.com/playlist/list.json?"

/**
 * 悦单详情页面
 */
#define YueDanDetail @"http://mapi.yinyuetai.com/playlist/show.json?"


@interface Connect : NSObject

/**
 *AFNetworking
 */
+ (AFHTTPRequestOperation *)ConnectRequestAFWithURL:(NSString *)url
                                      params:(NSMutableDictionary *)params
                               requestHeader:(NSDictionary *)header
                                  httpMethod:(NSString *)httpMethod
                                       block:(CompletionLoad)block;


/**
 *系统自带类库
*/
+ (NSMutableURLRequest *)ConnectRequestWithURL:(NSString *)url
                                 params:(NSMutableDictionary *)params
                          requestHeader:(NSDictionary *)header
                             httpMethod:(NSString *)httpMethod
                                  block:(CompletionLoad)block;



@end
