//
//  LifePageView.m
//  BeautyLife
//
//  Created by Seven on 14-7-30.
//  Copyright (c) 2014年 Seven. All rights reserved.
//

#import "LifePageView.h"
#import "ConvView.h"
#import "RechargeView.h"
#import "SubtleView.h"
#import "BusinessView.h"
#import "CommunityView.h"
#import "ProjectCollectionView.h"

@interface LifePageView ()

@end

@implementation LifePageView

@synthesize scrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 44)];
        titleLabel.font = [UIFont boldSystemFontOfSize:18];
        titleLabel.text = @"智慧生活";
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = [Tool getColorForGreen];
        titleLabel.textAlignment = UITextAlignmentCenter;
        self.navigationItem.titleView = titleLabel;
        
//        UIButton *lBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 31, 28)];
//        [lBtn addTarget:self action:@selector(myAction) forControlEvents:UIControlEventTouchUpInside];
//        [lBtn setImage:[UIImage imageNamed:@"navi_my"] forState:UIControlStateNormal];
//        UIBarButtonItem *btnMy = [[UIBarButtonItem alloc]initWithCustomView:lBtn];
//        self.navigationItem.leftBarButtonItem = btnMy;
//        
//        UIButton *rBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 31, 28)];
//        [rBtn addTarget:self action:@selector(settingAction) forControlEvents:UIControlEventTouchUpInside];
//        [rBtn setImage:[UIImage imageNamed:@"navi_setting"] forState:UIControlStateNormal];
//        UIBarButtonItem *btnSetting = [[UIBarButtonItem alloc]initWithCustomView:rBtn];
//        self.navigationItem.rightBarButtonItem = btnSetting;
    }
    return self;
    
}

- (void)myAction
{
    [Tool pushToMyView:self.navigationController];
}

- (void)settingAction
{
    [Tool pushToSettingView:self.navigationController];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [Tool getBackgroundColor];
    scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width, self.view.frame.size.height);
    [Tool roundView:self.telBg andCornerRadius:3.0];
    [self initMainADV];
}

- (void)initMainADV
{
    //如果有网络连接
    if ([UserModel Instance].isNetworkRunning) {
        //        [Tool showHUD:@"数据加载" andView:self.view andHUD:hud];
        NSMutableString *tempUrl = [NSMutableString stringWithFormat:@"%@%@?APPKey=%@&spaceid=5", api_base_url, api_getadv2, appkey];
        NSString *cid = [[UserModel Instance] getUserValueForKey:@"cid"];
        if (cid != nil && [cid length] > 0) {
            [tempUrl appendString:[NSString stringWithFormat:@"&cid=%@", cid]];
        }
        NSString *url = [NSString stringWithString:tempUrl];
        [[AFOSCClient sharedClient]getPath:url parameters:Nil
                                   success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                       @try {
                                           advDatas = [Tool readJsonStrToADV2:operation.responseString];
                                           
                                           int length = [advDatas count];
                                           
                                           NSMutableArray *itemArray = [NSMutableArray arrayWithCapacity:length+2];
                                           if (length > 1)
                                           {
                                               Advertisement2 *adv = [advDatas objectAtIndex:length-1];
                                               SGFocusImageItem *item = [[SGFocusImageItem alloc] initWithTitle:@"" image:adv.pic tag:-1];
                                               [itemArray addObject:item];
                                           }
                                           for (int i = 0; i < length; i++)
                                           {
                                               Advertisement2 *adv = [advDatas objectAtIndex:i];
                                               SGFocusImageItem *item = [[SGFocusImageItem alloc] initWithTitle:@"" image:adv.pic tag:-1];
                                               [itemArray addObject:item];
                                               
                                           }
                                           //添加第一张图 用于循环
                                           if (length >1)
                                           {
                                               Advertisement2 *adv = [advDatas objectAtIndex:0];
                                               SGFocusImageItem *item = [[SGFocusImageItem alloc] initWithTitle:@"" image:adv.pic tag:-1];
                                               [itemArray addObject:item];
                                           }
                                           bannerView = [[SGFocusImageFrame alloc] initWithFrame:CGRectMake(0, 0, 320, 145) delegate:self imageItems:itemArray isAuto:NO];
                                           [bannerView scrollToIndex:0];
                                           [self.advIv addSubview:bannerView];
                                       }
                                       @catch (NSException *exception) {
                                           [NdUncaughtExceptionHandler TakeException:exception];
                                       }
                                       @finally {
                                           //                                           if (hud != nil) {
                                           //                                               [hud hide:YES];
                                           //                                           }
                                       }
                                   } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                       if ([UserModel Instance].isNetworkRunning == NO) {
                                           return;
                                       }
                                       if ([UserModel Instance].isNetworkRunning) {
                                           [Tool ToastNotification:@"错误 网络无连接" andView:self.view andLoading:NO andIsBottom:NO];
                                       }
                                   }];
    }
}

