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
    
}

@end
