//
//  LayerAnimation.m
//  3DTransitionAnimation
//
//  Created by bjovov on 2017/10/12.
//  Copyright © 2017年 CaoXueLiang.cn. All rights reserved.
//

#import "LayerAnimation.h"

#define Animation @"animations"
@implementation LayerAnimation
#pragma mark - Init Menthod
+ (instancetype)initWithType:(type)animationType{
    LayerAnimation *model = [[LayerAnimation alloc]init];
    model.animationType = animationType;
    return model;
}

#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.5f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    //获取fromVC,toVC,containerView,fromView,toView
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
    
    _transitionContext = transitionContext;
    CGRect fromFrame = [transitionContext initialFrameForViewController:fromVC];
    _fromView = fromView;
    if (_animationType == typePush) {
        [containerView insertSubview:toView belowSubview:fromView];
        
        CATransform3D transform = CATransform3DIdentity;
        transform.m34 = -1.0/500;
        transform = CATransform3DRotate(transform, M_PI_2, 0,-1, 0);
        _fromView.layer.anchorPoint = CGPointMake(0, 0.5);
        _fromView.layer.position = CGPointMake(0, CGRectGetHeight(fromFrame)/2.0);
        
        _fromView.layer.transform = transform;
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
        animation.duration = [self transitionDuration:transitionContext];
        animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
        animation.toValue = [NSValue valueWithCATransform3D:transform];
        animation.delegate = self;
        [_fromView.layer addAnimation:animation forKey:@"push"];
        
    }else if (_animationType == typePop){
        _toView = toView;
        [containerView addSubview:toView];
        
        CATransform3D transform = CATransform3DIdentity;
        transform.m34 = -1.0/500;
        transform = CATransform3DRotate(transform, M_PI_2, 0,-1, 0);
        toView.layer.anchorPoint = CGPointMake(0, 0.5);
        toView.layer.position = CGPointMake(0, CGRectGetHeight(fromFrame)/2.0);
        
        toView.layer.transform = CATransform3DIdentity;
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
        animation.duration = [self transitionDuration:transitionContext];
        animation.fromValue = [NSValue valueWithCATransform3D:transform];
        animation.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
        animation.delegate = self;
        [toView.layer addAnimation:animation forKey:@"pop"];
    }
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (_animationType == typePush) {
        _fromView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        _fromView.layer.position = CGPointMake(CGRectGetWidth(_fromView.frame)/2.0, CGRectGetHeight(_fromView.frame)/2.0);
        [_transitionContext completeTransition:!_transitionContext.transitionWasCancelled];
    }else if (_animationType == typePop){
        _toView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        _toView.layer.position = CGPointMake(CGRectGetWidth(_toView.frame)/2.0, CGRectGetHeight(_toView.frame)/2.0);
        [_transitionContext completeTransition:!_transitionContext.transitionWasCancelled];
    }
}

@end

