//
//  LayerAnimation.h
//  3DTransitionAnimation
//
//  Created by bjovov on 2017/10/12.
//  Copyright © 2017年 CaoXueLiang.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,type) {
    typePush,
    typePop,
};

/**
 使用layer动画进行变换
 */
@interface LayerAnimation : NSObject<UIViewControllerAnimatedTransitioning>
@property (nonatomic,assign) type animationType;
@property (nonatomic,strong) UIView *fromView;
@property (nonatomic,strong) UIView *toView;
@property (nonatomic,strong) id <UIViewControllerContextTransitioning> transitionContext;
+ (instancetype)initWithType:(type)animationType;
@end
