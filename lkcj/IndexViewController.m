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
#import "category/categoryCollectionViewController.h"
#import "category/categorlistController.h"
#import "UIColor+Hex.h"
#import "AppConfig.h"
#import "AppUtil.h"
@interface IndexViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property UICollectionView *collectionView;
@property IndexBanner *banner;
@property NSMutableArray *catlists;
@property NSMutableArray *remindlists;
@end

@implementation IndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"首页";
    [self getdatalist];
    [self getremindlist];
    [self initDatalist];
}
-(void)getdatalist{
    NSString *urlString = @"http://oa.jianguanoa.com/app-data-list/get-main-menu.do";
    [AppUtil getDataFrom:urlString withParams:nil andBlock:^(NSDictionary *data) {
        self.catlists=[data valueForKey:@"result"];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
    }];
}
-(void)getremindlist{
    NSString *urlString = @"http://oa.jianguanoa.com/reminder-config/get-all-remind-app.do";
    [AppUtil getDataFrom:urlString withParams:nil andBlock:^(NSDictionary *data) {
        self.remindlists=[data valueForKey:@"result"];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
    }];
}
-(void)initDatalist{
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection=UICollectionViewScrollDirectionVertical;
    layout.itemSize=CGSizeMake((SCREEN_WIDTH)/3, 130);
    layout.sectionInset = UIEdgeInsetsMake(0,0,30,0);
    layout.minimumLineSpacing=0;
    layout.minimumInteritemSpacing=0;
    self.collectionView=[[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:layout];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    self.collectionView.backgroundColor=[UIColor clearColor];
    self.collectionView.showsVerticalScrollIndicator=NO;
    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[IndexBanner class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                   withReuseIdentifier:@"banner"];
    [self.collectionView registerClass:[TitleReusableView class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                   withReuseIdentifier:@"title"];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(section==0){
        return [self.catlists count] ;
    }else{
        return [self.remindlists count];
    }
    
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
    NSMutableDictionary *cellData;
    // module or flow icon
    UIImageView *image;
    if(indexPath.section==0){
        cellData=[self.catlists objectAtIndex:indexPath.row];
        label.text=[cellData valueForKey:@"text"];
        NSString *categoryType = [[cellData valueForKey:@"name"] lowercaseString];
        image=[[UIImageView alloc] initWithImage:[UIImage imageNamed:[AppConfig getImageSelectedFromMoudleType:categoryType]]];
        
    }else if(indexPath.section==1){
        cellData=[self.remindlists objectAtIndex:indexPath.row];
        label.text=[cellData valueForKey:@"title"];
        NSString *formKey = [cellData valueForKey:@"formKey"];
        image=[[UIImageView alloc] initWithImage:[UIImage imageNamed:[AppConfig getImageFromformKey:formKey]]];
    }
    label.textColor=[UIColor colorWithHexString:@"8c8c8c"];
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:14];
    image.center = CGPointMake(cell.contentView.bounds.size.width/2,cell.contentView.bounds.size.height/2-10);
    label.center = CGPointMake(cell.contentView.bounds.size.width/2,cell.contentView.bounds.size.height/2+image.frame.size.height/2+10);
    [cell.contentView addSubview:image];
    [cell.contentView addSubview:label];
    cell.contentView.layer.borderWidth = 0.5;
    cell.contentView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        categoryCollectionViewController *category=[[categoryCollectionViewController alloc] init];
        NSDictionary *cellData=[self.catlists objectAtIndex:indexPath.row];
        category.functionId=[cellData valueForKey:@"value"];
        [self.navigationController pushViewController:category animated:false];
    }else{
        categorlistController *list=[[categorlistController alloc] init];
        NSDictionary *cellData=[self.remindlists objectAtIndex:indexPath.row];
        list.functionId= [cellData valueForKey:@"functionId"];
        [self.navigationController pushViewController:list animated:false];
    }
    
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
