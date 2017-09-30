//
//  PercentModel.m
//  SwipeTransition
//
//  Created by bjovov on 2017/9/29.
//  Copyright © 2017年 CaoXueLiang.cn. All rights reserved.
//

#import "PercentModel.h"

@interface PercentModel()
@property (nonatomic, weak) id<UIViewControllerContextTransitioning> transitionContext;
@property (nonatomic, strong, readonly) UIScreenEdgePanGestureRecognizer *gestureRecognizer;
@property (nonatomic, readonly) UIRectEdge edge;
@end

@implementation PercentModel
#pragma mark - Init Menthod
- (instancetype)initWithGesture:(UIScreenEdgePanGestureRecognizer *)recognizer edge:(UIRectEdge)edge{
    self = [self init];
    if (self) {
        _gestureRecognizer = recognizer;
        _edge = edge;
        [_gestureRecognizer addTarget:self action:@selector(gestureRecognizeDidUpdate:)];
    }
    return self;
}

- (void)dealloc{
    [_gestureRecognizer removeTarget:self action:@selector(gestureRecognizeDidUpdate:)];
}

#pragma mark - UIViewControllerInteractiveTransitioning
- (void)startInteractiveTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    //将转场上下文记录下来
    self.transitionContext = transitionContext;
    [super startInteractiveTransition:transitionContext];
}

- (void)gestureRecognizeDidUpdate:(UIScreenEdgePanGestureRecognizer *)recognizer{
    UIView *transitionContainerView = self.transitionContext.containerView;
    CGFloat width = CGRectGetWidth(transitionContainerView.bounds);
    CGPoint currentPoint = [recognizer locationInView:transitionContainerView];
    
    CGFloat progress = 0;
    if (_edge == UIRectEdgeLeft) {
        progress = currentPoint.x/width;
    }else if (_edge == UIRectEdgeRight){
        progress = (width - currentPoint.x)/width;
    }
    progress = MIN(1, MAX(0, progress));
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
      
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


