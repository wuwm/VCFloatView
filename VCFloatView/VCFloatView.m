//
//  VCFloatView.m
//  VCFloatView
//
//  Created by Weiming Wu on 2018/8/9.
//  Copyright © 2018 Weiming Wu. All rights reserved.
//

#import "VCFloatView.h"

@interface VCFloatView()

@property (nonatomic, strong) NSMutableArray<UIView *> *pageViews;
@property (nonatomic, strong) UIButton *closeButton;

@end

@implementation VCFloatView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.pageViews = [[NSMutableArray<UIView *> alloc] init];
        
        self.closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.closeButton setBackgroundImage:[UIImage imageNamed:@"close.png"] forState:(UIControlStateNormal)];
        [self.closeButton addTarget:self action:@selector(dismissFromBtn) forControlEvents: UIControlEventTouchDown];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame andDismissBlock: (VCFloatViewDismissBlk) blk
{
    if(self = [self initWithFrame:frame])
    {
        self.dismissBlk = [blk copy];
    }
    return self;
}

- (void)reloadPageViews
{
    for(UIView *pageView in [self subviews])
    {
        [pageView removeFromSuperview];
    }
    [self addPageViewsToView];
    [self addSubview:self.closeButton];
}

- (void)addPageView:(UIView *)pageView
{
    [self.pageViews addObject: pageView];
}

- (void)addPageViewsToView
{
    for(UIView *view in self.pageViews)
    {
        [self addSubview:view];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.closeButton.frame = CGRectMake(self.bounds.size.width - 15, -15, 30, 30);
}

-(void)dismiss
{
    [self removeFromSuperview];
}

- (void)dismissFromBtn
{
    if(self.dismissBlk != nil)
    {
        self.dismissBlk();
    }
    [self dismiss];
}
@end
