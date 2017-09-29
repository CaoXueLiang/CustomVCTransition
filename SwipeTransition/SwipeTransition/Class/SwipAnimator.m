//
//  SwipAnimator.m
//  SwipeTransition
//
//  Created by bjovov on 2017/9/29.
//  Copyright © 2017年 CaoXueLiang.cn. All rights reserved.
//

#import "SwipAnimator.h"

@implementation SwipAnimator
#pragma mark - Init Menthod
+ (instancetype)initWithType:(AnimationType)type{
    SwipAnimator *model = [[SwipAnimator alloc]init];
    model.type = type;
    return model;
}

#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.4;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    if (self.type == AnimationTypePresent) {
        [self presentAnimation:transitionContext];
    }else if (self.type == AnimationTypeDissmiss){
        [self dissmissAnimation:transitionContext];
    }
}

- (void)presentAnimation:(id <UIViewControllerContextTransitioning>)transitionContext{
    //获取fromVC和toVC和ContainerView
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *contrinerView = [transitionContext containerView];
    
    //获取frame
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    CGRect fromFrame = [transitionContext initialFrameForViewController:fromVC];
    CGRect toFrame = [transitionContext finalFrameForViewController:toVC];
    fromView.frame = fromFrame;
    toView.frame = CGRectMake(toFrame.origin.x +  CGRectGetWidth(toFrame), toFrame.origin.y, CGRectGetWidth(toFrame), CGRectGetHeight(toFrame));

    //添加到containerView
    [contrinerView addSubview:toView];
    
    //进行动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toView.frame = toFrame;
    } completion:^(BOOL finished) {
        //告诉transitionContext完成动画
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

- (void)dissmissAnimation:(id <UIViewControllerContextTransitioning>)transitionContext{
    //获取fromVC和toVC和ContainerView
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *contrinerView = [transitionContext containerView];
    
    //获取frame
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    CGRect fromFrame = [transitionContext initialFrameForViewController:fromVC];
    CGRect toFrame = [transitionContext finalFrameForViewController:toVC];
    fromView.frame = fromFrame;
    toView.frame = toFrame;

    //添加containerView
    [contrinerView insertSubview:toView belowSubview:fromView];
    
    //进行动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromView.frame = CGRectMake(CGRectGetMaxX(fromFrame), CGRectGetMinY(fromFrame), CGRectGetWidth(fromFrame), CGRectGetHeight(fromFrame));
        
    } completion:^(BOOL finished) {
        //告诉transitionContext完成动画
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

@end

