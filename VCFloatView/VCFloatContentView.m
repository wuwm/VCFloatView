//
//  VCFloatView.m
//  VCFloatView
//
//  Created by Weiming Wu on 2018/8/9.
//  Copyright © 2018 Weiming Wu. All rights reserved.
//

#import "VCFloatContentView.h"
#import <UserNotifications/UserNotifications.h>

@interface VCFloatContentView()<UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray<UIView *> *pageViews;
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSNumber *currentPage;

@end

@implementation VCFloatContentView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.pageViews = [[NSMutableArray<UIView *> alloc] init];
        self.currentPage = 0;
        [self addScrollView];
        [self addPageControl];
        [self addObserver:self forKeyPath:@"currentPage" options: NSKeyValueObservingOptionNew context:nil];
        self.closeButtonRect = CGRectMake(self.frame.size.width - 15, -15, 30, 30);
        [self addCloseButton];
        self.identifier = @"ID NOT SET.";
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
    self.closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.closeButton setBackgroundImage:[UIImage imageNamed:@"close.png"] forState:(UIControlStateNormal)];
    [self.closeButton addTarget:self action:@selector(dismissFromButton) forControlEvents: UIControlEventTouchUpInside];
    [self addSubview: self.closeButton];
}

- (void)addPageControl
{
    self.pageControl = [[UIPageControl alloc] init];
    self.pageControl.numberOfPages = self.pageViews.count;
    self.pageControl.currentPage = [self.currentPage unsignedIntegerValue];
    self.pageControl.pageIndicatorTintColor = [[UIColor blackColor] colorWithAlphaComponent: 0.1];
    self.pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:0.192 green:0.761 blue:0.486 alpha:1];
    [self addSubview: self.pageControl];
}

- (void)addScrollView
{
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.center = self.center;
    self.scrollView.contentSize = CGSizeMake(self.pageViews.count * self.frame.size.width, self.frame.size.height);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.bounces = NO;
    self.scrollView.delegate = self;
    self.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
    [self addSubview: self.scrollView];
}

- (void)addPageViewsToScrollView
{
    for(int idx = 0; idx < self.pageViews.count; ++idx)
    {
        [self.scrollView addSubview: self.pageViews[idx]];
    }
}

- (void)reloadPageViews
{
    for(UIView *pageView in [self.scrollView subviews])
    {
        [pageView removeFromSuperview];
    }
    self.scrollView.contentSize = CGSizeMake(self.pageViews.count * self.frame.size.width, self.frame.size.height);
    [self addPageViewsToScrollView];
    self.pageControl.numberOfPages = self.pageViews.count;
    if(self.pageViews.count < 2)
    {
        self.pageControl.hidden = YES;
    }
}

- (void)addPageView:(UIView *)pageView
{
    [self.pageViews addObject: pageView];
}

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

- (void)dismissFromButton
{
    [self dismissAnimated:YES];
    if(self.delegate != nil)
    {
        [self.delegate onClickedBackgroundAtFloatView: self.identifier];
    }
}


-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSUInteger currentPage = 0;
    CGFloat currentPage_temp = scrollView.contentOffset.x / self.scrollView.bounds.size.width;
    CGPoint translatedPoint = [scrollView.panGestureRecognizer translationInView:scrollView];
    if(translatedPoint.x < 0)
    {
        if((currentPage_temp - floor(currentPage_temp)) > 0.2)
        {
            currentPage = ceil(currentPage_temp);
        }else{
            currentPage = floor(currentPage_temp);
        }
    }
    if(translatedPoint.x > 0)
    {
        if((ceil(currentPage_temp) - currentPage_temp) > 0.2)
        {
            currentPage = floor(currentPage_temp);
        }else{
            currentPage = ceil(currentPage_temp);
        }
    }
    
    self.currentPage = [NSNumber numberWithUnsignedInteger:currentPage];
    [scrollView setContentOffset:CGPointMake(self.scrollView.bounds.size.width * currentPage, 0) animated:YES];
}

-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    NSUInteger currentPage = 0;
    CGFloat currentPage_temp = scrollView.contentOffset.x / self.scrollView.bounds.size.width;
    CGPoint translatedPoint = [scrollView.panGestureRecognizer translationInView:scrollView];
    if(translatedPoint.x < 0)
    {
        if((currentPage_temp - floor(currentPage_temp)) > 0.2)
        {
            currentPage = ceil(currentPage_temp);
        }else{
            currentPage = floor(currentPage_temp);
        }
    }
    if(translatedPoint.x > 0)
    {
        if((ceil(currentPage_temp) - currentPage_temp) > 0.2)
        {
            currentPage = floor(currentPage_temp);
        }else{
            currentPage = ceil(currentPage_temp);
        }
    }
    
    self.currentPage = [NSNumber numberWithUnsignedInteger:currentPage];
    [scrollView setContentOffset:CGPointMake(self.scrollView.bounds.size.width * currentPage, 0) animated:YES];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    NSNumber *curPage = [change objectForKey:NSKeyValueChangeNewKey];
    self.pageControl.currentPage = [curPage integerValue];
}

@end
