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
+(void) getDataFrom:(NSString*)url withParams:(NSDictionary *)params andBlock:(void (^)(NSDictionary *))success
{
    if(params!=nil){
        url=[NSString stringWithFormat:@"%@%@",url,[self transDictToStr],]
    }
    NSString *urlString = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:urlString];
    
    // 2.创建请求 并：设置缓存策略为每次都从网络加载 超时时间30秒
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30];
    // 3.采用苹果提供的共享session
    NSURLSession *sharedSession = [NSURLSession sharedSession];
    
    // 4.由系统直接返回一个dataTask任务
    NSURLSessionDataTask *dataTask = [sharedSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // 网络请求完成之后就会执行，NSURLSession自动实现多线程
        NSLog(@"%@",[NSThread currentThread]);
        NSLog(@"data=%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        if (data && (error == nil)) {
            // 网络访问成功
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            callback(json)
        } else {
            // 网络访问失败
            NSLog(@"error=%@",error);
        }
    }];
    // 5.每一个任务默认都是挂起的，需要调用 resume 方法
    [dataTask resume];
}
+(void) postDataTo:(NSString*)urlString withBody:(NSDictionary *)body andBlock:(void (^)(NSDictionary *))success
{
    // 一些特殊字符编码
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:urlString];
    
    // 2.创建请求 并：设置缓存策略为每次都从网络加载 超时时间30秒
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30];
    request.HTTPMethod=@"POST";
    [request setValue:[NSString stringWithFormat:@"application/x-www-form-urlencoded"] forHTTPHeaderField:@"Content-Type"];
    NSString *bodyStr=[AppUtil transDictToStr:body];
    NSString *encodeBodyStr = [bodyStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSData *postData=[encodeBodyStr dataUsingEncoding:NSUTF8StringEncoding];
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
           NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            success(json)
        } else {
            // 网络访问失败
            NSLog(@"error=%@",error);
        }
    }];
    
    // 5.每一个任务默认都是挂起的，需要调用 resume 方法
    [dataTask resume];
}


#pragma mark - Request Parameters
+ (void)sendHttpRequestWithHTTPURLString:(NSString *)URLString
                              parameters:(NSMutableDictionary *)parameters
                                 success:(void (^)(NSHTTPURLResponse * _Nullable response, KBasicModel *kBasicModel))success
                                 failure:(void (^)(NSHTTPURLResponse * _Nullable response, KBasicModel * _Nullable kBasicModel, NSError * _Nullable error, NSString * _Nullable errorStr))failure {
    [self sendHttpRequestWithHTTPMethod:@"POST" URLString:URLString parameters:parameters success:success failure:failure];
}
+ (void)sendHttpRequestWithHTTPMethod:(NSString *)method
                            URLString:(NSString *)URLString
                           parameters:(NSMutableDictionary *)parameters
                              success:(void (^)(NSHTTPURLResponse * _Nullable response, KBasicModel *kBasicModel))success
                              failure:(void (^)(NSHTTPURLResponse * _Nullable response, KBasicModel * _Nullable kBasicModel, NSError * _Nullable error, NSString * _Nullable errorStr))failure {
    NSURLRequest *urlRequest = [KHttpPackageModel HTTPRequestOperationForUploadDataWithHTTPMethod:method URLString:URLString parameters:parameters];
    __block void(^kSuccessBlock)(NSHTTPURLResponse * _Nullable response, KBasicModel * _Nullable kBasicModel) = success;
    __block void(^kFailureBlock)(NSHTTPURLResponse * _Nullable response, KBasicModel * _Nullable kBasicModel, NSError * _Nullable error, NSString * _Nullable errorStr) = failure;
    kWeakfy(self);
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
        kStrongfy(kWeakSelf);
        NSString *jsonStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        KBasicModel *kBasicModel = [KBasicModel yy_modelWithJSON:jsonStr];
        
        if (httpResponse.statusCode == 200 && kBasicModel.code == 200) {
            [kStrongSelf returnSuccessByHttpResponse:httpResponse andKBasicModel:kBasicModel andSuccess:kSuccessBlock];
        }else{
            [kStrongSelf returnFailureByHttpResponse:httpResponse andKBasicModel:kBasicModel andError:error andFailure:kFailureBlock];
        }
    }];
    [task resume];
}

#pragma mark - UploadData URLRequest
+ (NSURLRequest *)HTTPRequestOperationForUploadDataWithHTTPMethod:(NSString *)method URLString:(NSString *)URLString parameters:(NSDictionary *)parameters {
    URLString = [URLString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:URLString]];
    
    NSMutableURLRequest *mutableRequest = [urlRequest mutableCopy];
    mutableRequest.timeoutInterval = timeoutInterval_1;
    mutableRequest.cachePolicy = NSURLRequestReloadIgnoringCacheData;
    [mutableRequest setHTTPMethod:method];
    
    NSData *postData = [[self kNSStringFromNSDictionary:parameters] dataUsingEncoding:NSUTF8StringEncoding];
    [mutableRequest setHTTPBody:postData];
    [mutableRequest setValue:[NSString stringWithFormat:@"application/x-www-form-urlencoded"] forHTTPHeaderField:@"Content-Type"];
    //[mutableRequest setValue:[NSString stringWithFormat:@"application/json"] forHTTPHeaderField:@"Content-Type"];
    [mutableRequest setValue:[NSString stringWithFormat:@"%lu", (unsigned long)postData.length] forHTTPHeaderField:@"Content-Length"];
    
    NSString *kToken = [[NSUserDefaults standardUserDefaults] stringForKey:@"token"];
    if (kToken.length != 0) {
        [mutableRequest setValue:[NSString stringWithFormat:@"token=%@", [[NSUserDefaults standardUserDefaults] stringForKey:@"token"]] forHTTPHeaderField:@"Cookie"];
    }
    
    urlRequest = [mutableRequest copy];
    return urlRequest;
}


@end
