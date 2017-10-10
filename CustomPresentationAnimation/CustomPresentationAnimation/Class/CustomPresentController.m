//
//  CustomPresentController.m
//  CustomPresentationAnimation
//
//  Created by bjovov on 2017/10/10.
//  Copyright © 2017年 CaoXueLiang.cn. All rights reserved.
//

#import "CustomPresentController.h"
#import "CustomAnimator.h"
#import "PercentModel.h"

#define KContentHeight 340
@interface CustomPresentController()
@property (nonatomic,strong) UIView *dimmingView;
@property (nonatomic,strong) UIView *presentedWrapView;
@property (nonatomic,strong) PercentModel *percentModel;
@end

@implementation CustomPresentController
#pragma mark - Init Menthod
- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController{
    self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];
    if (self) {
        //必须是`UIModalPresentationCustom`类型
        presentedViewController.modalPresentationStyle = UIModalPresentationCustom;
        _percentModel = [[PercentModel alloc]initWithController:presentedViewController];
    }
    return self;
}

#pragma mark - Event Response
- (void)tapDissmiss:(UITapGestureRecognizer *)recognizer{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - Private Menthod
- (UIView *)presentedView{
    return self.presentedWrapView;
}

- (CGRect)frameOfPresentedViewInContainerView{
    CGRect frame = self.containerView.bounds;
    CGRect contentFrame = CGRectMake(CGRectGetMinX(frame), CGRectGetMaxY(frame) - KContentHeight, CGRectGetWidth(frame), KContentHeight);
    return contentFrame;
}

- (BOOL)shouldRemovePresentersView{
    return NO;
}

/**在呈现过渡即将开始的时候被调用的*/
- (void)presentationTransitionWillBegin{
    [self.containerView addSubview:self.dimmingView];

    self.dimmingView.alpha = 0.0;
    [self.presentingViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.dimmingView.alpha = 0.7;
        self.presentingViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.92, 0.92);
    } completion:nil];
}

/**在呈现过渡结束时被调用的*/
- (void)presentationTransitionDidEnd:(BOOL)completed{
    if (!completed) {
        [self.dimmingView removeFromSuperview];
    }
}

/**在退出过渡即将开始的时候被调用的*/
- (void)dismissalTransitionWillBegin{
    [self.presentingViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        self.dimmingView.alpha = 0;
        self.presentingViewController.view.transform = CGAffineTransformIdentity;
    } completion:nil];
}

/**在退出的过渡结束时被调用的*/
- (void)dismissalTransitionDidEnd:(BOOL)completed{
    if (completed) {
        [self.dimmingView removeFromSuperview];
    }
}

#pragma mark - UIViewControllerTransitioningDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [[CustomAnimator alloc]initWithType:AnimationTypePresent];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return [[CustomAnimator alloc]initWithType:AnimationTypeDissmiss];
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator{
    return nil;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator{
    return _percentModel;
}

- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(nullable UIViewController *)presenting sourceViewController:(UIViewController *)source NS_AVAILABLE_IOS(8_0){
    return self;
}

#pragma mark - Setter && Getter
- (UIView *)dimmingView{
    if (!_dimmingView) {
        _dimmingView = [[UIView alloc]initWithFrame:self.containerView.bounds];
        _dimmingView.backgroundColor = [UIColor blackColor];
        _dimmingView.alpha = 0;
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapDissmiss:)];
        [_dimmingView addGestureRecognizer:gesture];
    }
    return _dimmingView;
}

- (UIView *)presentedWrapView{
    if (!_presentedWrapView) {
        _presentedWrapView = [[UIView alloc]initWithFrame:self.frameOfPresentedViewInContainerView];
        UIView *presentedViewControllerView = [super presentedView];
        presentedViewControllerView.frame = _presentedWrapView.bounds;
        [_presentedWrapView addSubview:presentedViewControllerView];
    }
    return _presentedWrapView;
}

@end

