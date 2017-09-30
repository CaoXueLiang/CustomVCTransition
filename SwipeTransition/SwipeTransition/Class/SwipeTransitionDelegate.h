//
//  SwipeTransitionDelegate.h
//  SwipeTransition
//
//  Created by bjovov on 2017/9/30.
//  Copyright © 2017年 CaoXueLiang.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SwipeTransitionDelegate : NSObject<UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) UIScreenEdgePanGestureRecognizer *gestureRecognizer;
@property (nonatomic, readwrite) UIRectEdge targetEdge;
@end
