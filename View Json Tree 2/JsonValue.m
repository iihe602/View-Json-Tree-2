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

-(JsonValue *)initWithKey:(NSString *)key Value:(id)value
{
    self = [super init];
    if (self) {
        _key = key;
        _value = value;
    }
    
    return self;
}

-(NSString *) displayTextAtIndex:(NSUInteger)index
{
    return _key;
}

-(id) objectAtIndex:(NSUInteger)index
{
    return _value;
}

@end
