//
//  DayTVC.m
//  爆巨500强
//
//  Created by Manted on 2/02/2014.
//  Copyright (c) 2014 Ye Hua. All rights reserved.
//

#import "DayTVC.h"
#import "DetailViewController.h"

@interface DayTVC ()

@end

@implementation DayTVC

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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.contentArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"messageCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    NSString *msg = [[self.contentArray objectAtIndex:indexPath.row]objectForKey:@"msg"];
    cell.textLabel.text = [NSString stringWithFormat:@"%d",indexPath.row + 1];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",msg];
    cell.tag = indexPath.row;
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"detail"]) {
        if ([sender isKindOfClass:[UITableViewCell class]]) {
            UITableViewCell *cell = (UITableViewCell*)sender;
            DetailViewController *detailVC = (DetailViewController*)segue.destinationViewController;
//            detailVC.message = cell.detailTextLabel.text;
            detailVC.date = [NSString stringWithFormat:@"%@.%@",self.year,self.day];
//            detailVC.contentArray = self.contentArray;
            NSInteger index = cell.tag;
//            detailVC.index = index;
        }
    }
}

@end
