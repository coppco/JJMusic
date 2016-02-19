//
//  RadioView.h
//  JJMusic
//
//  Created by coco on 16/2/18.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RadioView : UIView
HJpropertyAssign(BOOL isLoad);  //
HJpropertyStrong(UICollectionView *collectionView);
HJpropertyStrong(NSArray *redRadioArray);
HJpropertyStrong(NSArray *leBoArray);
@end
