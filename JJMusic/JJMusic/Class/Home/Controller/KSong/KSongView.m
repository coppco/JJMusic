//
//  KSongView.m
//  JJMusic
//
//  Created by coco on 16/2/19.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "KSongView.h"
#import "KPeople.h"
#import <UIImageView+WebCache.h>
@interface KSongView ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation KSongView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.tableView = [[UITableView alloc] initWithFrame:self.bounds style:(UITableViewStylePlain)];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.backgroundColor = ColorClear;
        [self addSubview:_tableView];
    }
    return self;
}
- (void)setArray:(NSArray *)array {
    _array = array;
    dispatch_async(dispatch_get_main_queue(), ^{
        [_tableView reloadData];
    });
}
#pragma mark - delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _array.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"cell"];
    }
    KPeople *people = _array[indexPath.row];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:people.picture_300_300] placeholderImage:IMAGE(@"placeHold")];
    cell.textLabel.text = STRFORMAT(@"%@-%@", people.song_title, people.artist_name);
    cell.detailTextLabel.text = STRFORMAT(@"%@收听", people.play_num);
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

@end
