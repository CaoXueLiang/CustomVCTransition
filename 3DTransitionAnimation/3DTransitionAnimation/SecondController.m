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

@interface SecondController()<UINavigationControllerDelegate>
@property (nonatomic,strong) UIButton *pushButton;
@end

@implementation SecondController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.pushButton];
    self.pushButton.frame = CGRectMake(0, 0, 50, 50);
    self.pushButton.center = self.view.center;
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

#pragma mark - Setter && Getter
- (UIButton *)pushButton{
    if(!_pushButton){
        _pushButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_pushButton setTitle:@"Pop" forState:UIControlStateNormal];
        [_pushButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_pushButton addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pushButton;
}


@end
