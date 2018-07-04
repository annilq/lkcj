//
//  TitleReusableView.m
//  lkcj
//
//  Created by annilq on 2018/6/20.
//  Copyright © 2018年 annilq. All rights reserved.
//

#import "TitleReusableView.h"
#import "UIColor+Hex.h"
@interface TitleReusableView()
@property UILabel *label;
@end
@implementation TitleReusableView
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self subViewsInit];
    }
    return self;
}
-(void)subViewsInit{
    self.label=[[UILabel alloc]initWithFrame:self.bounds];
    self.label.backgroundColor=[UIColor colorWithHexString:@"f5f5f5"];
    self.label.textColor=[UIColor colorWithHexString:@"8c8c8c"];
    [self addSubview:self.label];
}
-(void) setLabelTitle:(NSString *) text{
    self.label.text=[NSString stringWithFormat:@"    %@",text];
    [self setNeedsLayout];
}
@end
