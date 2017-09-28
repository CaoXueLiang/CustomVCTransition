//
//  PercentTransication.m
//  3DTransitionAnimation
//
//  Created by bjovov on 2017/9/27.
//  Copyright © 2017年 CaoXueLiang.cn. All rights reserved.
//

#import "PercentTransication.h"

@implementation PercentTransication
#pragma mark - Init Menthod
+ (instancetype)initWithController:(UIViewController *)controller{
    PercentTransication *model = [[PercentTransication alloc]init];
    model.controller = controller;
    [model addPopGesture:controller];
    return model;
}

- (void)addPopGesture:(UIViewController *)controller{
    UIScreenEdgePanGestureRecognizer *gesture = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(leftPan:)];
    gesture.edges = UIRectEdgeLeft;
    [controller.view addGestureRecognizer:gesture];
}

- (void)leftPan:(UIScreenEdgePanGestureRecognizer *)recognizer{
    CGPoint currentPoint = [recognizer translationInView:recognizer.view];
    CGFloat progress = currentPoint.x/CGRectGetWidth(recognizer.view.frame);
    progress = MIN(1, MAX(0, progress));
    if (recognizer.state == UIGestureRecognizerStateBegan){
        _isStart = YES;
        [self.controller.navigationController popViewControllerAnimated:YES];
        
    }else if (recognizer.state == UIGestureRecognizerStateChanged){
        [self updateInteractiveTransition:progress];
        
    }else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled){
        _isStart = NO;
        if (progress > 0.4) {
            [self finishInteractiveTransition];
        }else{
            [self cancelInteractiveTransition];
        }
    }
}

@end
