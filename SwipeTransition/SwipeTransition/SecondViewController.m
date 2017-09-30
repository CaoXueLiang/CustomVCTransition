//
//  SecondViewController.m
//  PresentControllerTransition
//
//  Created by bjovov on 2017/9/28.
//  Copyright © 2017年 CaoXueLiang.cn. All rights reserved.
//

#import "SecondViewController.h"
#import "SwipeTransitionDelegate.h"

@interface SecondViewController ()
@property (nonatomic,strong) UILabel *tipLabel;
@property (nonatomic,strong) UIButton *dissButton;
@property (nonatomic,strong) UIScreenEdgePanGestureRecognizer *recognizer;
@end

@implementation SecondViewController
#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *container = [[UIView alloc]initWithFrame:self.view.bounds];
    container.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:container];
    
   // self.view.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.tipLabel];
    self.tipLabel.frame = CGRectMake(0, 0, 100, 100);
    self.tipLabel.center = self.view.center;
    
    [self.view addSubview:self.dissButton];
    self.dissButton.frame = CGRectMake(0, 0, 100, 30);
    self.dissButton.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetHeight(self.view.frame) - 100);
    
    [self addGesture];
}

- (void)addGesture{
    _recognizer = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(edgePan:)];
    _recognizer.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:_recognizer];
}

#pragma mark - Event Response
- (void)edgePan:(UIScreenEdgePanGestureRecognizer *)recognizer{
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        SwipeTransitionDelegate *delegate = self.transitioningDelegate;
        delegate.gestureRecognizer = _recognizer;
        delegate.targetEdge = UIRectEdgeLeft;
        [self disMiss];
    }
}

- (void)disMiss{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - Setter && Getter
- (UILabel *)tipLabel{
    if (!_tipLabel) {
        _tipLabel = [UILabel new];
        _tipLabel.text = @"B";
        _tipLabel.textColor = [UIColor whiteColor];
        _tipLabel.font = [UIFont systemFontOfSize:120];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _tipLabel;
}

- (UIButton *)dissButton{
    if (!_dissButton) {
        _dissButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_dissButton setTitle:@"DissMiss" forState:UIControlStateNormal];
        [_dissButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_dissButton addTarget:self action:@selector(disMiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dissButton;
}

@end

