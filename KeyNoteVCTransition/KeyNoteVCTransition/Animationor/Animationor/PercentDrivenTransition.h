//
//  PercentDrivenTransition.h
//  KeyNoteVCTransition
//
//  Created by bjovov on 2017/9/26.
//  Copyright © 2017年 CaoXueLiang.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PercentDrivenTransition : UIPercentDrivenInteractiveTransition
/**
 是否开始拖拽
 */
@property (nonatomic,assign) BOOL isStart;

/**
 初始化
 @param controller 需要添加侧滑手势的controller
 @return UIPercentDrivenInteractiveTransition
 */
+ (instancetype)initWithScreenEdgeGestureForController:(UIViewController *)controller;
@end
