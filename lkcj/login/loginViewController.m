//
//  ViewController.m
//  lkcj
//
//  Created by annilq on 2018/4/10.
//  Copyright © 2018年 annilq. All rights reserved.
//

#import "loginViewController.h"
#import "registerViewController.h"
#import "resetpswViewController.h"
#import "AppDelegate.h"
#import "AppRouter.h"
#import "UIColor+Hex.h"
#import "AppUtil.h"
@interface loginViewController (){
    UITextField *userinput;
    UITextField *pwdinput;
}
-(void)initsubview;
-(void)setcontainerview;
@end

@implementation loginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initsubview];
}
-(void)initsubview{
    [self setcontainerview];
}
-(void)login:(id)sender{
    [self.view endEditing:YES];
    NSString *urlString = @"http://oa.jianguanoa.com/sys/app-login.do";
    // 一些特殊字符编码
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:urlString];
    
    // 2.创建请求 并：设置缓存策略为每次都从网络加载 超时时间30秒
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30];
    request.HTTPMethod=@"POST";
    [request setValue:[NSString stringWithFormat:@"application/x-www-form-urlencoded"] forHTTPHeaderField:@"Content-Type"];
    NSDictionary *loginData=@{@"accountName":[@"内部演示" stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]],@"userName":[@"测试员" stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]],@"passWord":@"0eca463ff5c2289de060e8472062c003"};
    NSString *loginstr=[AppUtil transDictToStr:loginData];
    NSString *aaa = [loginstr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];

    NSData *postData=[aaa dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPBody=postData;

    // 3.采用苹果提供的共享session
    NSURLSession *sharedSession = [NSURLSession sharedSession];
    
    // 4.由系统直接返回一个dataTask任务
    NSURLSessionDataTask *dataTask = [sharedSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // 网络请求完成之后就会执行，NSURLSession自动实现多线程
        NSLog(@"%@",[NSThread currentThread]);
        if (data && (error == nil)) {
            // 网络访问成功
            NSLog(@"data=%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
            dispatch_async(dispatch_get_main_queue(), ^{
                [[AppRouter sharedInstance] goMainView];
            });
        } else {
            // 网络访问失败
            NSLog(@"error=%@",error);
        }
    }];
    
    // 5.每一个任务默认都是挂起的，需要调用 resume 方法
    [dataTask resume];
    
}
-(void)registerAccount{
    registerViewController *reg=[[registerViewController alloc] init];
    [self presentViewController:reg animated:YES completion:NULL];


//    [self.navigationController pushViewController:reg animated:false];
}
-(void)resetpsw{
    resetpswViewController *reset=[[resetpswViewController alloc] init];
    [self presentViewController:reset animated:YES completion:NULL];
//    [self.navigationController pushViewController:reset animated:false];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setcontainerview{
    UIEdgeInsets padding=UIEdgeInsetsMake(10, 20, 20, 20);
    NSInteger inputHeight=40;
    NSInteger contanerwidth=SCREEN_WIDTH-padding.left*2;
    
    UIView *containerview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, contanerwidth,SCREEN_HEIGHT-300)];
    containerview.center= CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
    //    logo
    UILabel *logo=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, contanerwidth, 50)];
    logo.text=@"logo";
    logo.textAlignment=NSTextAlignmentCenter;
    logo.font=[UIFont systemFontOfSize:30];
    //    logo.textColor=[UIColor whiteColor];
    //    center x的数值可以根据parent view的宽度/2
    //    center x的数值可以根据自身高度/2
    //    也可以将frame的left设置成（parentsview-selfview）/2
    UIColor *bdcolor=[UIColor colorWithWhite:0.8f
                                       alpha:1.0f];
    //    username
    userinput=[[UITextField alloc] initWithFrame:CGRectMake(0, (inputHeight+padding.top)+50, contanerwidth, inputHeight)];
    userinput.placeholder=@"用户名";
    userinput.font=  [UIFont systemFontOfSize:16];
    CALayer *bottomBorder = [CALayer layer];
    
    bottomBorder.frame =CGRectMake(0, userinput.frame.size.height , userinput.frame.size.width, 1);
    bottomBorder.backgroundColor = bdcolor.CGColor;
    [userinput.layer addSublayer:bottomBorder];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"username"]];
    UIView *imgViewcontainer=[[UIView alloc]initWithFrame:CGRectMake(0, 0, imgView.bounds.size.width+10, imgView.bounds.size.height)];
    [imgView setFrame:CGRectMake(5, 0, imgView.bounds.size.width, imgView.bounds.size.height)];
    [imgViewcontainer addSubview:imgView];
    userinput.leftView =imgViewcontainer;
    userinput.leftViewMode = UITextFieldViewModeAlways;
    
    //    password
    pwdinput=[[UITextField alloc] initWithFrame:CGRectMake(0, (inputHeight+padding.top)*2+50, contanerwidth, inputHeight)];
    pwdinput.placeholder=@"密码";
    pwdinput.font=  [UIFont systemFontOfSize:16];
    pwdinput.secureTextEntry=YES;
    CALayer *pswbottomBorder = [CALayer layer];
    pswbottomBorder.frame =CGRectMake(0, pwdinput.frame.size.height , pwdinput.frame.size.width, 1);
    pswbottomBorder.backgroundColor = bdcolor.CGColor;
    [pwdinput.layer addSublayer:pswbottomBorder];

    UIImageView *pswimgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mm"]];
    UIView *psimgViewcontainer=[[UIView alloc]initWithFrame:CGRectMake(0, 0, pswimgView.bounds.size.width+10, pswimgView.bounds.size.height)];
    [pswimgView setFrame:CGRectMake(5, 0, pswimgView.bounds.size.width, pswimgView.bounds.size.height)];
    [psimgViewcontainer addSubview:pswimgView];
    
    pwdinput.leftView =psimgViewcontainer;
    pwdinput.leftViewMode = UITextFieldViewModeAlways;
    
    
    //    submit btn
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(0, (inputHeight+padding.top)*3+50, SCREEN_WIDTH-80, inputHeight);
    btn.center=CGPointMake(containerview.frame.size.width/2, 240+btn.frame.size.height/2);
    [btn setTitle:@"登录" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.cornerRadius=5;
    btn.tintColor=[UIColor whiteColor];
    btn.backgroundColor=[UIColor colorWithHexString:@"4095ff"];
//    register btn
    UIButton *registerbtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    registerbtn.frame = CGRectMake(20, 315, 90, 20);
    [registerbtn setTitle:@"注册账号" forState:UIControlStateNormal];
    [registerbtn addTarget:self action:@selector(registerAccount) forControlEvents:UIControlEventTouchUpInside];
    UIButton *forgetpwdbtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    forgetpwdbtn.frame = CGRectMake(contanerwidth-40-90, 315, 90, 20);
    [forgetpwdbtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetpwdbtn addTarget:self action:@selector(resetpsw) forControlEvents:UIControlEventTouchUpInside];
 
    //    logocontainer
    [containerview addSubview:logo];
    [containerview addSubview:userinput];
    [containerview addSubview:pwdinput];
    [containerview addSubview:btn];
    [containerview addSubview:registerbtn];
    [containerview addSubview:forgetpwdbtn];
    registerbtn.translatesAutoresizingMaskIntoConstraints=NO;
    forgetpwdbtn.translatesAutoresizingMaskIntoConstraints=NO;

    NSArray *h=[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[registerbtn(90)]-[forgetpwdbtn]-20-|" options:0 metrics:nil views:@{@"registerbtn":registerbtn,@"forgetpwdbtn":forgetpwdbtn}];
    NSArray *v=[NSLayoutConstraint constraintsWithVisualFormat:@"V:[btn]-20-[registerbtn(20)]" options:0 metrics:nil views:@{@"registerbtn":registerbtn,@"btn":btn}];
    NSArray *ph=[NSLayoutConstraint constraintsWithVisualFormat:@"H:[forgetpwdbtn(==registerbtn)]-20-|" options:0 metrics:nil views:@{@"forgetpwdbtn":forgetpwdbtn,@"registerbtn":registerbtn}];
    NSArray *pv=[NSLayoutConstraint constraintsWithVisualFormat:@"V:[btn]-20-[forgetpwdbtn(==registerbtn)]" options:0 metrics:nil views:@{@"forgetpwdbtn":forgetpwdbtn,@"btn":btn,@"registerbtn":registerbtn}];
    [containerview addConstraints:h];
    [containerview addConstraints:v];
    [containerview addConstraints:ph];
    [containerview addConstraints:pv];

    [self.view addSubview:containerview];
}
-(void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
@end
