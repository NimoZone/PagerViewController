//
//  PagerView.h
//  PagerViewController
//
//  Created by 曾涛 on 2017/6/12.
//  Copyright © 2017年 曾涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PagerView : UIView

@property (strong, nonatomic) UIViewController  *viewController;

/**
 滑块按钮
 
 @param frame selfFrame
 @param segmentViewHeight 按钮高度
 @param titleArray 按钮名
 @param controller 主控住器
 @param lineW 选中条宽度
 @param lineH 选中条高度
 @return self
 */
- (instancetype)initWithFrame:(CGRect)frame
            SegmentViewHeight:(CGFloat)segmentViewHeight
                   titleArray:(NSArray *)titleArray
                   Controller:(UIViewController *)controller
                    lineWidth:(float)lineW
                   lineHeight:(float)lineH;


@end
