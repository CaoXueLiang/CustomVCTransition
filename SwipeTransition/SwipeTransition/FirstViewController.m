//
//  FirstViewController.m
//  PresentControllerTransition
//
//  Created by bjovov on 2017/9/28.
//  Copyright © 2017年 CaoXueLiang.cn. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "SwipeTransitionDelegate.h"

@interface FirstViewController ()
@property (nonatomic,strong) UILabel *tipLabel;
@property (nonatomic,strong) UIScreenEdgePanGestureRecognizer *recognizer;
@property (nonatomic,strong) UIButton *button;
@property (nonatomic,strong) SwipeTransitionDelegate *delegate;
@end

@implementation FirstViewController
#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:self.tipLabel];
    self.tipLabel.frame = CGRectMake(0, 0, 100, 100);
    self.tipLabel.center = self.view.center;
    self.navigationItem.title = @"First";
    
    [self.view addSubview:self.button];
    self.button.frame = CGRectMake(0, 0, 150, 30);
    self.button.center = CGPointMake(self.view.center.x, CGRectGetHeight(self.view.frame) - 100);
    
    _recognizer = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    _recognizer.edges = UIRectEdgeRight;
    [self.view addGestureRecognizer:_recognizer];
}

#pragma mark - Event Response
- (void)buttonClicked{
    SecondViewController *controller = [[SecondViewController alloc]init];
    controller.transitioningDelegate = self.delegate;
    [self presentViewController:controller animated:YES completion:NULL];
}

- (void)pan:(UIScreenEdgePanGestureRecognizer *)recognizer{
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        SecondViewController *controller = [[SecondViewController alloc]init];
        self.delegate.targetEdge = UIRectEdgeRight;
        self.delegate.gestureRecognizer = recognizer;
        controller.transitioningDelegate = self.delegate;
        [self presentViewController:controller animated:YES completion:NULL];
    }
}

#pragma mark - Setter && Getter
- (UILabel *)tipLabel{
    if (!_tipLabel) {
        _tipLabel = [UILabel new];
        _tipLabel.text = @"A";
        _tipLabel.textColor = [UIColor orangeColor];
        _tipLabel.font = [UIFont systemFontOfSize:120];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _tipLabel;
}

- (UIButton *)button{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setTitle:@"Present" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _button.titleLabel.font = [UIFont systemFontOfSize:24];
        [_button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

- (SwipeTransitionDelegate *)delegate{
    if (!_delegate) {
        _delegate = [[SwipeTransitionDelegate alloc]init];
    }
    return _delegate;
}

@end

