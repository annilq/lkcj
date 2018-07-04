//
//  AppUtil.h
//  lkcj
//
//  Created by annilq on 2018/6/28.
//  Copyright © 2018年 annilq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppUtil : NSObject
+(NSString *)transDictToStr:(NSDictionary *)params;
+(NSString*) removeLastOneChar:(NSString*)origin;
+(void) postDataTo:(NSString*)urlString withBody:(NSDictionary *)body andBlock:(void (^)(NSDictionary *))success;
+(void) getDataFrom:(NSString*)httpurl withParams:(NSDictionary *)params andBlock:(void (^)(NSDictionary *))success;
@end
