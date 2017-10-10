//
//  FirstViewController.m
//  CustomPresentationAnimation
//
//  Created by bjovov on 2017/10/10.
//  Copyright © 2017年 CaoXueLiang.cn. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"

@interface FirstViewController ()
@property (nonatomic,strong) UILabel *tipLabel;
@property (nonatomic,strong) UIButton *button;
@end

@implementation FirstViewController
#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.tipLabel];
    self.tipLabel.frame = CGRectMake(0, 0, 100, 100);
    self.tipLabel.center = self.view.center;
    
    [self.view addSubview:self.button];
    self.button.frame = CGRectMake(0, 0, 150, 30);
    self.button.center = CGPointMake(self.view.center.x, CGRectGetHeight(self.view.frame) - 100);
    self.navigationItem.title = @"First";
}

#pragma mark - Event Response
- (void)present{
    SecondViewController *controller = [[SecondViewController alloc]init];
    [self presentViewController:controller animated:YES completion:NULL];
}

#pragma mark - Setter && Getter
- (UILabel *)tipLabel{
    if (!_tipLabel) {
        _tipLabel = [UILabel new];
        _tipLabel.text = @"A";
        _tipLabel.textColor = [UIColor yellowColor];
        _tipLabel.font = [UIFont systemFontOfSize:120];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _tipLabel;
}

- (UIButton *)button{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setTitle:@"custom Present" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        _button.titleLabel.font = [UIFont systemFontOfSize:18];
        [_button addTarget:self action:@selector(present) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

@end

