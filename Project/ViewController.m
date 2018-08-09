//
//  ViewController.m
//  VCFloatView
//
//  Created by Weiming Wu on 2018/8/9.
//  Copyright © 2018 Weiming Wu. All rights reserved.
//

#import "ViewController.h"
#import "VCFloatViewManager.h"
#import "VCFloatView.h"

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
    UIView *v = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, 100, 150))];
    v.backgroundColor = [UIColor blueColor];
    VCFloatView *floatView = [[VCFloatView alloc] initWithFrame:CGRectMake(0, 0, 100, 150) andDismissBlock:^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert Test" message:@"This is code from Block" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }];
    [floatView addPageView:v];
    [floatView reloadPageViews];
    [self.fvmgr addFloatView:floatView andPriority: VCFloatViewPriorityHigh];
    [self.fvmgr showNextFloatViewOnView:self.view animated:YES];
}

@end
