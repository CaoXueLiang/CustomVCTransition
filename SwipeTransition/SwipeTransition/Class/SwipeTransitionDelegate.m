//
//  SwipeTransitionDelegate.m
//  SwipeTransition
//
//  Created by bjovov on 2017/9/30.
//  Copyright © 2017年 CaoXueLiang.cn. All rights reserved.
//

#import "SwipeTransitionDelegate.h"
#import "SwipAnimator.h"
#import "PercentModel.h"

@implementation SwipeTransitionDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [SwipAnimator initWithType:AnimationTypePresent];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return [SwipAnimator initWithType:AnimationTypeDissmiss];
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator{
    if (self.gestureRecognizer) {
        return [[PercentModel alloc]initWithGesture:self.gestureRecognizer edge:UIRectEdgeRight];
    }else{
        return nil;
    }
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator{
    if (self.gestureRecognizer) {
        return [[PercentModel alloc]initWithGesture:self.gestureRecognizer edge:UIRectEdgeLeft];
    }else{
        return nil;
    }
}

@end
