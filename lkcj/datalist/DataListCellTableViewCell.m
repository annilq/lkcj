//
//  DataListCellTableViewCell.m
//  lkcj
//
//  Created by annilq on 2018/6/28.
//  Copyright © 2018年 annilq. All rights reserved.
//

#import "DataListCellTableViewCell.h"
#import "UIColor+Hex.h"
#import "AppConfig.h"
@implementation DataListCellTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    return self;
}
-(void) configCellWithData:(NSDictionary *)cellData{
    NSString *assignee=[cellData objectForKey:@"assignee"];
    NSString *name=[cellData objectForKey:@"name_"] ;
    NSString *formKey=[cellData objectForKey:@"formKey"];
    NSString *businessKey=[cellData objectForKey:@"businessKey"];
    NSString *createTime=[cellData objectForKey:@"createTime"];
    NSString *imgstr=[AppConfig getImageFromformKey:formKey];
    UIImageView *img=[[UIImageView alloc]initWithImage:[UIImage imageNamed:imgstr]];
    img.frame=CGRectMake(10, 35, 25, 25);
    
    UILabel *businessKeyLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 5, self.frame.size.width, 25)];
    businessKeyLabel.text=businessKey;
    
    UILabel *assigneeLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 5, self.frame.size.width, 25)];
    assigneeLabel.text=assignee;

    UILabel *nameLabel=[[UILabel alloc] initWithFrame:CGRectMake(40, 35, 100, 25)];
    nameLabel.text=name;
    nameLabel.textColor=[UIColor colorWithHexString:@"999999"];
    nameLabel.font=[UIFont systemFontOfSize:14];

    UILabel *dateLabel=[[UILabel alloc] initWithFrame:CGRectMake(160, 35, 100, 25)];
    dateLabel.text=createTime;
    dateLabel.textColor=[UIColor colorWithHexString:@"999999"];
    dateLabel.font=[UIFont systemFontOfSize:14];
    
    [self.contentView addSubview:img];
    [self.contentView addSubview:assigneeLabel];
    [self.contentView addSubview:nameLabel];
    [self.contentView addSubview:dateLabel];
    [self.contentView addSubview:businessKeyLabel];
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
