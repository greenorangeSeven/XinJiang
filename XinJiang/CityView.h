//
//  ArticleView.h
//  NanNIng
//
//  Created by Seven on 14-9-3.
//  Copyright (c) 2014年 greenorange. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGFocusImageFrame.h"
#import "SGFocusImageItem.h"
#import "TQImageCache.h"
#import "Article.h"
#import "CityCell.h"
#import "CityDetailView.h"
#import "ADVDetailView.h"

@interface CityView : UIViewController<UITableViewDataSource,UITableViewDelegate,EGORefreshTableHeaderDelegate,MBProgressHUDDelegate,IconDownloaderDelegate,SGFocusImageFrameDelegate>
{
    NSMutableArray *cityArray;
    BOOL isLoading;
    BOOL isLoadOver;
    int allCount;
    
    //下拉刷新
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
    
    BOOL isInitialize;
    TQImageCache * _iconCache;
    
    UIWebView *phoneCallWebView;
    
    MBProgressHUD *hud;
    
    NSMutableArray *advDatas;
    SGFocusImageFrame *bannerView;
    int advIndex;
}

@property (weak, nonatomic) IBOutlet UIImageView *advIv;

@property (weak, nonatomic) NSString *advId;
@property (weak, nonatomic) NSString *typeStr;
@property (weak, nonatomic) NSString *typeNameStr;

//异步加载图片专用
@property (nonatomic, retain) NSMutableDictionary *imageDownloadsInProgress;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
