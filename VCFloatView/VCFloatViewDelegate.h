//
//  VCFloatViewDelegate.h
//  VCFloatView
//
//  Created by Weiming Wu on 2018/8/14.
//  Copyright © 2018 Weiming Wu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol VCFloatViewDelegate <NSObject>

@optional
- (void)onClickedCloseButtonAtFloatView: (NSString *)floatViewIdentifier;
- (void)onClickedBackgroundAtFloatView: (NSString *)floatViewIdentifier;
- (void)onClickedPageViewAtFloatView: (NSString *)floatViewIdentifier AtIndex: (NSUInteger) index;

@end
