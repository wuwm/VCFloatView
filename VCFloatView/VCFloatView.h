//
//  VCFloatView.h
//  VCFloatView
//
//  Created by Weiming Wu on 2018/8/14.
//  Copyright © 2018 Weiming Wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VCFloatViewDelegate.h"

@interface VCFloatView : NSObject

@property(nonatomic, weak) id<VCFloatViewDelegate> delegate;

+ (void)FloatViewWithViews: (NSArray<UIView *> *)pageViews;

- (void)showFloatViewOn: (UIView *)view;

- (void)showFloatViewOnKeyWindow;

- (void)dissmiss;

@end
