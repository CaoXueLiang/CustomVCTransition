//
//  CheckerBoardAniamtor.h
//  CheckerBoardAniamtion
//
//  Created by 曹学亮 on 2017/10/8.
//  Copyright © 2017年 曹学亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,AniamtionType) {
    AniamtionTypePush,
    AniamtionTypePop,
};

@interface CheckerBoardAniamtor : NSObject<UIViewControllerAnimatedTransitioning>
- (instancetype)initWithType:(AniamtionType)type;
@end
