//
//  CollectionViewCell.m
//  UICollectionViewVertical
//
//  Created by MAC on 2018/11/14.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "CollectionViewCell.h"
// 屏幕比例
#define SCREEN_RATE       ([UIScreen mainScreen].bounds.size.width/375.0)
#define rowMargin 10 //每一行item之间的间距
#define columnMargin 10 //每一列item之间的间距
#define rowNum 3//每行cell个数
@interface CollectionViewCell()
@property (nonatomic, strong) UIImageView *itemIcon;
@end

@implementation CollectionViewCell

@synthesize itemModel = _itemModel;

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor clearColor];
        [self initView];
    }
    return self;
}

- (void)initView {
    _itemIcon = [[UIImageView alloc] init];
    [self.contentView addSubview:_itemIcon];
    _itemIcon.backgroundColor = [UIColor clearColor];
    _itemIcon.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height);
    _itemIcon.center = self.contentView.center;
}

//- (void)layoutSubviews {
//    _itemIcon.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height);
//}

- (CollModel *)itemModel{
    return _itemModel;
}

- (void)setItemModel:(CollModel *)itemModel
{
    if (!itemModel) {
        return;
    }
    _itemModel = itemModel;
    [self setCellWithModel:_itemModel];
}

- (void)setHeight:(CGFloat )height {
    _height = height;
    _itemIcon.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.height);
}


- (void)setCellWithModel:(CollModel *)itemModel{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        _itemIcon.image = [UIImage imageNamed:itemModel.url];
    }];
}



@end
