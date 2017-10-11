//
//  CustomAnimator.m
//  CustomPresentationAnimation
//
//  Created by bjovov on 2017/10/10.
//  Copyright © 2017年 CaoXueLiang.cn. All rights reserved.
//

#import "CustomAnimator.h"

@interface CustomAnimator()
@property (nonatomic,assign) AnimationType type;
@end

@implementation CustomAnimator
#pragma mark - Init Menthod
- (instancetype)initWithType:(AnimationType)type{
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.35f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    /*获取controller，ContainerView*/
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
    
    CGRect fromViewFrame = [transitionContext initialFrameForViewController:fromVC];
    CGRect toViewFrame = [transitionContext finalFrameForViewController:toVC];
    
    /*进行动画*/
    if (_type == AnimationTypePresent) {
        CGRect orginalFrame = CGRectZero;
        orginalFrame.origin = CGPointMake(CGRectGetMinX(containerView.bounds), CGRectGetMaxY(containerView.bounds));
        orginalFrame.size = toViewFrame.size;
        toView.frame = orginalFrame;
        [containerView addSubview:toView];
    }else if (_type == AnimationTypeDissmiss){
        
        /**
         处理 Dismissal 转场，按照上一小节的结论，.Custom模式下不要将 toView添加到 containerView
         */
        fromViewFrame = CGRectOffset(fromViewFrame, 0, CGRectGetHeight(containerView.bounds));
    }
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        if (_type == AnimationTypePresent) {
            toView.frame = toViewFrame;
        }else if (_type == AnimationTypeDissmiss){
            fromView.frame = fromViewFrame;
        }
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
    
}

@end
