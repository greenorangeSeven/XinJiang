//
//  ConvView.h
//  BeautyLife
//
//  Created by mac on 14-7-31.
//  Copyright (c) 2014年 Seven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
#import "Shop.h"
#import "EGOImageView.h"
#import "EGOImageButton.h"
#import "BusinessCateCell.h"
#import "ConvCell.h"
#import "ConvOrderView.h"
#import "BusniessSearchView.h"

@interface ConvView : UIViewController<UITableViewDelegate,UITableViewDataSource,BMKLocationServiceDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSMutableArray *shopData;
    NSMutableArray *shopCateData;
    BMKMapPoint myPoint;
    BMKLocationService* _locService;
    MBProgressHUD *hud;
    NSString *catid;
    UILabel *noDataLabel;
    CLLocationCoordinate2D mycoor;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UICollectionView *cateCollection;

@end
