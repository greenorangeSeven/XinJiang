//
//  LifePageView.h
//  BeautyLife
//
//  Created by Seven on 14-7-30.
//  Copyright (c) 2014年 Seven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGFocusImageFrame.h"
#import "SGFocusImageItem.h"
#import "ArticleView.h"
#import "ADVDetailView.h"

@interface LifePageView : UIViewController<SGFocusImageFrameDelegate, UIActionSheetDelegate>
{
    UIWebView *phoneCallWebView;
    NSMutableArray *advDatas;
    SGFocusImageFrame *bannerView;
    int advIndex;
}

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UILabel *telBg;
@property (weak, nonatomic) IBOutlet UIImageView *advIv;

- (IBAction)clickService:(UIButton *)sender;
- (IBAction)clickRecharge:(UIButton *)sender;
- (IBAction)clickSubtle:(UIButton *)sender;
- (IBAction)clickBusiness:(UIButton *)sender;

- (IBAction)clickCommunity:(UIButton *)sender;
- (IBAction)clickBBS:(id)sender;
- (IBAction)telAction:(id)sender;

@end
