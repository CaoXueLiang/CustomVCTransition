//
//  FirstCollectionViewCell.m
//  KeyNoteVCTransition
//
//  Created by bjovov on 2017/9/26.
//  Copyright © 2017年 CaoXueLiang.cn. All rights reserved.
//

#import "FirstCollectionViewCell.h"
#import <Masonry/Masonry.h>

@implementation FirstCollectionViewCell
#pragma mark - init Menthod
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubViews];
    }
    return self;
}

- (void)addSubViews{
    CGFloat width = ([UIApplication sharedApplication].keyWindow.frame.size.width - 10)/2.0;
    [self.contentView addSubview:self.avatarimageView];
    self.avatarimageView.frame = CGRectMake(0, 0, width, width);
    
    [self.contentView addSubview:self.titleLabel];
    self.titleLabel.frame = CGRectMake(0, width, width, 45);
}

#pragma mark - Setter && Getter
- (UIImageView *)avatarimageView{
    if (!_avatarimageView) {
        _avatarimageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xiaoxin"]];
    }
    return _avatarimageView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"Label";
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.backgroundColor = [UIColor orangeColor];
    }
    return _titleLabel;
}

@end


