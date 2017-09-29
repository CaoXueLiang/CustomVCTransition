//
//  SwipAnimator.h
//  SwipeTransition
//
//  Created by bjovov on 2017/9/29.
//  Copyright © 2017年 CaoXueLiang.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger ,AnimationType) {
    AnimationTypePresent,
    AnimationTypeDissmiss,
};

@interface SwipAnimator : NSObject<UIViewControllerAnimatedTransitioning>
@property (nonatomic,assign) AnimationType type;
+ (instancetype)initWithType:(AnimationType)type;
@end
