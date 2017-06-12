//
//  PagerView.m
//  PagerViewController
//
//  Created by 曾涛 on 2017/6/12.
//  Copyright © 2017年 曾涛. All rights reserved.
//

#import "PagerView.h"

@interface PagerView ()<UIScrollViewDelegate>

@property (strong, nonatomic) NSArray           *nameArray;
@property (strong, nonatomic) NSMutableArray    *buttonArray;

@property (strong, nonatomic) UIView            *indicateView;
@property (strong, nonatomic) UIView            *segmentView;
@property (strong, nonatomic) UIView            *bottomLine;
@property (strong, nonatomic) UIScrollView      *segmentScrollV;


@end

@implementation PagerView

- (instancetype)initWithFrame:(CGRect)frame SegmentViewHeight:(CGFloat)segmentViewHeight titleArray:(NSArray *)titleArray Controller:(UIViewController *)controller lineWidth:(float)lineW lineHeight:(float)lineH{
    
    if (self = [super initWithFrame:frame]){
        
        _viewController = controller;
        float avgWidth = (frame.size.width/titleArray.count);
        self.nameArray = titleArray;
        _buttonArray = [NSMutableArray array]; //按钮数组
        
        //添加标题视图
        self.segmentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, segmentViewHeight)];
        self.segmentView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.segmentView];
        
        //添加按钮
        for (int i = 0; i < self.nameArray.count; i++) {
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = i;
            button.frame = CGRectMake(i*(frame.size.width/self.nameArray.count), 0, frame.size.width/self.nameArray.count, segmentViewHeight);
            button.titleLabel.font = [UIFont systemFontOfSize:16];
            [button setTitle:self.nameArray[i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor orangeColor]forState:UIControlStateSelected];
            [button addTarget:self action:@selector(Click:) forControlEvents:(UIControlEventTouchUpInside)];
            [self.segmentView addSubview:button];
            [_buttonArray addObject:button];   //添加顶部按钮
        }
        
        self.indicateView = [[UILabel alloc]initWithFrame:CGRectMake((avgWidth-lineW)/2,segmentViewHeight-lineH, lineW, lineH)];
        self.indicateView.backgroundColor = [UIColor orangeColor];
        [self.segmentView addSubview:self.indicateView];
        
        self.bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, segmentViewHeight-1, frame.size.width, 1)];
        self.bottomLine.backgroundColor = [UIColor grayColor];
        [self.segmentView addSubview:self.bottomLine];
        
        //添加scrollView
        self.segmentScrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, segmentViewHeight, frame.size.width, frame.size.height-segmentViewHeight)];
        self.segmentScrollV.bounces = NO;
        self.segmentScrollV.delegate = self;
        self.segmentScrollV.pagingEnabled = YES;
        self.segmentScrollV.showsHorizontalScrollIndicator = NO;
        self.segmentScrollV.contentSize = CGSizeMake(frame.size.width * _viewController.childViewControllers.count, 0);
        [self addSubview:self.segmentScrollV];
        
        //添加、取出ControllerView
        [self initChildViewController];
    }
    
    return self;
}


- (void)Click:(UIButton *)sender {
    
    UIButton *button = sender;
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    
    for (UIButton * btn in _buttonArray) {
        
        if (button != btn ) {
            
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }
    }
    
    [self.segmentScrollV setContentOffset:CGPointMake((sender.tag)*self.frame.size.width, 0) animated:YES ];
}

#pragma UIScorllerViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGPoint  frame = self.indicateView.center;
    frame.x = self.frame.size.width/(self.nameArray.count*2) +(self.frame.size.width/self.nameArray.count)*(self.segmentScrollV.contentOffset.x/self.frame.size.width);
    self.indicateView.center = frame;
}


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    [self initChildViewController];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    int pageNum = scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width;
    for (UIButton * btn in self.buttonArray) {
        
        (btn.tag == pageNum )
        ?([btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal])
        :([btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal]);
    }
    [self initChildViewController];
}

//添加、取出ControllerView
- (void)initChildViewController{
    
    NSInteger index = self.segmentScrollV.contentOffset.x / self.segmentScrollV.frame.size.width;
    UIViewController *childVC = _viewController.childViewControllers[index];
    if (!childVC.view.superview) {
        
        childVC.view.frame = CGRectMake(index * self.segmentScrollV.frame.size.width, 0, self.segmentScrollV.frame.size.width, self.self.segmentScrollV.frame.size.height);
        [self.segmentScrollV addSubview:childVC.view];
    }
    
}

@end
