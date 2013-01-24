//
//  JsonValue.m
//  View Json Tree 2
//
//  Created by wangyongqi on 1/21/13.
//  Copyright (c) 2013 wyq. All rights reserved.
//

#import "JsonValue.h"

@implementation JsonValue
{
    NSString *_key;
    NSString *_value;
}

-(id) key
{
    return [_key description];
}

-(id) value
{
    return _value;
}

-(id) detailText
{
    return [_value description];
}

-(JsonObjectTypes) checkValueType
{
    return Value;
}

-(id)initWithKey:(id)key andValue:(id)value
{
    self = [super init];
    if (self) {
        _key = key;
        _value = value;
    }
    
    return self;
}

@end
