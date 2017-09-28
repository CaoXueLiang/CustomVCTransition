//
//  SecondController.m
//  3DTransitionAnimation
//
//  Created by bjovov on 2017/9/27.
//  Copyright © 2017年 CaoXueLiang.cn. All rights reserved.
//

#import "SecondController.h"
#import "TranstionAnimator.h"
#import "FirstController.h"
#import "PercentTransication.h"

@interface SecondController()<UINavigationControllerDelegate>
@property (nonatomic,strong) UIButton *popButton;
@property (nonatomic,strong) PercentTransication *percentModel;
@end

@implementation SecondController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.popButton];
    self.popButton.frame = CGRectMake(0, 0, 50, 50);
    self.popButton.center = self.view.center;
    
    _percentModel = [PercentTransication initWithController:self];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}

- (void)pop{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UINavigationControllerDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC{
    
    if (operation == UINavigationControllerOperationPop && [toVC isKindOfClass:[FirstController class]]){
        return [TranstionAnimator initWithType:AnimationTypePop];
    }else{
        return nil;
    }
}

- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController{
    
    return _percentModel.isStart ? _percentModel : nil;
}

#pragma mark - Setter && Getter
- (UIButton *)popButton{
    if(!_popButton){
        _popButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_popButton setTitle:@"Pop" forState:UIControlStateNormal];
        [_popButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_popButton addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    }
    return _popButton;
}


@end
