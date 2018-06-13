//
//  appRouter.h
//  lkcj
//
//  Created by annilq on 2018/5/23.
//  Copyright © 2018年 annilq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface AppRouter : NSObject
+ (AppRouter *)sharedInstance;
-(void)goMainView;
-(void)goLoginView;
@end
