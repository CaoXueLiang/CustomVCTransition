//
//  SecondViewController.m
//  CircleSpreadTransition
//
//  Created by 曹学亮 on 2017/9/26.
//  Copyright © 2017年 曹学亮. All rights reserved.
//

#import "SecondViewController.h"
#import "CircleTransitionAnimator.h"
#import "FirstViewController.h"
#import "PercentTransition.h"

@interface SecondViewController ()<UINavigationControllerDelegate>
@property (nonatomic,strong) UIImageView *backImageView;
@property (nonatomic,strong) UIButton *backButton;
@property (nonatomic,strong) PercentTransition *model;
@end

@implementation SecondViewController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.backImageView];
    self.backImageView.frame = self.view.bounds;
    
    [self.view addSubview:self.backButton];
    self.backButton.frame = CGRectMake(10, 20, 50, 50);

    _model = [PercentTransition initWith:self];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}

- (void)backClicked{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UINavigationControllerDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC{
    if (operation == UINavigationControllerOperationPop && [toVC isKindOfClass:[FirstViewController class]]){
        return [CircleTransitionAnimator initWithType:AnimationTypePop];
    }else{
        return nil;
    }
}

- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController{
    
    //手势开始的时候才需要传入手势过渡代理，如果直接点击pop，应该传入空，否者无法通过点击正常pop
    return _model.isStart ? _model : nil;
}

#pragma mark - Setter && Getter
- (UIImageView *)backImageView{
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"pic2"]];
    }
    return _backImageView;
}

- (UIButton *)backButton{
    if (!_backButton){
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
       [_backButton addTarget:self action:@selector(backClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

@end

