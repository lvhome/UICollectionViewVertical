//
//  CollectionViewCell.h
//  UICollectionViewVertical
//
//  Created by MAC on 2018/11/14.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollModel.h"

@interface CollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) CollModel * itemModel;
@property (nonatomic, assign) CGFloat height;
@end
