//
//  MasterViewController.m
//  View Json as Master Detail TableView
//
//  Created by wangyongqi on 1/21/13.
//  Copyright (c) 2013 wyq. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"

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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    cell.detailTextLabel.text = @"";
    
    [self processJsonObject:_obj atIndex:indexPath.row DictionaryObjectUsingBlock:^(id key, id value)
    {
        cell.textLabel.text = key;
        [self testJsonObject:value DictionaryObjectUsingBlock:^() {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } ArrayObjectUsingBlock:^() {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } valueUsingBlock:^() {
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.detailTextLabel.text = [value description];
        }];
    } ArrayObjectUsingBlock:^(id value) {
        [self testJsonObject:value DictionaryObjectUsingBlock:^() {
            cell.textLabel.text = [NSString stringWithFormat:@"%d of %@", indexPath.row + 1, self.title];
        } ArrayObjectUsingBlock:^() {
            cell.textLabel.text = [NSString stringWithFormat:@"%d of %@", indexPath.row + 1, self.title];
        } valueUsingBlock:^(){
            cell.textLabel.text = [value description];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }];
    } valueUsingBlock:^(id value){
        
    }];
    
    return cell;
}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    __block NSIndexPath *result2 = indexPath;
    
    [self processJsonObject:_obj atIndex:indexPath.row DictionaryObjectUsingBlock:^(id key, id value) {
        [self testJsonObject:value DictionaryObjectUsingBlock:^() {

        } ArrayObjectUsingBlock:^() {
            
        } valueUsingBlock:^() {
            result2 = nil;
        }];
    } ArrayObjectUsingBlock:^(id value) {
        [self testJsonObject:value DictionaryObjectUsingBlock:^() {
            
        } ArrayObjectUsingBlock:^() {
            
        } valueUsingBlock:^() {
            result2 = nil;
        }];
    } valueUsingBlock:^(id value) {
        
    }];
    
    return result2;
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
    NSLog(@"============================================\n");
    
    __block MasterViewController *mvc = NULL;
    
    [self processJsonObject:_obj atIndex:indexPath.row DictionaryObjectUsingBlock:^(id key, id value) {
        [self testJsonObject:value DictionaryObjectUsingBlock:^() {
            mvc = [self prepareForChild:value title:key];
        } ArrayObjectUsingBlock:^() {
            mvc = [self prepareForChild:value title:key];
        } valueUsingBlock:^() {
            
        }];
    } ArrayObjectUsingBlock:^(id value) {
        [self testJsonObject:value DictionaryObjectUsingBlock:^() {
            mvc = [self prepareForChild:value title:[NSString stringWithFormat:@"%d of %@", indexPath.row + 1, self.title]];
        } ArrayObjectUsingBlock:^() {
            ;//this wany is impossible
        } valueUsingBlock:^() {
            mvc = [self prepareForChild:value title:@""];
        }];
    } valueUsingBlock:^(id value) {
        
    }];
    
    if (mvc) {
        [self.navigationController pushViewController:mvc animated:YES];
    }
    
}

@end
