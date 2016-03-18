//
//  HJPickView.m
//  JJMusic
//
//  Created by coco on 16/3/18.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "HJPickView.h"

#define ComponentFirst 0
#define ComponentSecond 1

@interface HJPickView ()<UIPickerViewDataSource, UIPickerViewDelegate>
HJpropertyStrong(UIToolbar *toolBar);
HJpropertyStrong(UIPickerView *pickView);
HJpropertyCopy(void (^cancel)(void));
HJpropertyCopy(void (^done)(NSString *));
HJpropertyStrong(NSDictionary *dict);  //字典
HJpropertyStrong(NSArray *allKeyArray);  //键数组
HJpropertyStrong(NSArray *valuesArray);  //值数组
HJpropertyCopy(NSString *selectValue);
@end

@implementation HJPickView
- (instancetype)initWithFrame:(CGRect)frame cancel:(void (^)(void))cancel done:(void (^)(NSString *))done dict:(NSDictionary *)dict{
    self = [super initWithFrame:frame];
    if (self) {
        _cancel = cancel;
        _done = done;
        _dict = dict;
        _allKeyArray = [dict allKeys];
        _valuesArray = dict[_allKeyArray[0]];
        [self initSubView];
    }
    return self;
}
- (void)initSubView {
    self.toolBar = [[UIToolbar alloc] init];
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:(UIBarButtonItemStylePlain) target:self action:@selector(selectCancel)];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemFlexibleSpace) target:nil action:nil];
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:(UIBarButtonItemStylePlain) target:self action:@selector(selectDone)];
    self.toolBar.items = @[cancel, space, done];
    [self addSubview:self.toolBar];
    
    
    self.pickView = [[UIPickerView alloc] init];
    self.pickView.delegate = self;
    self.pickView.dataSource = self;
    self.pickView.showsSelectionIndicator = YES;
    self.pickView.backgroundColor = [UIColor whiteColor];
    [self.pickView selectRow: 0 inComponent: 0 animated: YES];

    [self addSubview:self.pickView];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.toolBar.frame = CGRectMake(0, 0, self.width, 44);
    self.pickView.frame = CGRectMake(0, self.toolBar.bottom, self.width, self.height - self.toolBar.height);
}
#pragma mark - UIPickerViewDataSource 和 UIPickerViewDelegate
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}
// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return component == ComponentFirst ? _allKeyArray.count : _valuesArray.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == ComponentFirst) {
        return _allKeyArray[row];
    } else if (component == ComponentSecond) {
        return _valuesArray[row];
    }
    return nil;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == ComponentFirst) {
        //选择了第一列,刷新第二列
        _valuesArray = _dict[_allKeyArray[row]];
        [self.pickView reloadComponent:ComponentSecond];
        [self.pickView selectRow:0 inComponent:ComponentSecond animated:YES];
    }
}

- (void)selectDone {
    NSInteger second = [self.pickView selectedRowInComponent:ComponentSecond];
    NSString *title = _valuesArray[second];
    if (self.done) {
        self.done(title);
    }
    [self selectCancel];
}
- (void)selectCancel {
    [UIView animateWithDuration:0.3 animations:^{
        self.Y = KMainScreenHeight;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
- (void)showInView:(UIView *)view {
    self.frame = CGRectMake(0, view.height, view.width, view.height * 0.4);
    [view addSubview:self];
    [view bringSubviewToFront:self];
    [UIView animateWithDuration:0.3 animations:^{
        self.Y = view.height * 0.6;
    }];
}
@end
