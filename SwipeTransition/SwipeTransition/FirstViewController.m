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
@property (nonatomic,strong) UIButton *presentButton;
@property (nonatomic,strong) SwipeTransitionDelegate *swipeDelegate;
@property (nonatomic,strong) UIScreenEdgePanGestureRecognizer *recognizer;
@end

@implementation FirstViewController
#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.tipLabel];
    self.tipLabel.frame = CGRectMake(0, 0, 100, 100);
    self.tipLabel.center = self.view.center;
    
    [self.view addSubview:self.presentButton];
    self.presentButton.frame = CGRectMake(0, 0, 100, 30);
    self.presentButton.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetHeight(self.view.frame) - 100);
    
    [self addGesture];
}

- (void)addGesture{
    _recognizer = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(edgePan:)];
    _recognizer.edges = UIRectEdgeRight;
    [self.view addGestureRecognizer:_recognizer];
}

#pragma mark - Event Response
- (void)edgePan:(UIScreenEdgePanGestureRecognizer *)recognizer{
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.swipeDelegate.gestureRecognizer = _recognizer;
        self.swipeDelegate.targetEdge = UIRectEdgeRight;
         [self present];
    }
}

- (void)present{
    SecondViewController *controller = [[SecondViewController alloc]init];
    controller.modalPresentationStyle = UIModalPresentationFullScreen;
    controller.transitioningDelegate = self.swipeDelegate;
    [self presentViewController:controller animated:YES completion:NULL];
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

- (UIButton *)presentButton{
    if (!_presentButton) {
        _presentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_presentButton setTitle:@"Present" forState:UIControlStateNormal];
        [_presentButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_presentButton addTarget:self action:@selector(present) forControlEvents:UIControlEventTouchUpInside];
    }
    return _presentButton;
}

- (SwipeTransitionDelegate *)swipeDelegate{
    if (!_swipeDelegate) {
        _swipeDelegate = [[SwipeTransitionDelegate alloc]init];
    }
    return _swipeDelegate;
}

@end

