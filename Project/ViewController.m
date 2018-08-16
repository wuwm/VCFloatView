//
//  ViewController.m
//  VCFloatView
//
//  Created by Weiming Wu on 2018/8/9.
//  Copyright © 2018 Weiming Wu. All rights reserved.
//

#import "ViewController.h"
#import "VCFloatViewManager.h"
#import "VCFloatContentView.h"

@interface ViewController ()

@property (nonatomic, strong) VCFloatViewManager *fvmgr;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.fvmgr = [[VCFloatViewManager alloc] init];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onClickedFloatView:(UIButton *)sender
{
    UIView *v = [[UIView alloc] init];
    v.backgroundColor = [UIColor blueColor];
    
    UIView *vv = [[UIView alloc] init];
    vv.backgroundColor = [UIColor greenColor];
    
    UIView *vvv = [[UIView alloc] init];
    vvv.backgroundColor = [UIColor redColor];
    
    VCFloatContentView *floatView = [[VCFloatContentView alloc] initWithFrame:CGRectMake(0, 0, 200, 300)];

    [floatView addPageView:v];
    [floatView addPageView:vv];
    [floatView addPageView:vvv];
    [floatView reloadPageViews];
    [self.fvmgr addFloatView:floatView andPriority: VCFloatViewPriorityHigh];
    [self.fvmgr showNextFloatViewOnView:self.view animated:YES];
}

- (IBAction)onClickedCusBtn:(UIButton *)sender
{
    UIView *v = [[UIView alloc] init];
    v.backgroundColor = [UIColor blueColor];
    
    UIView *vv = [[UIView alloc] init];
    vv.backgroundColor = [UIColor greenColor];
    
    UIView *vvv = [[UIView alloc] init];
    vvv.backgroundColor = [UIColor redColor];
    
    VCFloatContentView *floatView = [[VCFloatContentView alloc] initWithFrame:CGRectMake(0, 0, 200, 300)];
    [floatView changeCloseButtonPosition:CGRectMake(floatView.bounds.size.width/2.0 - 15, floatView.bounds.size.height + 50, 30, 30)];
    [floatView addPageView:v];
    [floatView addPageView:vv];
    [floatView addPageView:vvv];
    [floatView reloadPageViews];
    [self.fvmgr addFloatView:floatView andPriority: VCFloatViewPriorityHigh];
    [self.fvmgr showNextFloatViewOnView:self.view animated:YES];
}
- (IBAction)onClickedOnePage:(UIButton *)sender
{
    UIView *v = [[UIView alloc] init];
    v.backgroundColor = [UIColor blueColor];
    
    VCFloatContentView *floatView = [[VCFloatContentView alloc] initWithFrame:CGRectMake(0, 0, 200, 300)];
    [floatView changeCloseButtonPosition:CGRectMake(floatView.bounds.size.width/2.0 - 15, floatView.bounds.size.height + 50, 30, 30)];
    [floatView addPageView:v];

    [floatView reloadPageViews];
    [self.fvmgr addFloatView:floatView andPriority: VCFloatViewPriorityHigh];
    [self.fvmgr showNextFloatViewOnView:self.view animated:YES];
}

@end
