//
//  FistViewController.m
//  KeyNoteVCTransition
//
//  Created by bjovov on 2017/9/26.
//  Copyright © 2017年 CaoXueLiang.cn. All rights reserved.
//

#import "FistViewController.h"
#import "FirstCollectionViewCell.h"
#import "DetailController.h"
#import "MagicMoveAnimator.h"

@interface FistViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UINavigationControllerDelegate>

@end

@implementation FistViewController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"首页";
    [self.view addSubview:self.myCollection];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}

#pragma mark - UINavigationControllerDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC{
    if ([toVC isKindOfClass:[DetailController class]] && operation == UINavigationControllerOperationPush) {
        MagicMoveAnimator *transition = [MagicMoveAnimator initWithType:AnimationTypePush];
        return transition;
    }else{
        return nil;
    }
}

#pragma mark - UICollection M
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FirstCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FirstCollectionViewCell" forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    DetailController *controller = [[DetailController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - Setter && Getter
- (UICollectionView *)myCollection{
    if (!_myCollection) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        layout.itemSize = CGSizeMake((CGRectGetWidth(self.view.bounds) - 10)/2.0, (CGRectGetWidth(self.view.bounds) - 10)/2.0 + 45);
        _myCollection = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
        [_myCollection registerClass:[FirstCollectionViewCell class] forCellWithReuseIdentifier:@"FirstCollectionViewCell"];
        _myCollection.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _myCollection.delegate = self;
        _myCollection.dataSource = self;
    }
    return _myCollection;
}

@end
