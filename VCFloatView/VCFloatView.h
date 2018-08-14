//
//  VCFloatView.h
//  VCFloatView
//
//  Created by Weiming Wu on 2018/8/9.
//  Copyright © 2018 Weiming Wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VCFloatViewDelegate.h"

typedef void (^VCFloatViewDismissBlk) (void);

@interface VCFloatView : UIView 

@property (nonatomic, assign) CGRect closeButtonRect;
@property (nonatomic, weak) id<VCFloatViewDelegate> delegate;
@property (nonatomic, strong) NSString *identifier;

- (instancetype)initWithFrame: (CGRect)frame andIdentifier: (NSString *)identifier;

- (instancetype)initWithFrame: (CGRect)frame andIdentifier:(NSString *)identifier andPageViews: (NSMutableArray<UIView *> *)pageViews;

- (void)addPageView: (UIView *)pageView;

- (void)addOtherSubview: (UIView *)otherView;

- (void)changeCloseButtonPosition: (CGRect)newRect;

- (void)reloadPageViews;

- (void)dismissAnimated: (BOOL)animated;

@end
