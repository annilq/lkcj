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
@end
