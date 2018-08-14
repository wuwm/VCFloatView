//
//  VCFloatView.m
//  VCFloatView
//
//  Created by Weiming Wu on 2018/8/9.
//  Copyright © 2018 Weiming Wu. All rights reserved.
//

#import "VCFloatView.h"
#import <UserNotifications/UserNotifications.h>

@interface VCFloatView()

@property (nonatomic, strong) NSMutableArray<UIView *> *pageViews;
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation VCFloatView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.pageViews = [[NSMutableArray<UIView *> alloc] init];
        [self addCloseButton];
        [self addScrollView];
        [self addPageControl];
//        [self addPageViewsToScrollView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame andIdentifier:(NSString *)identifier
{
    if(self = [self initWithFrame:frame])
    {
        self.identifier = identifier;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame andIdentifier:(NSString *)identifier andPageViews:(NSMutableArray<UIView *> *)pageViews
{
    if(self = [self initWithFrame:frame andIdentifier:identifier])
    {
        self.pageViews = pageViews;
    }
    return self;
}

- (void)addCloseButton
{
    self.closeButton     = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.closeButton setBackgroundImage:[UIImage imageNamed:@"close.png"] forState:(UIControlStateNormal)];
    [self.closeButton addTarget:self action:@selector(dismissFromBtn) forControlEvents: UIControlEventTouchUpInside];
    [self addSubview: self.closeButton];
}

- (void)addPageControl
{
    self.pageControl = [[UIPageControl alloc] init];
    self.pageControl.numberOfPages = 3;
    self.pageControl.currentPage = 1;
//    self.pageControl.tintColor = [UIColor blackColor];
    self.pageControl.backgroundColor = [UIColor orangeColor];
    self.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    [self addSubview: self.pageControl];
}

- (void)addScrollView
{
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.center = self.center;
    self.scrollView.contentSize = CGSizeMake(self.pageViews.count * self.frame.size.width, self.frame.size.height);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.delegate = self;
    [self addSubview: self.scrollView];
}

- (void)addPageViewsToScrollView
{
    for(int idx = 0; idx < self.pageViews.count; ++idx)
    {
//        CGRect expectedFrame = CGRectMake(idx * self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height);
//        CGRect expectedFrame = CGRectMake(40, 0, self.bounds.size.width, self.bounds.size.height);
//        [self.pageViews[idx] setFrame: expectedFrame];
        [self.scrollView addSubview: self.pageViews[idx]];
    }
//    [self.scrollView addSubview: self.pageViews[0]];
//    [self.scrollView addSubview: self.pageViews[1]];
}

- (void)reloadPageViews
{
    for(UIView *pageView in [self.scrollView subviews])
    {
        [pageView removeFromSuperview];
    }
    self.scrollView.contentSize = CGSizeMake(self.pageViews.count * self.frame.size.width, self.frame.size.height);
    [self addPageViewsToScrollView];
}

- (void)addPageView:(UIView *)pageView
{
    [self.pageViews addObject: pageView];
}

//- (void)addPageViewsToView
//{
//    for(UIView *view in self.pageViews)
//    {
//        [self addSubview:view];
//    }
//}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.closeButton.frame = self.closeButtonRect;
    self.scrollView.frame  = self.bounds;
    [self.pageViews enumerateObjectsUsingBlock:^(UIView * _Nonnull pageView, NSUInteger idx, BOOL * _Nonnull stop)
     {
         CGRect expectedFrame = CGRectMake(self.bounds.size.width * idx, 0, self.bounds.size.width, self.bounds.size.height);
         [pageView setFrame: expectedFrame];
     }];
    
    [self.pageControl setFrame:CGRectMake(0, self.bounds.size.height - 30, self.bounds.size.width, 30)];
}

-(void)addOtherSubview:(UIView *)otherView
{
    [self addSubview: otherView];
    [self bringSubviewToFront: otherView];
}

-(void)changeCloseButtonPosition:(CGRect)newRect
{
    self.closeButtonRect = newRect;
    [self setNeedsDisplay];
}

-(void)dismissAnimated:(BOOL)animated
{
    if(animated)
    {
        [UIView animateWithDuration:0.2
                         animations:^{
                             self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.2, 1.2);
                         }
                         completion:^(BOOL finished) {
                             [UIView animateWithDuration:0.3 animations:^{
                                 self.transform = CGAffineTransformScale(CGAffineTransformIdentity, CGFLOAT_MIN, CGFLOAT_MIN);
                             } completion:^(BOOL finished) {
                                 [self removeFromSuperview];
                             }];
                         }];
    }
    else
    {
        [self removeFromSuperview];
    }
}

- (void)dismissFromBtn
{
    [self dismissAnimated:YES];
    [self.delegate onClickedBackgroundAtFloatView:@"DemoFloatView"];
}
@end
