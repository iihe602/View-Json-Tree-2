//
//  JsonDict.m
//  View Json Tree 2
//
//  Created by wangyongqi on 1/21/13.
//  Copyright (c) 2013 wyq. All rights reserved.
//

#import "JsonDict.h"

@implementation JsonDict
{
    NSDictionary *_dict;
}

-(JsonDict *)initWithObject:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        _dict = dict;
    }
    
    return self;
}

-(NSString *) displayTextAtIndex:(NSUInteger)index
{
    return _dict.allKeys[index];
}

-(id) objectAtIndex:(NSUInteger)index
{
    return _dict.allValues[index];
}

@end
