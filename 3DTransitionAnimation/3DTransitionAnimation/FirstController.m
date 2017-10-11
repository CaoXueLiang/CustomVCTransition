//
//  FirstController.m
//  3DTransitionAnimation
//
//  Created by bjovov on 2017/9/27.
//  Copyright © 2017年 CaoXueLiang.cn. All rights reserved.
//

#import "FirstController.h"
#import "SecondController.h"
#import "TranstionAnimator.h"

@interface FirstController ()<UINavigationControllerDelegate>
@property (nonatomic,strong) UIImageView *backImageView;
@property (nonatomic,strong) UIButton *pushButton;
@end

@implementation FirstController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.backImageView];
    self.backImageView.frame = self.view.bounds;
    [self.view addSubview:self.pushButton];
    self.pushButton.frame = CGRectMake(0, 0, 50, 50);
    self.pushButton.center = self.view.center;
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}

- (void)push{
    SecondController *controller = [[SecondController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - UINavigationControllerDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC{
    if (operation == UINavigationControllerOperationPush) {
     return [TranstionAnimator initWithType:AnimationTypePush];
    }else{
        return nil;
    }
}

#pragma mark - Setter && Getter
- (UIImageView *)backImageView{
    if(!_backImageView){
        _backImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"pic1"]];
    }
    return _backImageView;
}

- (UIButton *)pushButton{
    if(!_pushButton){
        _pushButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_pushButton setTitle:@"Push" forState:UIControlStateNormal];
        [_pushButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_pushButton addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pushButton;
}

@end
