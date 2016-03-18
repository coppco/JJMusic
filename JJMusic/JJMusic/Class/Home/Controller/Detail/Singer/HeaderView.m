//
//  HeaderView.m
//  JJMusic
//
//  Created by coco on 16/3/11.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "HeaderView.h"

@interface HeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *tileL;
@property (weak, nonatomic) IBOutlet UIButton *downAndUpB;
@property (weak, nonatomic) IBOutlet UIButton *sameB;
@property (weak, nonatomic) IBOutlet UIButton *singleB;
@property (weak, nonatomic) IBOutlet UIButton *MVB;
@property (weak, nonatomic) IBOutlet UIButton *albumB;

@property (weak, nonatomic) IBOutlet UIView *lineLine;

@end

@implementation HeaderView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
- (void)awakeFromNib {
    
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.lineLine.width = 10;
    }
    return self;
}
//button方法
- (IBAction)changeButton:(UIButton *)sender {
    if (sender == self.downAndUpB) {
   
    }
    if (sender == self.sameB) {
   
    }
    if (sender == self.singleB) {

    }
    if (sender == self.albumB) {
    
        self.lineLine.X = 20;
    }
    if (sender == self.MVB) {
   
    }
}

@end
