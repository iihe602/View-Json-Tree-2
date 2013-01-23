//
//  JsonDelegate.h
//  View Json Tree 2
//
//  Created by wangyongqi on 1/21/13.
//  Copyright (c) 2013 wyq. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JsonDelegate <NSObject>

-(NSString *) displayTextAtIndex:(NSUInteger)index;

-(id) objectAtIndex:(NSUInteger)index;

@end
