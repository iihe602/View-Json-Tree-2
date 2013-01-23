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
    NSArray *_array;
    NSString *_key;
}

-(JsonArray *)initWithArray:(NSArray *) array andKey:(NSString *)key
{
    self = [super init];
    if (self) {
        _array = array;
        _key = key;
    }
    return self;
}

-(NSString *) displayTextAtIndex:(NSUInteger)index
{
    return [NSString stringWithFormat:@"%d of %@", index, _key];
}

-(id) objectAtIndex:(NSUInteger)index
{
    return _array[index];
}

@end
