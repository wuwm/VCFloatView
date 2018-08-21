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
#import "CustomizedPageView.h"

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
    
    CustomizedPageView *p1 = [[CustomizedPageView alloc] initWithTitle:@"This is Page1" andImageName: @"1.png"];
    CustomizedPageView *p2 = [[CustomizedPageView alloc] initWithTitle:@"This is Page2" andImageName: @"2.png"];
    CustomizedPageView *p3 = [[CustomizedPageView alloc] initWithTitle:@"This is Page3" andImageName: @"3.png"];
    CustomizedPageView *p4 = [[CustomizedPageView alloc] initWithTitle:@"This is Page4" andImageName: @"4.png"];
    
    VCFloatContentView *floatView = [[VCFloatContentView alloc] initWithFrame:CGRectMake(0, 0, 250, 300)];

    [floatView addPageView:p1];
    [floatView addPageView:p2];
    [floatView addPageView:p3];
    [floatView addPageView:p4];
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
    
    CustomizedPageView *p1 = [[CustomizedPageView alloc] initWithTitle:@"This is Page1" andImageName: @"1.png"];
    CustomizedPageView *p2 = [[CustomizedPageView alloc] initWithTitle:@"This is Page2" andImageName: @"2.png"];
    CustomizedPageView *p3 = [[CustomizedPageView alloc] initWithTitle:@"This is Page3" andImageName: @"3.png"];
    CustomizedPageView *p4 = [[CustomizedPageView alloc] initWithTitle:@"This is Page4" andImageName: @"4.png"];
    
    VCFloatContentView *floatView = [[VCFloatContentView alloc] initWithFrame:CGRectMake(0, 0, 250, 300)];
    [floatView changeCloseButtonPosition:CGRectMake(floatView.bounds.size.width/2.0 - 15, floatView.bounds.size.height + 50, 30, 30)];
    [floatView addPageView:p1];
    [floatView addPageView:p2];
    [floatView addPageView:p3];
    [floatView addPageView:p4];
    [floatView reloadPageViews];
    [self.fvmgr addFloatView:floatView andPriority: VCFloatViewPriorityHigh];
    [self.fvmgr showNextFloatViewOnView:self.view animated:YES];
}
- (IBAction)onClickedOnePage:(UIButton *)sender
{
    UIView *v = [[UIView alloc] init];
    v.backgroundColor = [UIColor blueColor];
    
    UIView *vv = [[UIView alloc] init];
    vv.backgroundColor = [UIColor greenColor];
    
    UIView *vvv = [[UIView alloc] init];
    vvv.backgroundColor = [UIColor redColor];
    
    CustomizedPageView *p1 = [[CustomizedPageView alloc] initWithTitle:@"This is Page 1" andImageName: @"1.png"];
    CustomizedPageView *p2 = [[CustomizedPageView alloc] initWithTitle:@"This is Page 2" andImageName: @"2.png"];
    CustomizedPageView *p3 = [[CustomizedPageView alloc] initWithTitle:@"This is Page 3" andImageName: @"3.png"];
    CustomizedPageView *p4 = [[CustomizedPageView alloc] initWithTitle:@"This is Page 4" andImageName: @"4.png"];
    
    VCFloatContentView *floatView = [[VCFloatContentView alloc] initWithFrame:CGRectMake(0, 0, 250, 300)];
    [floatView changeCloseButtonPosition:CGRectMake(floatView.bounds.size.width/2.0 - 15, floatView.bounds.size.height + 50, 30, 30)];
    [floatView addPageView:p1];
//    [floatView addPageView:p2];
//    [floatView addPageView:p3];
//    [floatView addPageView:p4];
    [floatView reloadPageViews];
    [self.fvmgr addFloatView:floatView andPriority: VCFloatViewPriorityHigh];
    [self.fvmgr showNextFloatViewOnView:self.view animated:YES];
}

@end
