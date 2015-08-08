//
//  Connect.m
//  音悦台1.0
//
//  Created by 邴天宇 on 15/3/18.
//  Copyright (c) 2015年 邴天宇. All rights reserved.
//

#import "Connect.h"

@implementation Connect

+ (AFHTTPRequestOperation *)ConnectRequestAFWithURL:(NSString *)url
                                             params:(NSMutableDictionary *)params
                                      requestHeader:(NSDictionary *)header
                                         httpMethod:(NSString *)httpMethod
                                              block:(CompletionLoad)block
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    
    //添加请求头
    for (NSString *key in header.allKeys) {
        [request addValue:header[key] forHTTPHeaderField:key];
        
    }
    NSLog(@"%@",request);
    //get请求
    NSComparisonResult compResult1 =[httpMethod caseInsensitiveCompare:@"GET"];
    if (compResult1 == NSOrderedSame) {
        [request setHTTPMethod:@"GET"];
        
        //添加参数，将参数拼接在url后面
        NSMutableString *paramsString = [NSMutableString string];
        NSArray *allkeys = [params allKeys];
        for (NSString *key in allkeys) {
            NSString *value = [params objectForKey:key];
            
            [paramsString appendFormat:@"&%@=%@", key, value];
        }
        
        if (paramsString.length > 0) {
            //重新设置url
            [request setURL:[NSURL URLWithString:[url stringByAppendingString:paramsString]]];
        }
    }
    
    //post请求
    NSComparisonResult compResult2 =[httpMethod caseInsensitiveCompare:@"POST"];
    if (compResult2 == NSOrderedSame) {
        [request setHTTPMethod:@"POST"];
        
        //添加参数
        for (NSString *key in params) {
            id value = params[key];
            //如果参数无key，直接设置HTTPBody
            if ([value isKindOfClass:[NSData class]]) {
                [request setHTTPBody:value];
            }else{
                [request setValue:value forKey:key];
            }
        }
    }
    
    //发送请求
    AFHTTPRequestOperation *requstOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    //设置返回数据的解析方式
    requstOperation.responseSerializer = [AFJSONResponseSerializer serializer];
    [requstOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (block != nil) {
            NSLog(@"reqiest = %@",request);
            block(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", [error localizedDescription]);
        if (block != nil) {
            //            block(error);
            block(nil);
        }
        
    }];
    [requstOperation start];
    
    return requstOperation;
}


+ (NSMutableURLRequest *)ConnectRequestWithURL:(NSString *)url
                                        params:(NSMutableDictionary *)params
                                 requestHeader:(NSDictionary *)header
                                    httpMethod:(NSString *)httpMethod
                                         block:(CompletionLoad)block

{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    
    //添加请求头
    for (NSString *key in header.allKeys) {
        [request addValue:header[key] forHTTPHeaderField:key];
    }
    
    //get请求
    NSComparisonResult compResult1 =[httpMethod caseInsensitiveCompare:@"GET"];
    if (compResult1 == NSOrderedSame) {
        [request setHTTPMethod:@"GET"];
        
        //添加参数，将参数拼接在url后面
        NSMutableString *paramsString = [NSMutableString string];
        NSArray *allkeys = [params allKeys];
        for (NSString *key in allkeys) {
            NSString *value = [params objectForKey:key];
            
            [paramsString appendFormat:@"&%@=%@", key, value];
        }
        
        if (paramsString.length > 0) {
            //重新设置url
            [request setURL:[NSURL URLWithString:[url stringByAppendingString:paramsString]]];
        }
    }
    
    //post请求
    NSComparisonResult compResult2 =[httpMethod caseInsensitiveCompare:@"POST"];
    if (compResult2 == NSOrderedSame) {
        [request setHTTPMethod:@"POST"];
        
        //添加参数
        for (NSString *key in params) {
            id value = params[key];
            //如果参数无key，直接设置HTTPBody
            if ([value isKindOfClass:[NSData class]]) {
                [request setHTTPBody:value];
            }else{
                [request setValue:value forKey:key];
            }
        }
    }
    
    //发送请求
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            NSLog(@"error:%@", connectionError);
            if (block != nil) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    block(connectionError);
                });
                
            }
        }else{
            if (block != nil) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:NULL];
                    block(result);
                });
                
            }
        }
    }];
    
    return request;
}


@end
