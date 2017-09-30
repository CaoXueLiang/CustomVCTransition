//
//  InteractiveModel.h
//  TabBarControllerSlipTransition
//
//  Created by bjovov on 2017/9/30.
//  Copyright © 2017年 CaoXueLiang.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InteractiveModel : UIPercentDrivenInteractiveTransition
@property (nonatomic,assign) BOOL isStart;
- (instancetype)initWithGesture:(UITabBarController *)tarBar;
@end
