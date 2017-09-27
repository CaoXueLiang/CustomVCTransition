//
//  TranstionAnimator.m
//  3DTransitionAnimation
//
//  Created by bjovov on 2017/9/27.
//  Copyright © 2017年 CaoXueLiang.cn. All rights reserved.
//

#import "TranstionAnimator.h"
#import "FirstController.h"
#import "SecondController.h"

@interface TranstionAnimator()
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
    if (self.type == AnimationTypePush){
        [self pushAnimation:transitionContext];
    }else if (self.type == AnimationTypePop){
        [self popAnimation:transitionContext];
    }
}

- (void)pushAnimation:(id <UIViewControllerContextTransitioning>)transitionContext{
    //获取fromVC和toVC,还有containerView
    FirstController *fromVC = (FirstController*)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    SecondController *toVC = (SecondController*)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    //进行变换
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1/500.0;//透视效果（-1/d d:500~1000）
    transform = CATransform3DRotate(transform, M_PI_2,0, -1, 0);
    fromVC.view.layer.anchorPoint = CGPointMake(0, 0.5);
    fromVC.view.layer.position = CGPointMake(0, CGRectGetHeight(fromVC.view.frame)/2.0);
    [containerView addSubview:toVC.view];
    [containerView addSubview:fromVC.view];
    
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        fromVC.view.layer.transform = transform;
        
    } completion:^(BOOL finished) {
        
        fromVC.view.layer.transform = CATransform3DIdentity;
        fromVC.view.layer.anchorPoint = CGPointMake(0.5, 0.5);
        fromVC.view.layer.position = CGPointMake(CGRectGetWidth(fromVC.view.frame)/2.0, CGRectGetHeight(fromVC.view.frame)/2.0);
        
        //结束动画
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

- (void)popAnimation:(id <UIViewControllerContextTransitioning>)transitionContext{
    //获取fromVC和toVC,还有containerView
    SecondController *fromVC = (SecondController*)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    FirstController *toVC = (FirstController*)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    
    //设置透视效果
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1/500.0;//透视效果（-1/d d:500~1000）
    CATransform3D transform1 = CATransform3DRotate(transform, M_PI_2,0, -1, 0);
    CATransform3D transform2 = CATransform3DRotate(transform, M_PI_2, 0, 1, 0);
    
    toVC.view.layer.anchorPoint = CGPointMake(0, 0.5);
    toVC.view.layer.position = CGPointMake(0, CGRectGetHeight(toVC.view.frame)/2.0);
    [containerView addSubview:fromVC.view];
    [containerView addSubview:toVC.view];
    
    toVC.view.layer.transform = CATransform3DIdentity;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.duration = [self transitionDuration:transitionContext];
    animation.fromValue = [NSValue valueWithCATransform3D:transform1];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animation.delegate = self;
    [animation setValue:transitionContext forKey:@"transition"];
    [toVC.view.layer addAnimation:animation forKey:nil];

}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    id <UIViewControllerContextTransitioning> transitionContext = [anim valueForKey:@"transition"];
    
    FirstController *toVC = (FirstController*)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toVC.view.layer.transform = CATransform3DIdentity;
    toVC.view.layer.anchorPoint = CGPointMake(0.5, 0.5);
    toVC.view.layer.position = CGPointMake(CGRectGetWidth(toVC.view.frame)/2.0, CGRectGetHeight(toVC.view.frame)/2.0);

    //结束动画
    [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
}

@end

