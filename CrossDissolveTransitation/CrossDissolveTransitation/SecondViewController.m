//
//  SecondViewController.m
//  PresentControllerTransition
//
//  Created by bjovov on 2017/9/28.
//  Copyright © 2017年 CaoXueLiang.cn. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()
@property (nonatomic,strong) UILabel *tipLabel;;
@property (nonatomic,strong) UIButton *dissButton;
@end

@implementation SecondViewController
#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor orangeColor]colorWithAlphaComponent:0.3];
    [self.view addSubview:self.tipLabel];
    self.tipLabel.frame = CGRectMake(0, 0, 100, 100);
    self.tipLabel.center = self.view.center;
    
    [self.view addSubview:self.dissButton];
    self.dissButton.frame = CGRectMake(0, 0, 100, 30);
    self.dissButton.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetHeight(self.view.frame) - 100);
}

- (void)disMiss{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - Setter && Getter
- (UILabel *)tipLabel{
    if (!_tipLabel) {
        _tipLabel = [UILabel new];
        _tipLabel.text = @"B";
        _tipLabel.textColor = [UIColor orangeColor];
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

