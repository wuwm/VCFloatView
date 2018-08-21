//
//  QMRecognizingUserGuidePageView.m
//  QQMusic
//
//  Created by Weiming Wu on 2018/8/15.
//  Copyright © 2018 Tencent. All rights reserved.
//

#import "CustomizedPageView.h"

@interface CustomizedPageView()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation CustomizedPageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithTitle:(NSString *)title andImageName:(NSString *)imageName
{
    if(self = [self init])
    {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
        self.titleLabel.text = title;
        [self.titleLabel setTextAlignment:(NSTextAlignmentCenter)];
        self.imageView  = [[UIImageView alloc] initWithImage: [UIImage imageNamed:imageName]];
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview: self.titleLabel];
        [self addSubview: self.imageView];
    }
    return self;
}

-(void)layoutSubviews
{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    [super layoutSubviews];
    self.titleLabel.frame = CGRectMake(0, 20, self.bounds.size.width, 30);
    [self.titleLabel setFont: [UIFont fontWithName: @"PingFang-SC-Regular" size: 15]];
    
    [self.titleLabel setTextColor: [[UIColor blackColor] colorWithAlphaComponent:0.5]];
    
    CGPoint titleCenterPoint = CGPointMake(self.bounds.size.width / 2.0, self.titleLabel.center.y);
    self.titleLabel.center = titleCenterPoint;
    
    
    self.imageView.frame = CGRectMake(0, 50, self.bounds.size.width * 0.8, self.bounds.size.width * 0.4 * 2.1);
    CGPoint imageCenterPoint = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0 * 1.1);
    self.imageView.center = imageCenterPoint;
    
}

@end
