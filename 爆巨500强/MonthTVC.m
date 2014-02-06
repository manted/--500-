//
//  MonthTVC.m
//  爆巨500强
//
//  Created by Manted on 2/02/2014.
//  Copyright (c) 2014 Ye Hua. All rights reserved.
//

#import "MonthTVC.h"
#import "DayTVC.h"

@interface MonthTVC ()

@end

@implementation MonthTVC

-(NSArray*)monthArray
{
    if (!_monthArray) {
        _monthArray = [[NSArray alloc]init];
    }
    return _monthArray;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.monthArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"dateCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    NSString *dateString = [[self.monthArray objectAtIndex:indexPath.row]objectForKey:@"date"];
    NSArray *contentArray = [[self.monthArray objectAtIndex:indexPath.row]objectForKey:@"content"];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",dateString];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d条语录",[self countMessagesOfContentArray:contentArray]];
    cell.tag = indexPath.row;
    
    return cell;
}

- (int)countMessagesOfContentArray:(NSArray*)contentArray
{
    return [contentArray count];
}

-(NSArray*)getContentOfIndex:(int)index
{
    return [[self.monthArray objectAtIndex:index]objectForKey:@"content"];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"day"]) {
        if ([sender isKindOfClass:[UITableViewCell class]]) {
            UITableViewCell *cell = (UITableViewCell*)sender;
            DayTVC *dayTVC = (DayTVC*)segue.destinationViewController;
            dayTVC.contentArray = [self getContentOfIndex:cell.tag];
            NSString *dateString = [[self.monthArray objectAtIndex:cell.tag]objectForKey:@"date"];
            dayTVC.navigationItem.title = dateString;
            dayTVC.year = self.year;
            dayTVC.day = dateString;
        }
    }
}

@end
