//
//  CrossDissolveAnimation.m
//  CrossDissolveTransitation
//
//  Created by bjovov on 2017/9/29.
//  Copyright © 2017年 CaoXueLiang.cn. All rights reserved.
//

#import "CrossDissolveAnimation.h"

@implementation CrossDissolveAnimation
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.35f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    //获取fromVC和toVC
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    /*iOS8开始可以使用`-viewForKey:`*/
    UIView *fromView;
    UIView *toView;
    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    } else {
        fromView = fromVC.view;
        toView = toVC.view;
    }
    
    fromView.frame = [transitionContext initialFrameForViewController:fromVC];
    toView.frame = [transitionContext finalFrameForViewController:toVC];
    fromView.alpha = 1.0;
    toView.alpha = 0;
    
    //将要进来的View，添加到containerView中，用于present和dismiss
    [containerView addSubview:toView];
    
    //开始动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromView.alpha = 0;
        toView.alpha = 1.0;
    } completion:^(BOOL finished) {
        //告诉transitionContext完成动画
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

@end
