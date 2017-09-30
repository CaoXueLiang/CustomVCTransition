//
//  InteractiveModel.m
//  TabBarControllerSlipTransition
//
//  Created by bjovov on 2017/9/30.
//  Copyright © 2017年 CaoXueLiang.cn. All rights reserved.
//

#import "InteractiveModel.h"

@interface InteractiveModel()
@property (nonatomic,strong) UITabBarController *tarBar;
@property (nonatomic,assign) CGPoint originalPoint;
@property (nonatomic,assign) CGPoint currentPoint;
@property (nonatomic,weak) id <UIViewControllerContextTransitioning> transitionContext;
@end

@implementation InteractiveModel
#pragma mark - Init Menthod
- (instancetype)initWithGesture:(UITabBarController *)tarBar{
    self = [self init];
    if (self) {
        _tarBar = tarBar;
        [self addGesture:tarBar.view];
    }
    return self;
}

- (void)addGesture:(UIView *)view{
    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [view addGestureRecognizer:recognizer];
}

- (void)pan:(UIPanGestureRecognizer *)recognizer{
    CGPoint newPoint = [recognizer translationInView:recognizer.view];
    CGFloat progress = fabs(newPoint.x)/CGRectGetWidth(recognizer.view.bounds);
    progress = MIN(1, MAX(0, progress));
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        _isStart = YES;
        if (newPoint.x > 0 && self.tarBar.selectedIndex > 0) {
            self.tarBar.selectedIndex--;
        }else if (newPoint.x < 0 && self.tarBar.selectedIndex < self.tarBar.viewControllers.count){
            self.tarBar.selectedIndex++;
        }
        
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
