//
//  PercentModel.m
//  SwipeTransition
//
//  Created by bjovov on 2017/9/29.
//  Copyright © 2017年 CaoXueLiang.cn. All rights reserved.
//

#import "PercentModel.h"


@implementation PercentModel
#pragma mark - Init
- (instancetype)initWithController:(UIViewController *)controller type:(GestureDirection)type{
    PercentModel *model = [[PercentModel alloc]init];
    model.controller = controller;
    if (type == GestureDirectionLeft) {
        [self addLeftGesture:controller];
    }else if (type == GestureDirectionRight){
        [self addRightGesture:controller];
    }
    return model;
}

- (void)addLeftGesture:(UIViewController *)controller{
    UIScreenEdgePanGestureRecognizer *pan = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(leftPan:)];
    pan.edges = UIRectEdgeLeft;
    [controller.view addGestureRecognizer:pan];
}

- (void)addRightGesture:(UIViewController *)controller{
    UIScreenEdgePanGestureRecognizer *pan = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(rightPan:)];
    pan.edges = UIRectEdgeRight;
    [controller.view addGestureRecognizer:pan];
}

#pragma mark - Event Response
- (void)leftPan:(UIScreenEdgePanGestureRecognizer *)recognizer{
    CGPoint point = [recognizer locationInView:recognizer.view];
    CGFloat progress = point.x/CGRectGetWidth(recognizer.view.bounds);
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        _leftIsStart = YES;
        [self.controller dismissViewControllerAnimated:YES completion:NULL];
        
    }else if (recognizer.state == UIGestureRecognizerStateChanged){
        [self updateInteractiveTransition:progress];
        
    }else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled){
        _leftIsStart = NO;
        if (progress > 0.4) {
            [self finishInteractiveTransition];
        }else{
            [self cancelInteractiveTransition];
        }
    }
}

- (void)rightPan:(UIScreenEdgePanGestureRecognizer *)recognizer{
    CGPoint point = [recognizer locationInView:recognizer.view];
    CGFloat progress = point.x/CGRectGetWidth(recognizer.view.bounds);
    if (recognizer.state == UIGestureRecognizerStateBegan) {
//        _rightIsStart = YES;
//        SecondViewController *controller = [[SecondViewController alloc]init];
//        controller.modalPresentationStyle = UIModalPresentationFullScreen;
//        controller.transitioningDelegate = self;
//        [self presentViewController:controller animated:YES completion:NULL];
        
    }else if (recognizer.state == UIGestureRecognizerStateChanged){
        [self updateInteractiveTransition:progress];
        
    }else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled){
        _rightIsStart = NO;
        if (progress > 0.4) {
            [self finishInteractiveTransition];
        }else{
            [self cancelInteractiveTransition];
        }
    }
}

@end

