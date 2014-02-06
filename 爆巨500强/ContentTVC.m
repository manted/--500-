//
//  ContentTVC.m
//  爆巨500强
//
//  Created by Manted on 3/02/2014.
//  Copyright (c) 2014 Ye Hua. All rights reserved.
//

#import "ContentTVC.h"
#import "DetailViewController.h"

@interface ContentTVC ()

@end

@implementation ContentTVC

-(NSArray*)contentArray
{
    if (!_contentArray) {
        _contentArray = [[NSArray alloc]init];
    }
    return _contentArray;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.contentArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[self.contentArray objectAtIndex:section]objectForKey:@"content"]count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"contentCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    NSString *msg = [[[[self.contentArray objectAtIndex:indexPath.section]objectForKey:@"content"]
                      objectAtIndex:indexPath.row]objectForKey:@"msg"];
    cell.textLabel.text = [NSString stringWithFormat:@"%d",indexPath.row + 1];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",msg];
    cell.tag = indexPath.section * 100 + indexPath.row;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[self.contentArray objectAtIndex:section]objectForKey:@"date"];
}

#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"detail"]) {
        if ([sender isKindOfClass:[UITableViewCell class]]) {
            UITableViewCell *cell = (UITableViewCell*)sender;
            DetailViewController *detailVC = (DetailViewController*)segue.destinationViewController;
            
            int dateIndex = cell.tag / 100;
            int messageIndex = cell.tag % 100;
            self.day = [[self.contentArray objectAtIndex:dateIndex]objectForKey:@"date"];
            detailVC.date = self.day;
            detailVC.year = self.year;
            detailVC.monthArray = self.contentArray;
            detailVC.dateIndex = dateIndex;
            detailVC.messageIndex = messageIndex;
            
//            detailVC.delegate = detailVC; //wx delegate
        }
    }
}

@end
