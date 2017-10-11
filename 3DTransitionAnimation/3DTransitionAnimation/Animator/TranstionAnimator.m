//
//  TranstionAnimator.m
//  3DTransitionAnimation
//
//  Created by bjovov on 2017/9/27.
//  Copyright © 2017年 CaoXueLiang.cn. All rights reserved.
//

#import "TranstionAnimator.h"

#define Animation @"animation"
@interface TranstionAnimator()<CAAnimationDelegate>
@property (nonatomic,assign) AnimationType type;
@end

@implementation TranstionAnimator
#pragma mark - Init Menthod
+ (instancetype)initWithType:(AnimationType)type{
    TranstionAnimator *model = [[TranstionAnimator alloc]init];
    model.type = type;
    return model;
}

#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.6f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    //获取fromVC和toVC,还有containerView
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
    
    if (self.type == AnimationTypePush){
        [containerView insertSubview:toView belowSubview:fromView];
        CATransform3D transform = CATransform3DIdentity;
        transform.m34 = -1.0/500;
        transform = CATransform3DRotate(transform, M_PI_2, 0,-1, 0);
        fromView.layer.anchorPoint = CGPointMake(0, 0.5);
        fromView.layer.position = CGPointMake(0, CGRectGetHeight(fromFrame)/2.0);
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            fromView.layer.transform = transform;
        } completion:^(BOOL finished) {
            fromView.layer.transform = CATransform3DIdentity;
            fromView.layer.anchorPoint = CGPointMake(0.5, 0.5);
            fromView.layer.position = CGPointMake(CGRectGetWidth(fromView.frame)/2.0, CGRectGetHeight(fromView.frame)/2.0);
            
            //结束动画
            [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        }];
      
    }else if (self.type == AnimationTypePop){
        [containerView addSubview:toView];
        CATransform3D transform = CATransform3DIdentity;
        transform.m34 = -1.0/500;
        transform = CATransform3DRotate(transform, M_PI_2, 0,-1, 0);
        toView.layer.anchorPoint = CGPointMake(0, 0.5);
        toView.layer.position = CGPointMake(0, CGRectGetHeight(toFrame)/2.0);
        toView.layer.transform = transform;
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            toView.layer.transform = CATransform3DIdentity;
        } completion:^(BOOL finished) {
            toView.layer.transform = CATransform3DIdentity;
            toView.layer.anchorPoint = CGPointMake(0.5, 0.5);
            toView.layer.position = CGPointMake(CGRectGetWidth(toView.frame)/2.0, CGRectGetHeight(toView.frame)/2.0);
            
            //结束动画
            [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        }];
    }
}


@end

