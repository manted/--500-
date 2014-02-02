//
//  ViewController.m
//  爆巨500强
//
//  Created by Manted on 2/02/2014.
//  Copyright (c) 2014 Ye Hua. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSDictionary *allData;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self parseJSON];
}

- (NSDictionary*)allData
{
    if (!_allData) {
        NSString *path = [[NSBundle mainBundle]  pathForResource:@"500" ofType:@"json"];
        NSLog(@"path:%@",path);
        NSData *jdata = [[NSData alloc] initWithContentsOfFile:path ];
        NSLog(@"length:%d",[jdata length]);
        NSError *error = nil;
        //    NSData * Adata = [NSJSONSerialization JSONObjectWithData:jdata options:kNilOptions error:&error];
        
        _allData = [NSJSONSerialization JSONObjectWithData:jdata options:kNilOptions error:&error];
    }
    return _allData;
}

- (NSArray*)getDataOfMonth:(int)month
{
    NSString *monthString = [NSString stringWithFormat:@"%d", month];
    NSArray *monthData = [self.allData objectForKey:monthString];
    return monthData;
}

//- (NSArray*)getContentOfADate:(NSString*)date fromMonth:(NSArray*)monthData
//{
//    NSArray *content = [self getDataOfMonth:month]
//}

- (void)parseJSON
{
    NSString *path = [[NSBundle mainBundle]  pathForResource:@"500" ofType:@"json"];
    NSLog(@"path:%@",path);
    NSData *jdata = [[NSData alloc] initWithContentsOfFile:path ];
    NSLog(@"length:%d",[jdata length]);
    NSError *error = nil;
    
    NSDictionary* allData = [NSJSONSerialization JSONObjectWithData:jdata options:kNilOptions error:&error];
    NSArray *jan = [allData objectForKey:@"1"];
    
    NSDictionary* janCon = [jan objectAtIndex:0];
    NSString *date = [janCon objectForKey:@"date"];
    NSLog(@"%@",date);
    NSArray *content = [janCon objectForKey:@"content"];
    int count = 1;
    for (NSDictionary *dic in content) {
        NSString *msg = [dic objectForKey:@"msg"];
        NSLog(@"%i: %@",count,msg);
        count++;
    }
}

@end
