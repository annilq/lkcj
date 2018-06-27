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
@end
