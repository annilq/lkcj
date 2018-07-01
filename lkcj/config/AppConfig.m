//
//  AppConfig.m
//  lkcj
//
//  Created by annilq on 2018/6/28.
//  Copyright © 2018年 annilq. All rights reserved.
//

#import "AppConfig.h"
@interface AppConfig()

@end
@implementation AppConfig

+ (NSString *)getImageFromMoudleType:(NSString *)key {
    
    static dispatch_once_t onceToken;
    static NSDictionary *jg_workflow_left_dict = nil;
    dispatch_once(&onceToken, ^{
        jg_workflow_left_dict = @{@"contract" : @"dagl",
                                  @"project" : @"jygl",
                                  @"finance" : @"cwgl",
                                  @"chief" : @"xzgl",
                                  @"personnel" : @"rsgl",
                                  @"other" : @"qtgl"};
    });
    
    return jg_workflow_left_dict[key];
}

+ (NSString *)getImageSelectedFromMoudleType:(NSString *)key {
    
    static dispatch_once_t onceToken;
    static NSDictionary *jg_workflow_left_dict = nil;
    dispatch_once(&onceToken, ^{
        jg_workflow_left_dict = @{@"contract" : @"dagl-a",
                                  @"project" : @"jygl-a",
                                  @"finance" : @"cwgl-a",
                                  @"chief" : @"xzgl-a",
                                  @"personnel" : @"rsgl-a",
                                  @"other" : @"qtgl-a"};
    });
    
    return jg_workflow_left_dict[key];
}

+ (NSString *)getImageFromformKey:(NSString *)key {
    static dispatch_once_t onceToken;
    static NSDictionary *jg_menus_dict = nil;
    dispatch_once(&onceToken, ^{
        jg_menus_dict = @{
                          //============== 档案管理 =============
                          @"Project_ContractApplySingle" : @"gcht",  //工程合同
                          @"Chief_AgreementApply" : @"zjht",      //证件挂靠合同(证件合同)
                          @"Contract_BcompanyContract" : @"fgsht", // 分公司合同
                          @"Contract_CommonContract" : @"tyht",     // 通用合同
                          @"Contract_GodownEntry" : @"rkd",         // 入库单
                          @"Finance_PerformanceBond" : @"lybzj",
                          
                          //============== 经营管理 =============
                          @"Project_BidApply" : @"tbsqd" ,          //投标申请单
                          @"Project_CommisionApply" : @"tcsq" ,     //提成申请
                          @"Project_AttendanceApply" : @"ccsq" ,        //出场申请
                          @"Project_IntroductionLetter" : @"jsx" ,      // 介绍信
                          @"Project_WinBid" : @"zbggl" ,                // 中标公告栏
                          
                          //============== 财务管理 =============
                          @"Finance_DepositApplySingle" : @"tbbzj" ,        // 投标保证金
                          @"Finance_ProjectMoney" : @"gck" ,
                          @"Finance_PayMoney" : @"fkd" ,
                          @"Finance_OutRun" : @"wjz" ,
                          @"Finance_BankGuarantee" : @"yhbh" ,
                          @"Finance_OtherMoney" : @"sk" ,
                          @"Finance_TaxReceiptRegister" : @"gcsp" ,
                          @"Finance_AddedValueTax" : @"gcfp" ,
                          @"Finance_Reimbursement" : @"bxd" ,
                          @"Finance_BorrowMoney" : @"jkd" ,
                          @"Finance_OpenAccount" : @"yhkh" ,
                          @"Finance_TaxRecord" : @"wspz" ,
                          @"Finance_PaymentInvoice" : @"cbfp" ,
                          
                          //============== 行政管理 =============
                          @"Chief_CertificateApplyNew" : @"jzj" ,
                          @"Chief_CertificateReturn" : @"hzj" ,
                          @"Chief_CertificateShift" : @"zjtp" ,
                          @"Chief_CertificateDeal" : @"bzj" ,
                          @"Chief_CertificateTransfer" : @"zjzczx" ,
                          @"Chief_BorrowSeal" : @"jyz" ,
                          @"Chief_ReturnSeal" : @"hyz" ,
                          @"Chief_UseSeal" : @"yysq" ,
                          @"Chief_CarveSeal" : @"kyz" ,
                          @"Chief_PerformanceApply" : @"jyj" ,
                          @"Chief_PerformanceReturn" : @"hyj" ,
                          @"Personnel_UseCar" : @"ycsq" ,
                          @"Chief_PublicDoc" : @"tzfw" ,
                          @"Other_Placard" : @"ggl" ,
                          @"Chief_Certificate" : @"zjk" ,
                          @"Chief_SealStore" : @"yzk" ,
                          @"Chief_Performance" : @"yjk" ,
                          @"Chief_DestorySeal" : @"yzzx" ,
                          @"Chief_CommonStore" : @"wzk",
                          @"Chief_BorrowMaterial" : @"jwz",
                          @"Chief_ReturnMaterial" : @"hwz",
                          @"Project_BidNotice" : @"tyxm",
                          
                          //============== 人事管理 =============
                          @"Personnel_Leave" : @"qjt" ,
                          @"Personnel_BdApply" : @"bdt" ,
                          @"Personnel_GoOut" : @"wcbs" ,
                          @"Personnel_SalaryApply" : @"gzd" ,
                          @"Personnel_PayrollApply" : @"gzt" ,
                          @"Personnel_OvertimeApply" : @"jbt" ,
                          @"Personnel_DaysoffApply" : @"txt" ,
                          @"Personnel_TravelApply" : @"cct" ,
                          @"Personnel_CaseRegister" : @"ajdj" ,
                          @"Chief_CertificateCost" : @"zjfy" ,
                          
                          //============== 个人管理 =============
                          @"Other_CaduitObject" : @"zdylc" ,
                          
                          //============== 日常办公 =============
                          @"Office_Kqdk" : @"kqdk" ,
                          @"Office_Qd" : @"qd" ,
                          @"Office_Gzbg" : @"gzbg" ,
                          @"Office_Gzrw" : @"gzrw"
                          };
    });
    
    if (jg_menus_dict[key] == nil) {
        
    }
    
    return jg_menus_dict[key];
}
@end
