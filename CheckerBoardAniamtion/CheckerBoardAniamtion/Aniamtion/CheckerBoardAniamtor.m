//
//  CheckerBoardAniamtor.m
//  CheckerBoardAniamtion
//
//  Created by 曹学亮 on 2017/10/8.
//  Copyright © 2017年 曹学亮. All rights reserved.
//

#import "CheckerBoardAniamtor.h"

@interface CheckerBoardAniamtor()
@property (nonatomic,assign) AniamtionType type;
@end

@implementation CheckerBoardAniamtor
#pragma mark - Init
- (instancetype)initWithType:(AniamtionType)type{
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return 3.0f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    //获取fromVC,toVC,containerView
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
    
    fromView.frame = [transitionContext initialFrameForViewController:fromVC];
    toView.frame = [transitionContext finalFrameForViewController:toVC];
    UIView *fromViewSnapshot = [fromView snapshotViewAfterScreenUpdates:NO];
    UIView *toViewSnapshot = [toView snapshotViewAfterScreenUpdates:NO];
    
    
    
    if (_type == AniamtionTypePush) {
        
    }else if (_type == AniamtionTypePop){
        
    }
}


@end

