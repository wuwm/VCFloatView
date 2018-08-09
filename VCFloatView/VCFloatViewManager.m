//
//  VCFloatViewManager.m
//  VCFloatView
//
//  Created by Weiming Wu on 2018/8/9.
//  Copyright © 2018 Weiming Wu. All rights reserved.
//

#import "VCFloatViewManager.h"
#import "VCFloatView.h"
#import <UserNotifications/UserNotifications.h>

@interface VCFloatViewManager()

@property (nonatomic, strong) NSMutableArray<VCFloatView *> *viewQueue_HighPriority;
@property (nonatomic, strong) NSMutableArray<VCFloatView *> *viewQueue_LowPriority;
@property (nonatomic, strong) VCFloatView *currentFloatView;
@property (nonatomic, strong) UIView *backgroundView;

@end

@implementation VCFloatViewManager

-(instancetype)init
{
    if(self = [super init])
    {
        self.viewQueue_LowPriority  = [[NSMutableArray alloc] init];
        self.viewQueue_HighPriority = [[NSMutableArray alloc] init];
        self.currentFloatView = nil;
        self.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
        self.backgroundView.backgroundColor = [UIColor grayColor];
        self.backgroundView.alpha = 0.4;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onNotifyFloatViewDismiss) name:@"VCFloatViewDismiss" object:nil];
    }
    return self;
}

- (void)addFloatView:(VCFloatView *)floatView andPriority:(FloatViewPriority)floatViewPriority
{
    @synchronized(self)
    {
        switch (floatViewPriority)
        {
            case VCFloatViewPriorityLow:
                [self.viewQueue_LowPriority addObject:floatView];
                break;
            case VCFloatViewPriorityHigh:
                [self.viewQueue_HighPriority addObject:floatView];
                break;
            default:
                break;
        }
    }

}

- (void)onNotifyFloatViewDismiss
{
    [self.backgroundView removeFromSuperview];
}

- (void)showNextFloatViewOnView:(UIView *)view
{

}

-(void)showNextFloatViewOnView:(UIView *)view animated:(BOOL)animated
{
    CGPoint viewCenter = CGPointMake([[UIScreen mainScreen] bounds].size.width / 2.0f, [[UIScreen mainScreen] bounds].size.height / 2.0f);
    [view addSubview: self.backgroundView];
    VCFloatView *floatViewToShow = nil;
    if(self.viewQueue_HighPriority.count == 0)
    {
        //Use low priority queue
        floatViewToShow = [self.viewQueue_LowPriority firstObject];
        @synchronized(self)
        {
            [self.viewQueue_LowPriority removeObjectAtIndex:0];
        }
    }
    else
    {
        floatViewToShow = [self.viewQueue_HighPriority firstObject];
        @synchronized(self)
        {
            [self.viewQueue_HighPriority removeObjectAtIndex:0];
        }
    }
    self.currentFloatView = floatViewToShow;
    floatViewToShow.center = viewCenter;
    [view addSubview:floatViewToShow];
    if(animated)
    {
        floatViewToShow.transform = CGAffineTransformScale(CGAffineTransformIdentity, CGFLOAT_MIN, CGFLOAT_MIN);
        [UIView animateWithDuration:0.2
                         animations:^{
                             floatViewToShow.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.2, 1.2);
                         } completion:^(BOOL finished) {
                             floatViewToShow.transform = CGAffineTransformIdentity;
                         }];
    }
}

-(void)dissmissCurrentFloatView
{
    [self.currentFloatView dismissAnimated:YES];
}


































@end
