//
//  SingerView.m
//  JJMusic
//
//  Created by coco on 16/2/18.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "SingerView.h"
#import "SingerCell.h"

@interface SingerView ()<UITableViewDataSource, UITableViewDelegate>
HJpropertyStrong(NSDictionary *titleDic);
HJpropertyStrong(NSMutableArray *keyArray);
@end

@implementation SingerView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.titleDic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"singer.json" ofType:nil]];
        self.keyArray = [[_titleDic allKeys] sortedArrayUsingSelector:@selector(compare:)].mutableCopy;
        
        self.tableView = [[UITableView alloc] initWithFrame:self.bounds style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        [self addSubview:_tableView];
    }
    return self;
}
#pragma mark - delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 2 * ((ViewW(self) - 50) / 4 + 20) + 10 + 90;
    } else {
        return 40;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _keyArray.count + 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return ((NSArray *)_titleDic[_keyArray[section - 1]]).count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        SingerCell *singerCell = [tableView dequeueReusableCellWithIdentifier:@"SingerCell"];
        if (!singerCell) {
            singerCell = [[SingerCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"SingerCell"];
            singerCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        singerCell.array = _array;
        return singerCell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.textLabel.text = _titleDic[_keyArray[indexPath.section - 1]][indexPath.row];
        return cell;
    }
}
- (void)setArray:(NSArray *)array {
    _array = array;
    
    [_tableView reloadData];
}
@end
