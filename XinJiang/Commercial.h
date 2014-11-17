//
//  Commercial.h
//  NanNIng
//
//  Created by Seven on 14-9-5.
//  Copyright (c) 2014年 greenorange. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Commercial : NSObject

@property (nonatomic, retain) NSString *id;
@property (nonatomic, retain) NSString *cid;
@property (nonatomic, retain) NSArray *thumb;
@property (nonatomic, retain) NSString *content;
@property (nonatomic, retain) NSString *tel;
@property (nonatomic, retain) NSString *addtime;
@property (nonatomic, retain) NSString *customer_id;
@property (nonatomic, retain) NSString *status;
@property (nonatomic, retain) NSString *comm_name;
@property (nonatomic, retain) NSString *hits;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *price;

@property int contentHeight;

@property (retain,nonatomic) UIImage * imgData;
@property (nonatomic, retain) NSString *timeStr;

@end
