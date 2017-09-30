//
//  RootTarbarController.m
//  TabBarControllerSlipTransition
//
//  Created by bjovov on 2017/9/30.
//  Copyright © 2017年 CaoXueLiang.cn. All rights reserved.
//

#import "RootTarbarController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "TransitionAnimator.h"
#import "InteractiveModel.h"

@interface RootTarbarController ()<UITabBarControllerDelegate>
@property (nonatomic,strong) InteractiveModel *model;
@end

@implementation RootTarbarController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    UINavigationController *first = [[UINavigationController alloc]initWithRootViewController:[[FirstViewController alloc]init]];
    first.tabBarItem.title = @"first";
    UINavigationController *second = [[UINavigationController alloc]initWithRootViewController:[[SecondViewController alloc]init]];
    second.tabBarItem.title = @"second";
    UINavigationController *third = [[UINavigationController alloc]initWithRootViewController:[[ThirdViewController alloc]init]];
    third.tabBarItem.title = @"third";
    self.viewControllers = @[first,second,third];
    self.delegate = self;
}

#pragma mark - UITabBarControllerDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController animationControllerForTransitionFromViewController:(UIViewController *)fromVC
                                                       toViewController:(UIViewController *)toVC{
    
    NSArray *viewControllers = self.viewControllers;
    if ([viewControllers indexOfObject:fromVC] > [viewControllers indexOfObject:toVC]) {
        return [[TransitionAnimator alloc]initWithEdge:UIRectEdgeLeft];
    }else{
        return [[TransitionAnimator alloc]initWithEdge:UIRectEdgeRight];
    }
}

@end
