//
//  FirstViewController.m
//  CircleSpreadTransition
//
//  Created by 曹学亮 on 2017/9/26.
//  Copyright © 2017年 曹学亮. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "CircleTransitionAnimator.h"

@interface FirstViewController ()<UINavigationControllerDelegate>
@property (nonatomic,strong) UIImageView *backImageView;
@end

@implementation FirstViewController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:YES];
    
    [self.view addSubview:self.backImageView];
    self.backImageView.frame = self.view.bounds;
    [self.view addSubview:self.targetButton];
    self.targetButton.frame = CGRectMake(0, 0, 60, 60);
    self.targetButton.center = self.view.center;
    
    [self addGesture];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}

- (void)addGesture{
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [self.targetButton addGestureRecognizer:panGesture];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC{
    if (operation == UINavigationControllerOperationPush && [toVC isKindOfClass:[SecondViewController class]]){
        return [CircleTransitionAnimator initWithType:AnimationTypePush];
    }else{
        return nil;
    }
}

#pragma mark - Event Response
- (void)pushToSecond{
    SecondViewController *controller = [[SecondViewController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)pan:(UIPanGestureRecognizer *)panGesture{
    CGPoint point = [panGesture translationInView:panGesture.view];
    CGPoint currentPoint = self.targetButton.center;
    if (panGesture.state == UIGestureRecognizerStateEnded){
        self.targetButton.center = CGPointMake(currentPoint.x + point.x, currentPoint.y + point.y);
    }
}

#pragma mark - Setter && Getter
- (UIImageView *)backImageView{
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"pic1"]];
    }
    return _backImageView;
}

- (UIButton *)targetButton{
    if (!_targetButton) {
        _targetButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _targetButton.backgroundColor = [UIColor colorWithRed:0 green:178/255.0 blue:1 alpha:1];
        [_targetButton setTitle:@"拖拽" forState:UIControlStateNormal];
        [_targetButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _targetButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [_targetButton addTarget:self action:@selector(pushToSecond) forControlEvents:UIControlEventTouchUpInside];
        _targetButton.layer.cornerRadius = 30.0;
        _targetButton.layer.masksToBounds = YES;
    }
    return _targetButton;
}
@end
