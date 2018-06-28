@interface DatalistViewCell(){
}
@end
@implementation DatalistViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]
    return self;
}
- (void)configCellWithData:(NSDictionary *)listData{
    // self.contentView
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