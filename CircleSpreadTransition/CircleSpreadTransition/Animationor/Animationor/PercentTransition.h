//
//  PercentTransition.h
//  CircleSpreadTransition
//
//  Created by bjovov on 2017/9/27.
//  Copyright © 2017年 曹学亮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PercentTransition : UIPercentDrivenInteractiveTransition
+ (instancetype)initWithController:(UIViewController *)controller;
@property (nonatomic,assign) BOOL isStart;
@end
