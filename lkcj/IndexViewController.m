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
#import "categorlistController.h"
#import "UIColor+Hex.h"
#import "AppConfig.h"
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
    NSString *urlString = @"http://oa.jianguanoa.com/my-process/list-as-category-app.do";
    // 一些特殊字符编码
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:urlString];
    
    // 2.创建请求 并：设置缓存策略为每次都从网络加载 超时时间30秒
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30];
    // 3.采用苹果提供的共享session
    NSURLSession *sharedSession = [NSURLSession sharedSession];
    
    // 4.由系统直接返回一个dataTask任务
    NSURLSessionDataTask *dataTask = [sharedSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // 网络请求完成之后就会执行，NSURLSession自动实现多线程
        NSLog(@"%@",[NSThread currentThread]);
        NSLog(@"data=%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        if (data && (error == nil)) {
            // 网络访问成功
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            self.catlists=[json valueForKey:@"result"];
            
            [self.collectionView reloadData];
        } else {
            // 网络访问失败
            NSLog(@"error=%@",error);
        }
    }];
    
    // 5.每一个任务默认都是挂起的，需要调用 resume 方法
    [dataTask resume];
}
-(void)getremindlist{
    NSString *urlString = @"http://oa.jianguanoa.com/reminder-config/get-all-remind-app.do";
    // 一些特殊字符编码
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:urlString];
    
    // 2.创建请求 并：设置缓存策略为每次都从网络加载 超时时间30秒
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30];
    // 3.采用苹果提供的共享session
    NSURLSession *sharedSession = [NSURLSession sharedSession];
    
    // 4.由系统直接返回一个dataTask任务
    NSURLSessionDataTask *dataTask = [sharedSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // 网络请求完成之后就会执行，NSURLSession自动实现多线程
        NSLog(@"%@",[NSThread currentThread]);
        NSLog(@"data=%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        if (data && (error == nil)) {
            // 网络访问成功
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            self.remindlists=[json valueForKey:@"result"];
            
            [self.collectionView reloadData];
        } else {
            // 网络访问失败
            NSLog(@"error=%@",error);
        }
    }];
    
    // 5.每一个任务默认都是挂起的，需要调用 resume 方法
    [dataTask resume];
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
    if(indexPath.section==0){
        cellData=[self.catlists objectAtIndex:indexPath.row];
         label.text=[cellData valueForKey:@"categoryName"];
    }else if(indexPath.section==1){
        cellData=[self.remindlists objectAtIndex:indexPath.row];
        label.text=[cellData valueForKey:@"title"];
    }
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
    if(indexPath.section==0){
        categoryCollectionViewController *category=[[categoryCollectionViewController alloc] init];
        [self.navigationController pushViewController:category animated:false];
    }else{
        categorlistController *list=[[categorlistController alloc] init];
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
