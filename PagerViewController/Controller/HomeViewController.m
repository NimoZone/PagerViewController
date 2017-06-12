//
//  HomeViewController.m
//  PagerViewController
//
//  Created by 曾涛 on 2017/6/12.
//  Copyright © 2017年 曾涛. All rights reserved.
//

#import "HomeViewController.h"
#import "PagerView.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"

@interface HomeViewController ()
{
    PagerView *_pagerView;
}
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildViewControllers];
    [self initLayoutPagerView];
}

- (void)initLayoutPagerView{
    
    
    _pagerView = [[PagerView alloc]initWithFrame:CGRectMake(0,20,SCREENW,SCREENH - 20)
                               SegmentViewHeight:50
                                      titleArray:@[@"全部",@"购买",@"提现"]
                                      Controller:self
                                       lineWidth:SCREENW/5
                                      lineHeight:3];
    
    [self.view addSubview:_pagerView];
    
}

- (void)addChildViewControllers{
    
    //全部
    OneViewController *oneVC = [[OneViewController alloc] init];
    [self addChildViewController:oneVC];
    
    //购买
    TwoViewController *twoVC = [[TwoViewController alloc] init];
    [self addChildViewController:twoVC];
    
    //提现
    ThreeViewController *threeVC = [[ThreeViewController alloc] init];
    [self addChildViewController:threeVC];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
