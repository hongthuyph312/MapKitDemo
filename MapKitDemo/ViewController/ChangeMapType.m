//
//  ChangeMapType.m
//  MapKitDemo
//
//  Created by Thuy Phan on 9/23/16.
//  Copyright © 2016 themask. All rights reserved.
//

#import "ChangeMapType.h"

@implementation ChangeMapType{
    NSMutableArray *arrType;
}

- (id)initWithClickBlock:(ChangeMapTypeBlock)block{
    self = [super init];
    if (self) {
        _blockChangeType = block;
        _gTableView.dataSource = self;
        _gTableView.delegate = self;
        arrType = [[NSMutableArray alloc] initWithObjects:@"Standard",@"Statellite",@"Hybrid", nil];
        _gTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [_gTableView reloadData];
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arrType.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *strIdentifier = @"typeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strIdentifier];
    }
    cell.textLabel.text = [arrType objectAtIndex:indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _blockChangeType(indexPath.row);
}


@end
