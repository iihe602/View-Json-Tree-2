//
//  MyCell.h
//  View Json Tree 2
//
//  Created by wangyongqi on 1/23/13.
//  Copyright (c) 2013 wyq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JsonDelegate.h"

@interface MyCell : UITableViewCell

@property (nonatomic, strong) id<JsonDelegate> delegate;

@end
