//
//  PercentModel.h
//  SwipeTransition
//
//  Created by bjovov on 2017/9/29.
//  Copyright © 2017年 CaoXueLiang.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,GestureDirection) {
    GestureDirectionLeft,
    GestureDirectionRight,
};

@interface PercentModel : UIPercentDrivenInteractiveTransition
@property (nonatomic,assign) GestureDirection type;
@property (nonatomic,strong) UIViewController *controller;
@property (nonatomic,assign) BOOL leftIsStart;
@property (nonatomic,assign) BOOL rightIsStart;
- (instancetype)initWithController:(UIViewController *)controller type:(GestureDirection)type;
@end
