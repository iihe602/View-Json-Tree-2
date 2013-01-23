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

-(NSString *) displayTextAtIndex:(NSUInteger)index;

-(id) objectAtIndex:(NSUInteger)index;

-(JsonValue *)initWithKey:(NSString *)key Value:(id)value;

@end
