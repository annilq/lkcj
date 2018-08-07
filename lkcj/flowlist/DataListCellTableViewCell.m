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
@interface DataListCellTableViewCell()
@property (strong,nonatomic) UILabel *assigneeLabel;
@property (strong,nonatomic) UILabel *nameLabel;
@property (strong,nonatomic) UILabel *dateLabel;
@property (strong,nonatomic) UILabel *businessKeyLabel;
@property (strong,nonatomic) UIImageView *img;

@end
@implementation DataListCellTableViewCell
@synthesize nameLabel,img,assigneeLabel,businessKeyLabel,dateLabel;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self initLabel];
    return self;
}
-(void) configCellWithData:(NSDictionary *)cellData{
    NSString *assignee=[cellData objectForKey:@"assignee"];
    NSString *name=[cellData objectForKey:@"name_"] ;
    NSString *formKey=[cellData objectForKey:@"formKey"];
    NSString *businessKey=[cellData objectForKey:@"businessKey"];
    NSString *createTime=[cellData objectForKey:@"createTime"];
    NSString *imgstr=[AppConfig getImageFromformKey:formKey];
    self.nameLabel.text=name;
    self.assigneeLabel.text=assignee;
    self.businessKeyLabel.text=businessKey;
    self.dateLabel.text=createTime;
    [self.img setImage: [UIImage imageNamed:imgstr]];
}
-(void) initLabel{
    self.img=[[UIImageView alloc]init];
    self.img.frame=CGRectMake(10, 15, 25, 25);
    
    self.assigneeLabel=[[UILabel alloc] initWithFrame:CGRectMake(50, 35, self.frame.size.width, 25)];
    self.assigneeLabel.textColor=[UIColor colorWithHexString:@"999999"];
    self.assigneeLabel.font=[UIFont systemFontOfSize:14];
    
    self.nameLabel=[[UILabel alloc] initWithFrame:CGRectMake(50, 15, 100, 25)];

    self.dateLabel=[[UILabel alloc] initWithFrame:CGRectMake(160, 15, 100, 25)];
    self.dateLabel.textColor=[UIColor colorWithHexString:@"999999"];
    self.dateLabel.font=[UIFont systemFontOfSize:14];
    
    self.businessKeyLabel=[[UILabel alloc] initWithFrame:CGRectMake(50, 55, self.frame.size.width, 25)];
    self.businessKeyLabel.textColor=[UIColor colorWithHexString:@"999999"];
    self.businessKeyLabel.font=[UIFont systemFontOfSize:14];
   
    [self.contentView addSubview:img];
    [self.contentView addSubview:self.assigneeLabel];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.dateLabel];
    [self.contentView addSubview:self.businessKeyLabel];
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
