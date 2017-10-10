//
//  SecondViewController.m
//  CustomPresentationAnimation
//
//  Created by bjovov on 2017/10/10.
//  Copyright © 2017年 CaoXueLiang.cn. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()
@property (nonatomic,strong) UILabel *tipLabel;
@property (nonatomic,strong) UIButton *button;
@end

@implementation SecondViewController
#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor brownColor];
    [self.view addSubview:self.tipLabel];
  
    self.tipLabel.frame = CGRectMake(0, 0, 100, 100);
    self.tipLabel.center = CGPointMake(self.view.center.x, 150);
    self.navigationItem.title = @"Second";
    
    [self.view addSubview:self.button];
    self.button.frame = CGRectMake(0, 0, 150, 30);
    self.button.center = CGPointMake(self.view.center.x, 300);
}

#pragma mark - Event Response
- (void)dissmiss{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - Setter && Getter
- (UILabel *)tipLabel{
    if (!_tipLabel) {
        _tipLabel = [UILabel new];
        _tipLabel.text = @"B";
        _tipLabel.textColor = [UIColor yellowColor];
        _tipLabel.font = [UIFont systemFontOfSize:120];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _tipLabel;
}

- (UIButton *)button{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setTitle:@"Dissmiss" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        _button.titleLabel.font = [UIFont systemFontOfSize:18];
        [_button addTarget:self action:@selector(dissmiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

@end
