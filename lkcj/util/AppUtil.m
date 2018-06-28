//
//  AppUtil.m
//  lkcj
//
//  Created by annilq on 2018/6/28.
//  Copyright © 2018年 annilq. All rights reserved.
//

#import "AppUtil.h"

@implementation AppUtil
+(NSString *)transDictToStr:(NSDictionary *)params{
    NSMutableString *string=[[NSMutableString alloc] initWithString:@""];
    for(NSString *cur in params){
        [string appendString:[NSString stringWithFormat:@"%@=%@&",cur,[params valueForKey:cur]]];
    }
    NSString *result=[self removeLastOneChar:string];
    NSLog(@"%@",result);
    return result;
}
+(NSString*) removeLastOneChar:(NSString*)origin
{
    NSString* cutted;
    if([origin length] > 0){
        cutted = [origin substringToIndex:([origin length]-1)];// 去掉最后一个","
    }else{
        cutted = origin;
    }
    return cutted;
}
+(void) getDataFrom:(NSString*)urlString withParams:(NSDictionary *)params
{
    
}
+(void) postDataTo:(NSString*)urlString withBody:(NSDictionary *)body 
{
    // 一些特殊字符编码
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:urlString];
    
    // 2.创建请求 并：设置缓存策略为每次都从网络加载 超时时间30秒
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30];
    request.HTTPMethod=@"POST";
    [request setValue:[NSString stringWithFormat:@"application/x-www-form-urlencoded"] forHTTPHeaderField:@"Content-Type"];
    NSDictionary *loginData=@{@"accountName":[@"内部演示" stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]],@"userName":[@"测试员" stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]],@"passWord":@"0eca463ff5c2289de060e8472062c003"};
    NSString *loginstr=[AppUtil transDictToStr:loginData];
    NSString *aaa = [loginstr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSData *postData=[aaa dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPBody=postData;
    
    // 3.采用苹果提供的共享session
    NSURLSession *sharedSession = [NSURLSession sharedSession];
    
    // 4.由系统直接返回一个dataTask任务
    NSURLSessionDataTask *dataTask = [sharedSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // 网络请求完成之后就会执行，NSURLSession自动实现多线程
        NSLog(@"%@",[NSThread currentThread]);
        if (data && (error == nil)) {
            // 网络访问成功
            NSLog(@"data=%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
//            [[AppRouter sharedInstance] goMainView];
        } else {
            // 网络访问失败
            NSLog(@"error=%@",error);
        }
    }];
    
    // 5.每一个任务默认都是挂起的，需要调用 resume 方法
    [dataTask resume];
}
@end
