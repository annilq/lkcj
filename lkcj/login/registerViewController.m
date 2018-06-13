//
//  registerViewController.m
//  lkcj
//
//  Created by annilq on 2018/5/23.
//  Copyright © 2018年 annilq. All rights reserved.
//
#import "registerViewController.h"
#import "AppDelegate.h"
#import "UIColor+Hex.h"

@interface registerViewController ()<UITextFieldDelegate>
{
    UITextField *userinput;
    UITextField *pwdinput;
    UITextField *eminput;
}
@end

@implementation registerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initsubview];
    // Do any additional setup after loading the view.
}
-(void)initsubview{
    UIEdgeInsets padding=UIEdgeInsetsMake(10, 20, 20, 20);
    NSInteger inputHeight=40;
    NSInteger contanerwidth=SCREEN_WIDTH-padding.left*2;
    UIView *containerview = [[UIView alloc] init];
    
    containerview.translatesAutoresizingMaskIntoConstraints=NO;
    UIColor *bdcolor=[UIColor colorWithWhite:0.8f
                                       alpha:1.0f];
    //    username
    userinput=[[UITextField alloc] initWithFrame:CGRectMake(0, 0, contanerwidth, inputHeight)];
    userinput.placeholder=@"请输入用户名";
    userinput.font=  [UIFont systemFontOfSize:16];
    userinput.delegate=self;
    CALayer *userbottomBorder = [CALayer layer];
    
    userbottomBorder.frame =CGRectMake(0, userinput.frame.size.height , userinput.frame.size.width, 1);
    userbottomBorder.backgroundColor = bdcolor.CGColor;
    [userinput.layer addSublayer:userbottomBorder];
    UILabel *userlabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, inputHeight)];
    userlabel.text=@"用户名";
    userinput.leftView =userlabel;
    userinput.leftViewMode = UITextFieldViewModeAlways;
    //    email
    eminput=[[UITextField alloc] initWithFrame:CGRectMake(0, inputHeight+padding.top, contanerwidth, inputHeight)];
    eminput.placeholder=@"请输入用户名";
    eminput.font=  [UIFont systemFontOfSize:16];
    CALayer *emailbottomBorder = [CALayer layer];
    
    emailbottomBorder.frame =CGRectMake(0, userinput.frame.size.height , userinput.frame.size.width, 1);
    emailbottomBorder.backgroundColor = bdcolor.CGColor;
    [eminput.layer addSublayer:emailbottomBorder];
    UILabel *emaillabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, inputHeight)];
    emaillabel.text=@"邮箱";
    eminput.leftView =emaillabel;
    eminput.leftViewMode = UITextFieldViewModeAlways;
    
    //    password
    pwdinput=[[UITextField alloc] initWithFrame:CGRectMake(0, (inputHeight+padding.top)*2, contanerwidth, inputHeight)];
    pwdinput.placeholder=@"请输入密码";
    pwdinput.font=  [UIFont systemFontOfSize:16];
    pwdinput.secureTextEntry=YES;
    CALayer *pswbottomBorder = [CALayer layer];
    pswbottomBorder.frame =CGRectMake(0, pwdinput.frame.size.height , pwdinput.frame.size.width, 1);
    pswbottomBorder.backgroundColor = bdcolor.CGColor;
    [pwdinput.layer addSublayer:pswbottomBorder];
    
    UILabel *pswlabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 45)];
    pswlabel.text=@"密码";
    
    pwdinput.leftView =pswlabel;
    pwdinput.leftViewMode = UITextFieldViewModeAlways;
    pwdinput.returnKeyType=UIReturnKeyDone;

    //    submit btn
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(0, (inputHeight+padding.top)*3+10, contanerwidth, inputHeight);
    [btn setTitle:@"注册" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.cornerRadius=5;
    btn.tintColor=[UIColor whiteColor];
    btn.backgroundColor=[UIColor colorWithHexString:@"4095ff"];
    
    //    logocontainer
    [self.view addSubview:containerview];

    NSArray *h=[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[containerview]-20-|" options:0 metrics:nil views:@{@"containerview":containerview}];
    NSArray *v=[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-80-[containerview]-0-|" options:0 metrics:nil views:@{@"containerview":containerview}];
    [self.view addConstraints:h];
    [self.view addConstraints:v];
    
    [containerview addSubview:userinput];
    [containerview addSubview:eminput];
    [containerview addSubview:pwdinput];
    [containerview addSubview:btn];
    
    self.view.backgroundColor=[UIColor whiteColor];
}

-(void)submit{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSLog(@"12");
    return YES;
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
