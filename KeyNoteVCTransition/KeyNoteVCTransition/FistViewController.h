//
//  FistViewController.h
//  KeyNoteVCTransition
//
//  Created by bjovov on 2017/9/26.
//  Copyright © 2017年 CaoXueLiang.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FistViewController : UIViewController
@property (nonatomic,strong) UICollectionView *myCollection;
@property (nonatomic,strong) NSIndexPath *selectIndexPath;
@property (nonatomic,assign) CGRect finalCellRect;
@end
