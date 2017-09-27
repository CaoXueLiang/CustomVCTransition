//
//  PercentTransition.m
//  CircleSpreadTransition
//
//  Created by bjovov on 2017/9/27.
//  Copyright © 2017年 曹学亮. All rights reserved.
//

#import "PercentTransition.h"

@interface PercentTransition()
@property (nonatomic,strong) UIViewController *controller;
@property (nonatomic,assign) CGRect rect;
@end

@implementation PercentTransition
#pragma mark - Init Menthod
+ (instancetype)initWithController:(UIViewController *)controller{
    PercentTransition *model = [[PercentTransition alloc]init];
    model.controller = controller;
    model.rect = controller.view.bounds;
    [model addGesture:controller];
    return model;
}

- (void)addGesture:(UIViewController *)controller{
    UIScreenEdgePanGestureRecognizer *gesture = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(edgepan:)];
    gesture.edges = UIRectEdgeLeft;
    [controller.view addGestureRecognizer:gesture];
}

- (void)edgepan:(UIScreenEdgePanGestureRecognizer *)recognizer{
    CGPoint current = [recognizer translationInView:recognizer.view];
    CGFloat progress = current.x/self.rect.size.width;
    progress = MIN(1, MAX(0, progress));
    NSLog(@"%f",progress);
    if (recognizer.state == UIGestureRecognizerStateBegan){
        _isStart = YES;
        [self.controller.navigationController popViewControllerAnimated:YES];
        
    }else if (recognizer.state == UIGestureRecognizerStateChanged){
        [self updateInteractiveTransition:progress];
        
    }else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled){
        _isStart = NO;
        if (progress > 0.4){
            [self finishInteractiveTransition];
        }else{
            [self cancelInteractiveTransition];
        }
    }
}

@end
