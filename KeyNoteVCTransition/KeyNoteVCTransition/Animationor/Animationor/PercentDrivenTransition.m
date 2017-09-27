//
//  PercentDrivenTransition.m
//  KeyNoteVCTransition
//
//  Created by bjovov on 2017/9/26.
//  Copyright © 2017年 CaoXueLiang.cn. All rights reserved.
//

#import "PercentDrivenTransition.h"

@interface PercentDrivenTransition()
@property (nonatomic,strong) UIViewController *controller;
@end

@implementation PercentDrivenTransition
+ (instancetype)initWithScreenEdgeGestureForController:(UIViewController *)controller{
    PercentDrivenTransition *model = [[PercentDrivenTransition alloc]init];
    model.controller = controller;
    [model addGestureFor:controller];
    return model;
}

- (void)addGestureFor:(UIViewController *)controller{
    UIScreenEdgePanGestureRecognizer *pan = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(edgepan:)];
    pan.edges = UIRectEdgeLeft;
    [controller.view addGestureRecognizer:pan];
}

- (void)edgepan:(UIScreenEdgePanGestureRecognizer *)recognizer{
    CGPoint currentPoint = [recognizer translationInView:recognizer.view];
    CGFloat progress = currentPoint.x/CGRectGetWidth(recognizer.view.bounds);
    progress = MIN(1, MAX(progress, 0));
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        
        _isStart = YES;
        [self.controller.navigationController popViewControllerAnimated:YES];
        
    }else if (recognizer.state == UIGestureRecognizerStateChanged){
        //当手慢慢划入时，我们把总体手势划入的进度告诉 UIPercentDrivenInteractiveTransition 对象
        [self updateInteractiveTransition:progress];
        
    }else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled){
        _isStart = NO;
        if (progress > 0.3) {
            [self finishInteractiveTransition];
        }else{
            [self cancelInteractiveTransition];
        }
    }
}

@end
