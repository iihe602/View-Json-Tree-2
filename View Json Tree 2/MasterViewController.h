//
//  MasterViewController.h
//  View Json Tree 2
//
//  Created by wangyongqi on 1/21/13.
//  Copyright (c) 2013 wyq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MasterViewController : UITableViewController

@property (nonatomic, strong) id obj;
@property (nonatomic, copy) NSString *title;

//-(void)testUsingBlock:(void (^)(id key, id value))handler withArray:(NSDictionary *) dict NS_AVAILABLE(10_6, 4_0);

-(void)processJsonObject:(id) obj atIndex:(NSInteger)index DictionaryObjectUsingBlock:(void (^)(id key, id value))dictionaryHandler ArrayObjectUsingBlock:(void (^)(id value))arrayHandler valueUsingBlock:(void(^)(id value))valueHandler NS_AVAILABLE(10_6, 4_0);

-(void)testJsonObject:(id) obj DictionaryObjectUsingBlock:(void (^)())dictionaryHandler ArrayObjectUsingBlock:(void (^)())arrayHandler valueUsingBlock:(void(^)())valueHandler NS_AVAILABLE(10_6, 4_0);

@end
