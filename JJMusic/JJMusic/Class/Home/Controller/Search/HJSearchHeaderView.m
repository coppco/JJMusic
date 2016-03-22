//
//  HJSearchHeaderView.m
//  JJMusic
//
//  Created by coco on 16/3/22.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "HJSearchHeaderView.h"

@interface HJSearchHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *totalL;
@property (weak, nonatomic) IBOutlet UIButton *clickB;

@end

@implementation HJSearchHeaderView
+ (instancetype)searchHeaderView {
    return [[[NSBundle mainBundle] loadNibNamed:@"HJSearchHeaderView" owner:nil options:nil] lastObject];
}
- (IBAction)clickB:(id)sender {
    if (self.clickBlock) {
        self.clickBlock(self.open);
    }
}
- (void)setArray:(NSArray *)array {
    _array = array;
    if (array.count == 0) {
        self.totalL.text = @"暂无结果";
    } else {
        self.totalL.text = STRFORMAT(@"%lu个结果", (unsigned long)self.array.count);
    }
}
- (void)setOpen:(SearchHeaderType)open {
    _open = open;
    switch (open) {
        case SearchHeaderTypeSong:
        {
            [self.clickB setTitle:@"搜索到的歌曲" forState:(UIControlStateNormal)];
        }
            break;
        case SearchHeaderTypeAlbum:
        {
            [self.clickB setTitle:@"搜索到的专辑" forState:(UIControlStateNormal)];
        }
            break;

        case SearchHeaderTypeArtist:
        {
            [self.clickB setTitle:@"搜索到的歌手" forState:(UIControlStateNormal)];
        }
            break;

    }
}
- (void)awakeFromNib {
    self.clickB.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
}
@end
