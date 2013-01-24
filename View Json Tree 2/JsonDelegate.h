//
//  JsonDelegate.h
//  View Json Tree 2
//
//  Created by wangyongqi on 1/21/13.
//  Copyright (c) 2013 wyq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JsonObjectTypes.h"

@protocol JsonDelegate <NSObject>

-(id) key;
-(id) value;
-(id) detailText;

-(JsonObjectTypes) checkValueType;

@end

//enum JsonObjects
//{
//    DICTIONARY, ARRAY, VALUE
//}
