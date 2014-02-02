//
//  FirstTVC.m
//  爆巨500强
//
//  Created by Manted on 2/02/2014.
//  Copyright (c) 2014 Ye Hua. All rights reserved.
//

#import "FirstTVC.h"

@interface FirstTVC ()

@property (nonatomic, strong) NSDictionary *allData;

@end

@implementation FirstTVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    NSArray *cells = [self.tableView visibleCells];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    NSLog(@"tag = %d",cell.tag);
    NSLog(@"count = %i",[cells count]);
    for (UITableViewCell *aCell in cells) {
        NSArray *monthData = [self getDataOfMonth:[aCell tag]];
        int numberOfMessages = [self countMessagesOfMonthArray:monthData];
//        aCell.text = [NSString stringWithFormat:@"%d个段子",numberOfMessages];
        NSLog(@"111");
    }
}

- (int)countMessagesOfMonthArray:(NSArray*)monthArray
{
    int count = 0;
    for (NSDictionary *aDay in monthArray) {
        NSArray *content = [aDay objectForKey:@"content"];
        for (NSDictionary *msg in content) {
            count++;
        }
    }
    return count;
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 5;
            break;
        case 1:
            return 6;
            break;
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"monthCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    int monthKey = 0;
    switch (indexPath.section) {
        case 0:
            monthKey = 8 + indexPath.row;
            break;
        case 1:
            monthKey = 1 + indexPath.row;
            break;
        default:
            break;
    }
    NSString *monthString = [NSString stringWithFormat:@"%d",monthKey];
    NSArray *monthArray = [self.allData objectForKey:monthString];
    cell.textLabel.text = [NSString stringWithFormat:@"%@月",monthString];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d个段子",[self countMessagesOfMonthArray:monthArray]];
    
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"2007年";
    } else {
        return @"2008年";
    }
}

@end
