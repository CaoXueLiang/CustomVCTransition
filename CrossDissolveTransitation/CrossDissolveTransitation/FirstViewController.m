//
//  FirstViewController.m
//  PresentControllerTransition
//
//  Created by bjovov on 2017/9/28.
//  Copyright © 2017年 CaoXueLiang.cn. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "CrossDissolveAnimation.h"

@interface FirstViewController ()<UIViewControllerTransitioningDelegate>
@property (nonatomic,strong) UILabel *tipLabel;;
@property (nonatomic,strong) UIButton *presentButton;
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
}

- (void)present{
    SecondViewController *controller = [[SecondViewController alloc]init];
    controller.modalPresentationStyle = UIModalPresentationFullScreen;
    controller.transitioningDelegate = self;
    [self presentViewController:controller animated:YES completion:NULL];
}

#pragma mark - UIViewControllerTransitioningDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [CrossDissolveAnimation new];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return [CrossDissolveAnimation new];
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

@end
