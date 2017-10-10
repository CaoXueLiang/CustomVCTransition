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
@property (nonatomic,strong) UIButton *dissMissButton;
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
    self.navigationItem.title = @"Second";
    
    [self.view addSubview:self.dissMissButton];
    self.dissMissButton.frame = CGRectMake(0, 0, 150, 30);
    self.dissMissButton.center = CGPointMake(self.view.center.x, CGRectGetHeight(self.view.frame) - 100);
    
    [self.view addGestureRecognizer:self.recognizer];
}

#pragma mark - Event Response
- (void)DissMiss{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)disMiss:(UIScreenEdgePanGestureRecognizer *)recognizer{
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        SwipeTransitionDelegate *delegate = self.transitioningDelegate;
        delegate.gestureRecognizer = self.recognizer;
        delegate.targetEdge = UIRectEdgeLeft;
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
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

- (UIButton *)dissMissButton{
    if (!_dissMissButton) {
        _dissMissButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_dissMissButton setTitle:@"DissMiss" forState:UIControlStateNormal];
        [_dissMissButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        _dissMissButton.titleLabel.font = [UIFont systemFontOfSize:18];
        [_dissMissButton addTarget:self action:@selector(DissMiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dissMissButton;
}

- (UIScreenEdgePanGestureRecognizer *)recognizer{
    if (!_recognizer) {
        _recognizer = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(disMiss:)];
        _recognizer.edges = UIRectEdgeLeft;
    }
    return _recognizer;
}

@end

