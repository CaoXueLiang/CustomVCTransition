//
//  TransitionAnimator.h
//  TabBarControllerSlipTransition
//
//  Created by bjovov on 2017/9/30.
//  Copyright © 2017年 CaoXueLiang.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TransitionAnimator : NSObject<UIViewControllerAnimatedTransitioning>
- (instancetype)initWithEdge:(UIRectEdge)edge;
@property (nonatomic,assign) UIRectEdge edge;
@end
