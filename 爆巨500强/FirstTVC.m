//
//  FirstTVC.m
//  爆巨500强
//
//  Created by Manted on 2/02/2014.
//  Copyright (c) 2014 Ye Hua. All rights reserved.
//

#import "FirstTVC.h"
#import "ContentTVC.h"

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
//        NSLog(@"path:%@",path);
        NSData *jdata = [[NSData alloc] initWithContentsOfFile:path ];
//        NSLog(@"length:%d",[jdata length]);
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
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d条语录",[self countMessagesOfMonthArray:monthArray]];
    cell.tag = monthKey;
    
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"content"]) {
        if ([sender isKindOfClass:[UITableViewCell class]]) {
            UITableViewCell *cell = (UITableViewCell*)sender;
            ContentTVC *contentTVC = (ContentTVC*)segue.destinationViewController;
            contentTVC.contentArray = [self getDataOfMonth:cell.tag];
            contentTVC.navigationItem.title = [NSString stringWithFormat:@"%d月",cell.tag];
            if (cell.tag >=8 && cell.tag <= 12) {
                contentTVC.year = @"2007";
            }else{
                contentTVC.year = @"2008";
            }
        }
    }
}

@end
