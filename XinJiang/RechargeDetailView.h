//
//  RechargeDetailView.h
//  BeautyLife
//
//  Created by Seven on 14-8-21.
//  Copyright (c) 2014年 Seven. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RechargeDetailView : UIViewController

@property (weak, nonatomic) NSString *titleStr;
@property (weak, nonatomic) NSString *urlStr;

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
