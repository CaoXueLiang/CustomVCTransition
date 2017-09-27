//
//  DetailController.m
//  KeyNoteVCTransition
//
//  Created by bjovov on 2017/9/26.
//  Copyright © 2017年 CaoXueLiang.cn. All rights reserved.
//

#import "DetailController.h"
#import <Masonry/Masonry.h>
#import "MagicMoveAnimator.h"
#import "FistViewController.h"
#import "PercentDrivenTransition.h"

@interface DetailController()
@property (nonatomic,strong) PercentDrivenTransition *percent;
@end

@implementation DetailController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"详情";
    [self addSubViews];
    _percent = [PercentDrivenTransition initWithScreenEdgeGestureForController:self];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}

- (void)addSubViews{
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    [self.view addSubview:self.avatarImageView];
    self.avatarImageView.frame = CGRectMake(10, 10 + 64, width - 20, width-20);

    [self.view addSubview:self.textView];
    self.textView.frame = CGRectMake(30, CGRectGetMaxY(self.avatarImageView.frame) + 20, width - 60, height - CGRectGetMaxY(self.avatarImageView.frame) - 40);
}

#pragma mark - UINavigationControllerDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC{
    if ([toVC isKindOfClass:[FistViewController class]] && operation == UINavigationControllerOperationPop) {
        MagicMoveAnimator *transition = [MagicMoveAnimator initWithType:AnimationTypePop];
        return transition;
    }else{
        return nil;
    }
}

- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController{
    if ([animationController isKindOfClass:[MagicMoveAnimator class]]) {
        //手势开始的时候才需要传入手势过渡代理，如果直接点击pop，应该传入空，否者无法通过点击正常pop
        return _percent.isStart ? _percent : nil;
    }else{
        return nil;
    }
}

#pragma mark - Setter && Getter
- (UIImageView *)avatarImageView{
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xiaoxin"]];
    }
    return _avatarImageView;
}

- (UITextView *)textView{
    if (!_textView) {
        _textView = [[UITextView alloc]init];
        _textView.textColor = [UIColor blackColor];
        _textView.font = [UIFont systemFontOfSize:15];
        _textView.text = @"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.";
    }
    return _textView;
}
@end

