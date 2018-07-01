//
//  categorcell
//  lkcj
//
//  Created by annilq on 2018/6/28.
//  Copyright © 2018年 annilq. All rights reserved.
//

#import "categorcell.h"
#import "UIColor+Hex.h"
@implementation categorcell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"catcell"];
    return self;
}
-(void) configCellWithData:(NSDictionary *)cellData{
//    self.textLabel.text=[cellData objectForKey:@"projectName"];
    UILabel *title=[[UILabel alloc] initWithFrame:CGRectMake(10, 5, self.frame.size.width, 25)];
    title.text=[cellData objectForKey:@"projectName"];
   UIImageView *img=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"name"]];
    img.frame=CGRectMake(10, 35, 25, 25);
    UILabel *name=[[UILabel alloc] initWithFrame:CGRectMake(40, 35, 100, 25)];
    name.text=[cellData objectForKey:@"userName"];
    name.textColor=[UIColor colorWithHexString:@"999999"];
    name.font=[UIFont systemFontOfSize:14];
    UIImageView *img2=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"w"]];
    img2.frame=CGRectMake(130, 35,25, 25);
    UILabel *date=[[UILabel alloc] initWithFrame:CGRectMake(160, 35, 100, 25)];
    date.text=[cellData objectForKey:@"createDate"];
    date.textColor=[UIColor colorWithHexString:@"999999"];
    date.font=[UIFont systemFontOfSize:14];

    [self.contentView addSubview:title];
    [self.contentView addSubview:name];
    [self.contentView addSubview:date];
    [self.contentView addSubview:img];
    [self.contentView addSubview:img2];
//    self.detailText.frame=[cellData objectForKey:@"userName"];
//    self.detailTextLabel.frame=[cellData objectForKey:@"userName"];
}
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    
    //上分割线
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithHexString:@"ffffff"].CGColor);
    CGContextStrokeRect(context, CGRectMake(5, -1, rect.size.width - 10, 1));
    
    //下分割线
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithHexString:@"e2e2e2"].CGColor);
    CGContextStrokeRect(context, CGRectMake(5, rect.size.height, rect.size.width - 10, 1));
}
@end
