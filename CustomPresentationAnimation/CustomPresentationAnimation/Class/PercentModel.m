//
//  PercentModel.m
//  CustomPresentationAnimation
//
//  Created by bjovov on 2017/10/10.
//  Copyright © 2017年 CaoXueLiang.cn. All rights reserved.
//

#import "PercentModel.h"

@interface PercentModel()
@property (nonatomic,strong) UIViewController *controller;
@end

@implementation PercentModel
#pragma mark - Init
- (instancetype)initWithController:(UIViewController *)controller{
    self = [super init];
    if (self) {
        _controller = controller;
        [self addGesture];
    }
    return self;
}

- (void)addGesture{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGesture:)];
    [_controller.view addGestureRecognizer:pan];
}

- (void)panGesture:(UIPanGestureRecognizer *)recognizer{
    CGPoint currentPoint = [recognizer translationInView:recognizer.view];
    CGFloat progress = currentPoint.y/340.0;
    progress = MIN(1, MAX(0, progress));
    NSLog(@"%@",NSStringFromCGPoint(currentPoint));
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        [_controller dismissViewControllerAnimated:YES completion:NULL];
        
    }else if (recognizer.state == UIGestureRecognizerStateChanged){
        [self updateInteractiveTransition:progress];
        
    }else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled){
        if (progress > 0.5) {
            [self finishInteractiveTransition];
        }else{
            [self cancelInteractiveTransition];
        }
    }
}

@end
