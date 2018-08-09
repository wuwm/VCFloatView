//
//  VCFloatView.h
//  VCFloatView
//
//  Created by Weiming Wu on 2018/8/9.
//  Copyright © 2018 Weiming Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^VCFloatViewDismissBlk) (void);

@interface VCFloatView : UIView

@property (nonatomic, strong) UIView *backgroudView;
@property (nonatomic, copy) VCFloatViewDismissBlk dismissBlk;

- (instancetype)initWithFrame:(CGRect)frame andDismissBlock: (VCFloatViewDismissBlk) blk;

- (void)addPageView: (UIView *)pageView;

- (void)reloadPageViews;

- (void)dismissAnimated: (BOOL)animated;

@end
