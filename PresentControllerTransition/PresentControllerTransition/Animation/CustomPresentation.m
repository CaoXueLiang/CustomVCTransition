//
//  CustomPresentation.m
//  PresentControllerTransition
//
//  Created by bjovov on 2017/9/28.
//  Copyright © 2017年 CaoXueLiang.cn. All rights reserved.
//

#import "CustomPresentation.h"

#define OffSet 150
@interface CustomPresentation()
@property (nonatomic, strong) UIView *dimmingView;
@property (nonatomic, strong) UIView *presentationWrappingView;
@end

@implementation CustomPresentation
#pragma mark - Init Menthod
- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController{
    self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];
    if (self) {
        presentedViewController.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

#pragma mark - Present Menthod
/**在呈现过渡即将开始的时候调用*/
- (void)presentationTransitionWillBegin{
    //获取self.presentedViewController.view
    
}

/**
 在呈现过渡结束时被调用的
 如果呈现没有完成，那就移除背景 View
 */
- (void)presentationTransitionDidEnd:(BOOL)completed{
    if (!completed) {
        [self.bgView removeFromSuperview];
    }
}

/**在退出过渡即将开始的时候被调用的*/
- (void)dismissalTransitionWillBegin{
    // 与过渡效果一起执行背景 View 的淡出效果
    self.transitionCoordinator = self.presentingViewController.transitionCoordinator;
    [self.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        self.bgView.alpha = 0;
        self.presentingViewController.view.transform = CGAffineTransformIdentity;
    } completion:nil];
}

/**在退出的过渡结束时被调用的*/
- (void)dismissalTransitionDidEnd:(BOOL)completed{
    if (completed) {
        [self.bgView removeFromSuperview];
    }
    [[[UIApplication sharedApplication]keyWindow]addSubview:self.presentingViewController.view];
}

///**如果你不希望被呈现的 View 占据了整个屏幕，可以调整它的frame*/
//- (CGRect)frameOfPresentedViewInContainerView{
//    CGRect oldFrame = self.containerView.bounds;
//    CGRect newFrame = CGRectMake(oldFrame.origin.x, oldFrame.origin.y + OffSet, CGRectGetWidth(oldFrame), CGRectGetHeight(oldFrame) - OffSet);
//    return newFrame;
//}
//
///*设置圆角效果*/
//- (UIView *)presentedView{
//    UIView *pretedView = self.presentedViewController.view;
//    pretedView.layer.cornerRadius = 8.0f;
//    return pretedView;
//}

#pragma mark - UIViewControllerTransitioningDelegate
/*当modalPresentationStyle == UIModalPresentationCustom时调用*/
- (UIPresentationController*)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source{
    return self;
}

/*presenting时调用*/
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return self;
}

/*dismissing时调用*/
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return [transitionContext isAnimated] ? 0.35 : 0;
}

/*在presention中实现UIViewControllerAnimatedTransitioning,而不是单独在写一个动画类*/
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    //获取fromVC和toVC以及ContainerView
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    BOOL isPresenting = (fromVC == self.presentingViewController);
    //fromViewController.view当前的frame
    CGRect fromViewInitialFrame = [transitionContext initialFrameForViewController:fromVC];
    
    //`-shouldRemovePresentersView`这个方法是YES时==CGRectZero，其他情况下是fromViewController.view的当前值
    CGRect fromFinalFrame = [transitionContext finalFrameForViewController:fromVC];
    
    //CGRectZero
    CGRect toViewInitialFrame = [transitionContext initialFrameForViewController:toVC];
    
    //`-frameOfPresentedViewInContainerView`的返回值
    CGRect toViewFinalFrame = [transitionContext finalFrameForViewController:toVC];
    
    //将要进入的view添加到containerView
    [containerView addSubview:toView];
    
    if (isPresenting) {
        toViewInitialFrame.origin = CGPointMake(CGRectGetMinX(containerView.bounds), CGRectGetMaxY(containerView.bounds));
        toViewInitialFrame.size = toViewInitialFrame.size;
        toView.frame = toViewInitialFrame;
    }else{
        //用fromView.frame比较准确,不用`-fromViewInitialFrame`
        fromView.frame = CGRectOffset(fromView.frame, 0, CGRectGetHeight(fromView.frame));
    }
    
    //进行动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        if (isPresenting) {
            toView.frame = toViewFinalFrame;
        }else{
            fromView.frame = fromFinalFrame;
        }
    } completion:^(BOOL finished) {
        
        //告诉 transitionContext 动画结束
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

@end

