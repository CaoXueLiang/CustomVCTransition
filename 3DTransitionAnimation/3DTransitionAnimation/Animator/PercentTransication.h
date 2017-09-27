//
//  PercentTransication.h
//  3DTransitionAnimation
//
//  Created by bjovov on 2017/9/27.
//  Copyright © 2017年 CaoXueLiang.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,PercentType){
    PercentTypePush,
    PercentTypePop,
};

@interface PercentTransication : UIPercentDrivenInteractiveTransition
@property (nonatomic,assign) BOOL isStart;
@property (nonatomic,strong) UIViewController *controller;
+ (instancetype)initWithController:(UIViewController *)controller type:(PercentType)type;
@end
