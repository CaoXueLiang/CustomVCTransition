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
@property (nonatomic,strong) SwipeTransitionDelegate *customDelegate;
@property (nonatomic,strong) UIScreenEdgePanGestureRecognizer *recognizer;
@end

@implementation FirstViewController
#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.tipLabel];
    self.tipLabel.frame = CGRectMake(0, 0, 100, 100);
    self.tipLabel.center = self.view.center;
    self.navigationItem.title = @"First";
    
    [self.view addSubview:self.presentButton];
    self.presentButton.frame = CGRectMake(0, 0, 150, 30);
    self.presentButton.center = CGPointMake(self.view.center.x, CGRectGetHeight(self.view.frame) - 100);
    
    [self.view addGestureRecognizer:self.recognizer];
}

#pragma mark - Event Response
- (void)present{
    SecondViewController *controller = [[SecondViewController alloc]init];
    self.customDelegate.targetEdge = UIRectEdgeRight;
    controller.transitioningDelegate = self.customDelegate;
    [self presentViewController:controller animated:YES completion:NULL];
}

- (void)present:(UIScreenEdgePanGestureRecognizer *)recognizer{
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        SecondViewController *controller = [[SecondViewController alloc]init];
        self.customDelegate.targetEdge = UIRectEdgeRight;
        self.customDelegate.gestureRecognizer = self.recognizer;
        controller.transitioningDelegate = self.customDelegate;
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

- (UIButton *)presentButton{
    if (!_presentButton) {
        _presentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_presentButton setTitle:@"Present" forState:UIControlStateNormal];
        [_presentButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        _presentButton.titleLabel.font = [UIFont systemFontOfSize:18];
        [_presentButton addTarget:self action:@selector(present) forControlEvents:UIControlEventTouchUpInside];
    }
    return _presentButton;
}

- (SwipeTransitionDelegate *)customDelegate{
    if (!_customDelegate) {
        _customDelegate = [[SwipeTransitionDelegate alloc]init];
    }
    return _customDelegate;
}

- (UIScreenEdgePanGestureRecognizer *)recognizer{
    if (!_recognizer) {
        _recognizer = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(present:)];
        _recognizer.edges = UIRectEdgeRight;
    }
    return _recognizer;
}

@end

