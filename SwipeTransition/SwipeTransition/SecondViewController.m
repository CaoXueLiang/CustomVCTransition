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
@property (nonatomic,strong) UIScreenEdgePanGestureRecognizer *recognizer;
@property (nonatomic,strong) UIButton *button;
@end

@implementation SecondViewController
#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *container = [[UIView alloc]initWithFrame:self.view.bounds];
    container.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:container];
    
    [self.view addSubview:self.tipLabel];
    self.tipLabel.frame = CGRectMake(0, 0, 100, 100);
    self.tipLabel.center = self.view.center;
    self.navigationItem.title = @"Second";
    
    [self.view addSubview:self.button];
    self.button.frame = CGRectMake(0, 0, 150, 30);
    self.button.center = CGPointMake(self.view.center.x, CGRectGetHeight(self.view.frame) - 100);
    
    _recognizer = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    _recognizer.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:_recognizer];
}

#pragma mark - Event Response
- (void)buttonClicked{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)pan:(UIScreenEdgePanGestureRecognizer *)recognizer{
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        SwipeTransitionDelegate* delegate = self.transitioningDelegate;
        delegate.targetEdge = UIRectEdgeLeft;
        delegate.gestureRecognizer = recognizer;
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

- (UIButton *)button{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setTitle:@"dissMiss" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _button.titleLabel.font = [UIFont systemFontOfSize:24];
        [_button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

@end

