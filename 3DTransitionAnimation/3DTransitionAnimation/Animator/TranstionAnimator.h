//
//  TranstionAnimator.h
//  3DTransitionAnimation
//
//  Created by bjovov on 2017/9/27.
//  Copyright © 2017年 CaoXueLiang.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,AnimationType) {
    AnimationTypePush,
    AnimationTypePop,
};

@interface TranstionAnimator : NSObject<UIViewControllerAnimatedTransitioning>
+ (instancetype)initWithType:(AnimationType)type;
@end
