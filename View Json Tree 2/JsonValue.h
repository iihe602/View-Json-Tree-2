//
//  JsonValue.h
//  View Json Tree 2
//
//  Created by wangyongqi on 1/21/13.
//  Copyright (c) 2013 wyq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JsonDelegate.h"

@interface JsonValue : NSObject<JsonDelegate>

-(id) key;
-(id) value;
-(id) detailText;

-(JsonObjectTypes) checkValueType;


-(id)initWithKey:(id)key andValue:(id)value;

@end
