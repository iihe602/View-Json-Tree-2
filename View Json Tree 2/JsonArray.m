//
//  JsonArray.m
//  View Json Tree 2
//
//  Created by wangyongqi on 1/21/13.
//  Copyright (c) 2013 wyq. All rights reserved.
//

#import "JsonArray.h"

@implementation JsonArray
{
    NSString *_key;
    id _value;
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
    return NULL;
}

-(JsonObjectTypes) checkValueType
{
    return Array;
}

-(id)initWithArray:(NSArray *)array andKey:(NSString *)key
{
    self = [super init];
    if (self) {
        _key = key;
        _value = array;
    }
    
    return self;    
}


@end
