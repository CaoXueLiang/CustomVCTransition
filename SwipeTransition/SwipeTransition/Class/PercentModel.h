//
//  PercentModel.h
//  SwipeTransition
//
//  Created by bjovov on 2017/9/29.
//  Copyright © 2017年 CaoXueLiang.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PercentModel : UIPercentDrivenInteractiveTransition
- (instancetype)initWithGesture:(UIScreenEdgePanGestureRecognizer *)recognizer edge:(UIRectEdge)edge;
@end
