//
//  IndexBanner.m
//  lkcj
//
//  Created by annilq on 2018/6/19.
//  Copyright © 2018年 annilq. All rights reserved.
//

#import "IndexBanner.h"
#import "TitleReusableView.h"
#import "DatalistViewController.h"
#import "UIColor+Hex.h"
@implementation IndexBanner

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self subViewsInit];
    }
    return self;
}

- (void)subViewsInit {
   
    [self initBanner];
    [self initPageControl];
    [self initMenu];
    [self initFirstHeader];

    
}
-(void) initBanner{
    self.scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 200)];
    self.scrollView.delegate=self;
     self.banners=@[@"http://oa.jianguanoa.com//image/banner/banner-1.jpg",@"http://oa.jianguanoa.com//image/banner/banner-2.jpg",@"http://oa.jianguanoa.com//image/banner/banner-3.jpg"];
    CGFloat width=self.scrollView.bounds.size.width;
    CGFloat height=self.scrollView.bounds.size.height;
    for (NSInteger i=0; i<[self.banners count]; i++) {
        NSURL *url = [NSURL URLWithString:self.banners[i]];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [[UIImage alloc] initWithData:data];
        
        UIImageView *imageView=[[UIImageView alloc] initWithImage:image];
        [imageView setFrame:CGRectMake(i*width, 0, width, height)];
        imageView.contentMode=UIViewContentModeScaleAspectFill;
        [self.scrollView addSubview:imageView];
    }
    [self.scrollView setBounces:NO];
    [self.scrollView setShowsHorizontalScrollIndicator:NO];
    [self.scrollView setContentSize:CGSizeMake([self.banners count]*width, height)];
    [self.scrollView setPagingEnabled:YES];
    [self addSubview:self.scrollView];
}
-(void) initPageControl{
    CGFloat width=self.scrollView.bounds.size.width;
    self.pageControl=[[UIPageControl alloc] init];
    self.pageControl.backgroundColor=[UIColor clearColor];
    [self.pageControl setBounds:CGRectMake(0, 0,self.frame.size.width, 10)];
//                                                  200-10*2=180
    [self.pageControl setCenter:CGPointMake(width/2,180)];
    self.pageControl.numberOfPages=[self.banners count];
    self.pageControl.currentPage=0;
    [self.pageControl setCurrentPageIndicatorTintColor:[UIColor greenColor]];
    
    [self.pageControl setPageIndicatorTintColor:[UIColor yellowColor]];
    [self.pageControl addTarget:self action:@selector(switchPage:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_pageControl];
}
-(void) initMenu{
    UIButton *aboutme=[UIButton buttonWithType:UIButtonTypeCustom];

    aboutme.translatesAutoresizingMaskIntoConstraints=NO;
    [aboutme setImage:[UIImage imageNamed:@"aboutme.png"] forState:UIControlStateNormal];
    [aboutme setTitle:@"我发起的" forState:UIControlStateNormal];
    [aboutme setTitleColor:[UIColor colorWithHexString:@"8c8c8c"] forState:UIControlStateNormal];
    aboutme.titleLabel.font=[UIFont systemFontOfSize:14];
    aboutme.titleEdgeInsets = UIEdgeInsetsMake(0, -aboutme.imageView.frame.size.width-36, -aboutme.imageView.frame.size.height-50, 0);
    aboutme.imageEdgeInsets = UIEdgeInsetsMake(-aboutme.titleLabel.intrinsicContentSize.height, 0, 0, -aboutme.titleLabel.intrinsicContentSize.width);
    [self addSubview:aboutme];
    [aboutme addTarget:self action:@selector(golist) forControlEvents:UIControlEventTouchUpInside];
    UIButton *forme=[UIButton buttonWithType:UIButtonTypeCustom];
    forme.translatesAutoresizingMaskIntoConstraints=NO;
    [forme setImage:[UIImage imageNamed:@"newflow.png"] forState:UIControlStateNormal];
    [forme setTitle:@"带我审批" forState:UIControlStateNormal];
    [forme setTitleColor:[UIColor colorWithHexString:@"8c8c8c"] forState:UIControlStateNormal];
    forme.titleLabel.font=[UIFont systemFontOfSize:14];
    forme.titleEdgeInsets = UIEdgeInsetsMake(0, -forme.imageView.frame.size.width-40, -forme.imageView.frame.size.height-50, 0);
    forme.imageEdgeInsets = UIEdgeInsetsMake(-forme.titleLabel.intrinsicContentSize.height, 0, 0, -forme.titleLabel.intrinsicContentSize.width);
    [forme addTarget:self action:@selector(golist) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:forme];
    NSArray *h=[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[aboutme]-[forme]" options:0 metrics:nil views:@{@"aboutme":aboutme,@"forme":forme}];
    NSArray *v=[NSLayoutConstraint constraintsWithVisualFormat:@"V:[scrollView]-20-[aboutme(60)]" options:0 metrics:nil views:@{@"aboutme":aboutme,@"scrollView":self.scrollView}];
    NSArray *ph=[NSLayoutConstraint constraintsWithVisualFormat:@"H:[aboutme]-[forme(==aboutme)]-0-|" options:0 metrics:nil views:@{@"forme":forme,@"aboutme":aboutme}];
    NSArray *pv=[NSLayoutConstraint constraintsWithVisualFormat:@"V:[scrollView]-20-[forme(==aboutme)]" options:0 metrics:nil views:@{@"forme":forme,@"aboutme":aboutme,@"scrollView":self.scrollView}];
    [self addConstraints:h];
    [self addConstraints:v];
    [self addConstraints:ph];
    [self addConstraints:pv];

}
-(void)initFirstHeader{
    CGFloat width=self.scrollView.bounds.size.width;

    TitleReusableView *title=[[TitleReusableView alloc]initWithFrame:CGRectMake(0, 290, width, 40)];
    [title setLabelTitle:@"数据列表"];
    [self addSubview:title];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger currentPage=scrollView.contentOffset.x/self.bounds.size.width;
    [self.pageControl setCurrentPage:currentPage];
}
- (void)switchPage:(id)sender{
    UIPageControl *currentControl=(UIPageControl *)sender;
    NSInteger currentPage=currentControl.currentPage;
    [self.scrollView setContentOffset:CGPointMake(currentPage*self.bounds.size.width, 0)] ;
}
-(void)golist{
    DatalistViewController *list=[[DatalistViewController alloc] init];
    [self.delegate.navigationController pushViewController:list animated:false];
}
@end
