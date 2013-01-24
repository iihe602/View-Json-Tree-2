//
//  MasterViewController.m
//  View Json as Master Detail TableView
//
//  Created by wangyongqi on 1/21/13.
//  Copyright (c) 2013 wyq. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"
#import "MyCell.h"
#import "JsonArray.h"
#import "JsonDict.h"
#import "JsonValue.h"

#import "JsonObjectTypes.h"

#define CellIdentifier @"Cell"

@interface MasterViewController () {
    
}
@end

@implementation MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

-(void)processJsonObject:(id) obj atIndex:(NSInteger)index DictionaryObjectUsingBlock:(void (^)(id key, id value))dictionaryHandler ArrayObjectUsingBlock:(void (^)(id value))arrayHandler valueUsingBlock:(void(^)(id value))valueHandler NS_AVAILABLE(10_6, 4_0)
{
    if ([obj isKindOfClass:[NSDictionary class]])
    {
        NSString *key = [obj allKeys][index];
        id obj2 = [obj objectForKey:key];

        dictionaryHandler(key, obj2);
    }
    else if ([obj isKindOfClass:[NSArray class]])
    {
        arrayHandler(obj[index]);
    }
    else
    {
        valueHandler(obj);
    }
    
}

-(void)testJsonObject:(id) obj DictionaryObjectUsingBlock:(void (^)())dictionaryHandler ArrayObjectUsingBlock:(void (^)())arrayHandler valueUsingBlock:(void(^)())valueHandler NS_AVAILABLE(10_6, 4_0)
{
    if ([obj isKindOfClass:[NSDictionary class]])
    {
        dictionaryHandler();
    }
    else if ([obj isKindOfClass:[NSArray class]])
    {
        arrayHandler();
    }
    else
    {
        valueHandler();
    }

}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    if (!_obj)
    {
        NSError *error = NULL;
        _obj = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"]]
                                               options:NSJSONReadingAllowFragments
                                                 error:&error];
        if (error) {
            NSLog(@"Error: %@\n", [error description]);
        }
        
        self.title = @"root";
    }

    NSLog(@"%@\n", [_obj description]);
    
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_obj count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    __block id<JsonDelegate> delegate = NULL;
    
    [self processJsonObject:_obj atIndex:indexPath.row DictionaryObjectUsingBlock:^(id key, id value)
    {
        [self testJsonObject:value DictionaryObjectUsingBlock:^() {
            delegate = [[JsonDict alloc] initWithKey:key andValue:value];
        } ArrayObjectUsingBlock:^() {
            delegate = [[JsonArray alloc] initWithArray:value andKey:key];
        } valueUsingBlock:^() {
            delegate = [[JsonValue alloc] initWithKey:key andValue:value];
        }];

    } ArrayObjectUsingBlock:^(id value) {
        [self testJsonObject:value DictionaryObjectUsingBlock:^() {
            id key = [NSString stringWithFormat:@"%d of %@", indexPath.row + 1, self.title];
            delegate = [[JsonDict alloc] initWithKey:key andValue:value];
        } ArrayObjectUsingBlock:^() {
            id key = [NSString stringWithFormat:@"%d of %@", indexPath.row + 1, self.title];
            delegate = [[JsonArray alloc] initWithArray:key andKey:value];
        } valueUsingBlock:^(){
            delegate = [[JsonValue alloc] initWithKey:value andValue:nil];
        }];
    } valueUsingBlock:^(id value){
        
    }];
    
    cell.delegate = delegate;
    cell.textLabel.text = [delegate key];
    cell.detailTextLabel.text = [delegate detailText];
    
    if (delegate) {
        switch ([delegate checkValueType]) {
            case Dictionary:
            case Array:
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                break;
                
            default:
                cell.accessoryType = UITableViewCellAccessoryNone;
                break;
        }
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }

    return cell;
}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyCell *cell = (MyCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    if ([cell.delegate checkValueType] == Value) {
        return nil;
    }
    else
        return indexPath;

}

-(MasterViewController *)prepareForChild:(id)obj title:(NSString *) title
{
    //从storyboard实例化ViewController，必须使用instantiateViewControllerWithIdentifier方法，否则，创建出来的对象并不是设计器改过属性的ViewController
    MasterViewController *mvc = [self.storyboard instantiateViewControllerWithIdentifier:@"MVC"];
    [mvc setObj:obj];
    [mvc setTitle:title];
    
    return mvc;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MasterViewController *mvc = NULL;
    
    MyCell *cell = (MyCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    mvc = [self prepareForChild:[cell.delegate value] title:[cell.delegate key]];
        
    if (mvc) {
        [self.navigationController pushViewController:mvc animated:YES];
    }
    
}

@end
