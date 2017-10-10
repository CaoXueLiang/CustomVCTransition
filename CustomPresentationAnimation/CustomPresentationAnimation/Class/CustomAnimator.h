//
//  CustomAnimator.h
//  CustomPresentationAnimation
//
//  Created by bjovov on 2017/10/10.
//  Copyright © 2017年 CaoXueLiang.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,AnimationType) {
    AnimationTypePresent,
    AnimationTypeDissmiss,
};
@interface CustomAnimator : NSObject<UIViewControllerAnimatedTransitioning>
- (instancetype)initWithType:(AnimationType)type;
@end
