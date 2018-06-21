//
//  IndexViewController.m
//  lkcj
//
//  Created by annilq on 2018/6/19.
//  Copyright © 2018年 annilq. All rights reserved.
//

#import "IndexViewController.h"
#import "IndexBanner.h"
#import "TitleReusableView.h"
#import "AppDelegate.h"
#import "categoryCollectionViewController.h"
#import "UIColor+Hex.h"
@interface IndexViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property UICollectionView *collectionview;
@property IndexBanner *banner;
@end

@implementation IndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"首页";
    [self initDatalist];
}

-(void)initDatalist{
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection=UICollectionViewScrollDirectionVertical;
    layout.itemSize=CGSizeMake((SCREEN_WIDTH)/3, 130);
    layout.sectionInset = UIEdgeInsetsMake(0,0,30,0);
    layout.minimumLineSpacing=0;
    layout.minimumInteritemSpacing=0;
    UICollectionView *collectionView=[[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:layout];
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    collectionView.backgroundColor=[UIColor clearColor];
    collectionView.showsVerticalScrollIndicator=NO;
    collectionView.delegate=self;
    collectionView.dataSource=self;
    [self.view addSubview:collectionView];
    [collectionView registerClass:[IndexBanner class]
       forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
              withReuseIdentifier:@"banner"];
    [collectionView registerClass:[TitleReusableView class]
       forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
              withReuseIdentifier:@"title"];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 5;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath{
    
    //先通过kind类型判断是头还是尾巴，然后在判断是哪一组，如果都是一样的头尾，那么只要第一次判断就可以了
    if([kind isEqual:UICollectionElementKindSectionHeader]){
        if(indexPath.section==0){
            IndexBanner *banner = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                     withReuseIdentifier:@"banner"
                                                                            forIndexPath:indexPath];
            banner.delegate=self;
            return banner;
        }else{
            TitleReusableView *label = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                          withReuseIdentifier:@"title"
                                                                                 forIndexPath:indexPath];
            if(indexPath.section==1){
                [label setLabelTitle:@"提醒"];
                
            }
            return label;
        }
        
        
    }
    return nil;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if(section==0){
        CGSize size = {self.view.frame.size.width, 330};
        return size;
    }else{
        CGSize size = {self.view.frame.size.width,40};
        return size;
    }
}
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
//{
//    CGSize size = {240,25};
//    return size;
//}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor colorWithHexString:@"ffffff"];
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    label.text=@"经营管理";
    label.textColor=[UIColor colorWithHexString:@"8c8c8c"];
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:14];
    UIImageView *image=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_jy.png"]];
    image.center = CGPointMake(cell.contentView.bounds.size.width/2,cell.contentView.bounds.size.height/2-10);
    label.center = CGPointMake(cell.contentView.bounds.size.width/2,cell.contentView.bounds.size.height/2+image.frame.size.height/2+10);
    [cell.contentView addSubview:image];
    [cell.contentView addSubview:label];
    cell.contentView.layer.borderWidth = 0.5;
    cell.contentView.layer.borderColor = [[UIColor lightGrayColor] CGColor];

    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
        categoryCollectionViewController *category=[[categoryCollectionViewController alloc] init];
    [self.navigationController pushViewController:category animated:false];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
