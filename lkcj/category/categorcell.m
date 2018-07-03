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
-(void) configCellWithConfig:(NSDictionary *)config andData:(NSDictionary *)cellData{
    NSString *title=[cellData objectForKey:[config valueForKey:@"title"]] ;
    NSString *name=[cellData objectForKey:[config valueForKey:@"name"]] ;
    NSString *date=[cellData objectForKey:[config valueForKey:@"date"]];
    UILabel *titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 5, self.frame.size.width, 25)];
    titleLabel.text=title;
   UIImageView *img=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"name"]];
    img.frame=CGRectMake(10, 35, 25, 25);
    UILabel *nameLabel=[[UILabel alloc] initWithFrame:CGRectMake(40, 35, 100, 25)];
    nameLabel.text=name;
    nameLabel.textColor=[UIColor colorWithHexString:@"999999"];
    nameLabel.font=[UIFont systemFontOfSize:14];
    UIImageView *img2=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"w"]];
    img2.frame=CGRectMake(130, 35,25, 25);
    UILabel *dateLabel=[[UILabel alloc] initWithFrame:CGRectMake(160, 35, 100, 25)];
    dateLabel.text=date;
    dateLabel.textColor=[UIColor colorWithHexString:@"999999"];
    dateLabel.font=[UIFont systemFontOfSize:14];

    [self.contentView addSubview:titleLabel];
    [self.contentView addSubview:nameLabel];
    [self.contentView addSubview:dateLabel];
    [self.contentView addSubview:img];
    [self.contentView addSubview:img2];
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
