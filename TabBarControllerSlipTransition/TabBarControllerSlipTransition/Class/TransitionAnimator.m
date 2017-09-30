//
//  TransitionAnimator.m
//  TabBarControllerSlipTransition
//
//  Created by bjovov on 2017/9/30.
//  Copyright © 2017年 CaoXueLiang.cn. All rights reserved.
//

#import "TransitionAnimator.h"

@implementation TransitionAnimator
#pragma mark - Init
- (instancetype)initWithEdge:(UIRectEdge)edge{
    self = [super init];
    if (self) {
        _edge = edge;
    }
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.4f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    //获取FromVC,toVC,ConatinerView
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    UIView *fromView;
    UIView *toView;
    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    }else{
        fromView = fromVC.view;
        toView = toVC.view;
    }
    
    CGRect fromFrame = [transitionContext initialFrameForViewController:fromVC];
    CGRect toFrame = [transitionContext finalFrameForViewController:toVC];
    
    if (_edge == UIRectEdgeLeft) {
        fromView.frame = fromFrame;
        toView.frame = CGRectOffset(toFrame, -CGRectGetWidth(toFrame), 0);
    }else if (_edge == UIRectEdgeRight){
        fromView.frame = fromFrame;
        toView.frame = CGRectOffset(toFrame, CGRectGetWidth(toFrame), 0);
    }
    
    [containerView addSubview:toView];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        if (_edge == UIRectEdgeLeft) {
            fromView.frame = CGRectOffset(fromFrame, CGRectGetWidth(fromFrame), 0);
            toView.frame = toFrame;
        }else if (_edge == UIRectEdgeRight){
            fromView.frame = CGRectOffset(fromFrame, -CGRectGetWidth(fromFrame), 0);
            toView.frame = toFrame;
        }
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

@end
