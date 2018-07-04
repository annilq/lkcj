//
//  categoryCollectionViewController.m
//  lkcj
//
//  Created by annilq on 2018/6/21.
//  Copyright © 2018年 annilq. All rights reserved.
//

#import "categoryCollectionViewController.h"
#import "AppDelegate.h"
#import "UIColor+Hex.h"
#import "categorlistController.h"
#import "AppConfig.h"
#import "AppUtil.h"
@interface categoryCollectionViewController ()
@end

@implementation categoryCollectionViewController
@synthesize functionId,catlists;
static NSString * const reuseIdentifier = @"Cell";
- (instancetype)init

{
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection=UICollectionViewScrollDirectionVertical;
    layout.itemSize=CGSizeMake((SCREEN_WIDTH)/3, 130);
    layout.sectionInset = UIEdgeInsetsMake(0,0,30,0);
    layout.minimumLineSpacing=0;
    layout.minimumInteritemSpacing=0;
    
    return [super initWithCollectionViewLayout:layout];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    self.navigationItem.title=@"列表页";
    [self getdatalist];
    self.collectionView.backgroundColor=[UIColor clearColor];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}
-(void)getdatalist{
    NSString *urlString = @"http://oa.jianguanoa.com/app-data-list/get-sub-menu.do";
    // 一些特殊字符编码
    NSDictionary *paramData=@{@"functionId":[NSNumber numberWithInt:[self.functionId intValue]]};
    [AppUtil postDataTo:urlString withBody:paramData andBlock:^(NSDictionary *data) {
        self.catlists=[data valueForKey:@"result"];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
    }];
    
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.catlists count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    NSDictionary *cellData=[self.catlists objectAtIndex:indexPath.row];
    cell.backgroundColor=[UIColor colorWithHexString:@"ffffff"];
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    label.text=[cellData valueForKey:@"text"];
    label.textColor=[UIColor colorWithHexString:@"8c8c8c"];
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:14];
    NSString *iconName=[AppConfig getImageFromformKey: [cellData valueForKey:@"name" ]];
    UIImageView *image=[[UIImageView alloc] initWithImage:[UIImage imageNamed:iconName]];
    image.center = CGPointMake(cell.contentView.bounds.size.width/2,cell.contentView.bounds.size.height/2-10);
    label.center = CGPointMake(cell.contentView.bounds.size.width/2,cell.contentView.bounds.size.height/2+image.frame.size.height/2+10);
    [cell.contentView addSubview:image];
    [cell.contentView addSubview:label];
    cell.contentView.layer.borderWidth = 0.5;
    cell.contentView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    categorlistController *list=[[categorlistController alloc] init];
    list.functionId=[[self.catlists objectAtIndex:indexPath.row] valueForKey:@"value"];
    [self.navigationController pushViewController:list animated:false];
}
/*
 // Uncomment this method to specify if the specified item should be highlighted during tracking
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }
 */

/*
 // Uncomment this method to specify if the specified item should be selected
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }
 */

/*
 // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
 return NO;
 }
 
 - (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
 return NO;
 }
 
 - (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
 
 }
 */

@end
