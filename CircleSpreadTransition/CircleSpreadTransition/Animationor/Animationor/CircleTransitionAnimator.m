//
//  CircleTransitionAnimator.m
//  CircleSpreadTransition
//
//  Created by 曹学亮 on 2017/9/26.
//  Copyright © 2017年 曹学亮. All rights reserved.
//

#import "CircleTransitionAnimator.h"
#import "FirstViewController.h"
#import "SecondViewController.h"

#define AnimationKey @"animationkey"
#define TransitionContextKey @"transitionContext"
@interface CircleTransitionAnimator()

@end

@implementation CircleTransitionAnimator
#pragma mark - Init Menthod
+ (instancetype)initWithType:(AnimationType)type{
    CircleTransitionAnimator *animator = [[CircleTransitionAnimator alloc]init];
    animator.type = type;
    return animator;
}

#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.6f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    if (self.type == AnimationTypePush) {
        [self pushAnimation:transitionContext];
    }else if (self.type == AnimationTypePop){
        [self popAnimation:transitionContext];
    }
}

#pragma mark - Animation Menthod
- (void)pushAnimation:(id <UIViewControllerContextTransitioning>)transitionContext{
    //获取fromVC和toVC,以及containerView
    FirstViewController *fromVC = (FirstViewController*)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    SecondViewController *toVC = (SecondViewController*)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    //设置遮罩
    CGPoint buttonCenter = fromVC.targetButton.center;
    CGRect buttonFrame = fromVC.targetButton.frame;
    CGFloat paddingX = MAX(buttonCenter.x, CGRectGetWidth(fromVC.view.frame) - buttonCenter.x);
    CGFloat paddingY = MAX(buttonCenter.y, CGRectGetHeight(fromVC.view.frame) - buttonCenter.y);

    CGFloat distance = sqrtf((paddingX * paddingX) + (paddingY * paddingY));
    UIBezierPath *startPath = [UIBezierPath bezierPathWithOvalInRect:buttonFrame];
    UIBezierPath *endPath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(buttonFrame, -(distance - CGRectGetWidth(buttonFrame)/2.0), -(distance - CGRectGetHeight(buttonFrame)/2.0))];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    
    //将参与变换的视图添加到contaier上
    [containerView addSubview:fromVC.view];
    [containerView addSubview:toVC.view];
    toVC.view.layer.mask = maskLayer;
    //防止最后闪屏一下
    maskLayer.path = endPath.CGPath;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.duration = 0.6;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animation.delegate = self;
    animation.fromValue = (__bridge id)startPath.CGPath;
    animation.toValue = (__bridge id)endPath.CGPath;
    [animation setValue:@"maskAnimation" forKey:AnimationKey];
    [animation setValue:transitionContext forKey:TransitionContextKey];
    [maskLayer addAnimation:animation forKey:nil];
}

- (void)popAnimation:(id <UIViewControllerContextTransitioning>)transitionContext{
    //获取fromVC和toVC,以及containerView
    SecondViewController *fromVC = (SecondViewController*)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    FirstViewController *toVC = (FirstViewController*)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    //设置遮罩
    CGPoint buttonCenter = toVC.targetButton.center;
    CGRect buttonFrame = toVC.targetButton.frame;
    CGFloat paddingX = MAX(buttonCenter.x, CGRectGetWidth(toVC.view.frame) - buttonCenter.x);
    CGFloat paddingY = MAX(buttonCenter.y, CGRectGetHeight(toVC.view.frame) - buttonCenter.y);
    
    CGFloat distance = sqrtf((paddingX * paddingX) + (paddingY * paddingY));
    UIBezierPath *endPath = [UIBezierPath bezierPathWithOvalInRect:buttonFrame];
    UIBezierPath *startPath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(buttonFrame, -(distance - CGRectGetWidth(buttonFrame)/2.0), -(distance - CGRectGetHeight(buttonFrame)/2.0))];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    
    //将参与变换的视图添加到contaier上
    [containerView addSubview:toVC.view];
    [containerView addSubview:fromVC.view];
    fromVC.view.layer.mask = maskLayer;
    //防止最后闪屏一下
    maskLayer.path = endPath.CGPath;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.duration = 0.6;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animation.delegate = self;
    animation.fromValue = (__bridge id)startPath.CGPath;
    animation.toValue = (__bridge id)endPath.CGPath;
    [animation setValue:@"maskAnimationPop" forKey:AnimationKey];
    [animation setValue:transitionContext forKey:TransitionContextKey];
    [maskLayer addAnimation:animation forKey:nil];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if ([[anim valueForKey:AnimationKey] isEqualToString:@"maskAnimation"]){
        id <UIViewControllerContextTransitioning> transitionContext = [anim valueForKey:TransitionContextKey];
        SecondViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        toVC.view.layer.mask = nil;
        
        //完成动画
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        
    }else if ([[anim valueForKey:AnimationKey]isEqualToString:@"maskAnimationPop"]){
        id <UIViewControllerContextTransitioning> transitionContext = [anim valueForKey:TransitionContextKey];
        SecondViewController *FromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        FromVC.view.layer.mask = nil;
        
        //完成动画
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }
}

@end

