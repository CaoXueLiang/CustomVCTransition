//
//  FirstViewController.m
//  PresentControllerTransition
//
//  Created by bjovov on 2017/9/28.
//  Copyright © 2017年 CaoXueLiang.cn. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"

@interface FirstViewController ()
@property (nonatomic,strong) UILabel *tipLabel;
@property (nonatomic,strong) UIScreenEdgePanGestureRecognizer *recognizer;
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
    
    _recognizer = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    _recognizer.edges = UIRectEdgeRight;
    [self.view addGestureRecognizer:_recognizer];
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

@end