//顶部图片滑动点击委托协议实现事件
- (void)foucusImageFrame:(SGFocusImageFrame *)imageFrame didSelectItem:(SGFocusImageItem *)item
{
    Advertisement2 *adv = (Advertisement2 *)[advDatas objectAtIndex:advIndex];
    if (adv) {
        if ([adv.type_id isEqualToString:@"1"]) {
            ADVDetailView *advDetail = [[ADVDetailView alloc] init];
            advDetail.hidesBottomBarWhenPushed = YES;
            advDetail.adv = adv;
            [self.navigationController pushViewController:advDetail animated:YES];
        }
        else if ([adv.type_id isEqualToString:@"2"])
        {
            GoodsDetailView *goodsDetail = [[GoodsDetailView alloc] init];
            goodsDetail.goodId = adv.toid;
            goodsDetail.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:goodsDetail animated:YES];
        }
        else if ([adv.type_id isEqualToString:@"3"])
        {
            [self pushViewToShopDetail:adv.toid];
        }
    }
}

- (void)pushViewToShopDetail:(NSString *)shopId
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@?APPKey=%@&id=%@", api_base_url, api_shopinfo, appkey, shopId];
    NSURL *url = [ NSURL URLWithString : urlStr];
    // 构造 ASIHTTPRequest 对象
    ASIHTTPRequest *request = [ ASIHTTPRequest requestWithURL :url];
    // 开始同步请求
    [request startSynchronous ];
    NSError *error = [request error ];
    assert (!error);
    // 如果请求成功，返回 Response
    NSString *response = [request responseString ];
    Shop *shop = [Tool readJsonStrToShopinfo:response];
    BusinessDetailView *businessDetailView = [[BusinessDetailView alloc] init];
    businessDetailView.shop = shop;
    businessDetailView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:businessDetailView animated:YES];
}

//顶部图片自动滑动委托协议实现事件
- (void)foucusImageFrame:(SGFocusImageFrame *)imageFrame currentItem:(int)index;
{
    //    NSLog(@"%s \n scrollToIndex===>%d",__FUNCTION__,index);
    advIndex = index;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    bannerView.delegate = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    bannerView.delegate = self;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (IBAction)clickService:(UIButton *)sender
{
    ConvView *convView = [[ConvView alloc] init];
    convView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:convView animated:YES];
}

- (IBAction)clickRecharge:(UIButton *)sender
{
    RechargeView *rechargeView = [[RechargeView alloc] init];
    rechargeView.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:rechargeView animated:YES];
}

- (IBAction)clickSubtle:(UIButton *)sender
{
    SubtleView *subtleView = [[SubtleView alloc] init];
    subtleView.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:subtleView animated:YES];
}

- (IBAction)clickBusiness:(UIButton *)sender
{
    BusinessView *businessView = [[BusinessView alloc] init];
    businessView.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:businessView animated:YES];
}

- (IBAction)clickCommunity:(UIButton *)sender
{
    CommunityView *communityView = [[CommunityView alloc] init];
    communityView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:communityView animated:YES];
}

- (IBAction)clickBBS:(id)sender {
    ProjectCollectionView *projectView = [[ProjectCollectionView alloc] init];
    projectView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:projectView animated:YES];
}

- (IBAction)telAction:(id)sender{
    NSURL *phoneUrl = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", servicephone]];
    if (!phoneCallWebView) {
        phoneCallWebView = [[UIWebView alloc] initWithFrame:CGRectZero];
    }
    [phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneUrl]];
}

@end
