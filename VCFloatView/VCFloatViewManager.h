//
//  VCFloatViewManager.h
//  VCFloatView
//
//  Created by Weiming Wu on 2018/8/9.
//  Copyright © 2018 Weiming Wu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VCFloatView;

typedef NS_ENUM(NSUInteger, FloatViewPriority)
{
    VCFloatViewPriorityLow,
    VCFloatViewPriorityHigh
};

@interface VCFloatViewManager : NSObject

- (void)showNextFloatViewOnView: (UIView *)view animated: (BOOL)animated;

- (void)addFloatView: (VCFloatView *)floatView andPriority: (FloatViewPriority) floatViewPriority;

- (void)dissmissCurrentFloatView;

@end
