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
+ (instancetype)initWithController:(UIViewController *)controller type:(PercentType)type{
    PercentTransication *model = [[PercentTransication alloc]init];
    model.controller = controller;
    if(type == PercentTypePush){
        [model addPushGesture:controller];
    }else if (type == PercentTypePop){
        [model addPopGesture:controller];
    }
    return model;
}

- (void)addPushGesture:(UIViewController *)controller{
    UIScreenEdgePanGestureRecognizer *gesture = [UIScreenEdgePanGestureRecognizer alloc][initWithTarget:self action:@selector(rightPan:)];
    gesture.edges = UIRectEdgeRight;
    [controller.view addGestureRecognizer:gesture];
}

- (void)addPopGesture:(UIViewController *)controller{
    UIScreenEdgePanGestureRecognizer *gesture = [UIScreenEdgePanGestureRecognizer alloc][initWithTarget:self action:@selector(leftPan:)];
    gesture.edges = UIRectEdgeLeft;
    [controller.view addGestureRecognizer:gesture];
}

- (void)rightPan:(UIScreenEdgePanGestureRecognizer *)recognizer{
    CGPoint currentPoint = [recognizer translationInView:recognizer.view];
    CGFloat progress = currentPoint.x/CGRectGetWidth(recognizer.view.frame);
    progress = MIN(1, MAX(0, progress));
    if (recognizer.state == UIGestureRecognizerStateBegan){
        _isStart = YES;
   
    }else if (recognizer.state == UIGestureRecognizerStateChanged){
        
    }else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled){
        
    }
}

- (void)leftPan:(UIScreenEdgePanGestureRecognizer *)recognizer{
    
}

@end
