//
//  LHCoustomCollectionLayout.m
//  UICollectionViewVertical
//
//  Created by MAC on 2018/11/14.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "LHCoustomCollectionLayout.h"

@interface LHCoustomCollectionLayout()
/** 这个字典用来存储每一列item的高度 */
@property (strong, nonatomic) NSMutableDictionary * itemDic;
/** 存放每一个item的布局属性 */
@property (strong, nonatomic) NSMutableArray * attrsArray;
@end

@implementation LHCoustomCollectionLayout

/** 懒加载 */
-(NSMutableDictionary *)itemDic
{
    if (!_itemDic)
    {
        _itemDic = [NSMutableDictionary dictionary];
    }
    return _itemDic;
}


/** 懒加载 */
-(NSMutableArray *)attrsArray
{
    if (!_attrsArray)
    {
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}

//初始化
-(instancetype)init
{
    if (self = [super init]){
        self.columnMargin = 10;
        self.rowMargin = 10;
        self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        self.columnCount = 3;
    }
    return self;
}

//每一次布局前的准备工作
-(void)prepareLayout
{
    [super prepareLayout];
    //清空最大的y值
    for (int i = 0; i < self.columnCount; i++)
    {
        NSString * column = [NSString stringWithFormat:@"%d",i];
        self.itemDic[column] = @(self.sectionInset.top);
    }
    
    //计算所有item的属性
    [self.attrsArray removeAllObjects];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int i= 0; i < count; i++)
    {
        UICollectionViewLayoutAttributes * attrs = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [self.attrsArray addObject:attrs];
    }
}

//设置collectionView滚动区域
-(CGSize)collectionViewContentSize
{
    //假设最长的那一列为第0列
    __block NSString *maxColumn = @"0";
    //遍历字典,找出最长的那一列
    [self.itemDic enumerateKeysAndObjectsUsingBlock:^(NSString *column, NSNumber *maxY, BOOL *stop) {
        if ([maxY floatValue] > [self.itemDic[maxColumn] floatValue])
        {
            maxColumn = column;
        }
    }];
    return CGSizeMake(0, [self.itemDic[maxColumn]floatValue]+self.sectionInset.bottom);
}

//允许每一次重新布局
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

//布局每一个属性
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //假设最短的那一列为第0列
    __block NSString *minColumn = @"0";
    //遍历字典,找出最短的那一列
    [self.itemDic enumerateKeysAndObjectsUsingBlock:^(NSString *column, NSNumber *maxY, BOOL *stop) {
        if ([maxY floatValue] < [self.itemDic[minColumn] floatValue])
        {
            minColumn = column;
        }
    }];
    
    //计算每一个item的宽度和高度
    CGFloat width = (self.collectionView.frame.size.width - self.columnMargin*(self.columnCount - 1) - self.sectionInset.left - self.sectionInset.right) / self.columnCount;
    CGFloat height = [self.delegate collerctionViewLayout:self heightForWidth:width andIndexPath:indexPath];
    //计算每一个item的位置
    CGFloat x = self.sectionInset.left + (width + self.columnMargin) * [minColumn floatValue];
    CGFloat y = [self.itemDic[minColumn] floatValue] + self.rowMargin;
    
    //更新这一列的y值
    self.itemDic[minColumn] = @(y + height);
    
    //创建布局属性
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    //设置item的frame
    attrs.frame = CGRectMake(x, y, width, height);
    
    return attrs;
}

//布局所有item的属性,包括header、footer
-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attrsArray;
}
@end

