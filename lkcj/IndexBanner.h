//
//  IndexBanner.h
//  lkcj
//
//  Created by annilq on 2018/6/19.
//  Copyright © 2018年 annilq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IndexBanner : UICollectionReusableView<UIScrollViewDelegate>
@property (strong,nonatomic) UIScrollView *scrollView;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,strong) UIViewController *delegate;
@property NSArray *banners;
@end
