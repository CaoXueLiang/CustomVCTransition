//
//  CircleTransitionAnimator.h
//  CircleSpreadTransition
//
//  Created by 曹学亮 on 2017/9/26.
//  Copyright © 2017年 曹学亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger ,AnimationType) {
    AnimationTypePush,
    AnimationTypePop,
};

@interface CircleTransitionAnimator : NSObject<UIViewControllerAnimatedTransitioning>
@property (nonatomic,assign) AnimationType type;
+ (instancetype)initWithType:(AnimationType)type;
@end
