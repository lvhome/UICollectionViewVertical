//
//  LHViewController.m
//  UICollectionViewVertical
//
//  Created by MAC on 2018/11/14.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "LHViewController.h"
#import "LHCollerctionViewLayout.h"
#import "CollModel.h"

#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_RATE   ([UIScreen mainScreen].bounds.size.width/375.0)

#import "imageCell.h"
static NSString * const moreImageC = @"imageCell";
@interface LHViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) NSMutableArray * modelArray;
@property (nonatomic, strong) UICollectionView * moreCollectionView;

@end

@implementation LHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *appArray = [[self getDict] objectForKey:@"dictInfo"];
    for (int i = 0; i < appArray.count; i++) {
        NSDictionary * appDic = appArray[i];
        CollModel * model = [[CollModel alloc]init];
        model.title = [appDic objectForKey:@"title"];
        model.url = [appDic objectForKey:@"url"];
        [self.modelArray addObject:model];
    }
    [self createRightCollectionView];
    
}

- (NSDictionary *)getDict {
    NSString * string  = @"{\"dictInfo\":[{\"title\":\"你好啊\",\"url\":\"1.jpeg\"},{\"title\":\"你好啊\",\"url\":\"2.jpeg\"},{\"title\":\"你好啊\",\"url\":\"3.jpeg\"},{\"title\":\"你好啊\",\"url\":\"4.jpeg\"},{\"title\":\"你好啊\",\"url\":\"5.jpeg\"},{\"title\":\"你好啊\",\"url\":\"6.jpeg\"},{\"title\":\"是很好\",\"url\":\"7.jpeg\"},{\"title\":\"你好啊\",\"url\":\"1.jpeg\"},{\"title\":\"你好啊\",\"url\":\"2.jpeg\"},{\"title\":\"你好啊\",\"url\":\"3.jpeg\"},{\"title\":\"你好啊\",\"url\":\"4.jpeg\"},{\"title\":\"你好啊\",\"url\":\"5.jpeg\"},{\"title\":\"你好啊\",\"url\":\"6.jpeg\"},{\"title\":\"是很好\",\"url\":\"7.jpeg\"},{\"title\":\"你好啊\",\"url\":\"1.jpeg\"},{\"title\":\"你好啊\",\"url\":\"2.jpeg\"},{\"title\":\"你好啊\",\"url\":\"3.jpeg\"},{\"title\":\"你好啊\",\"url\":\"4.jpeg\"},{\"title\":\"你好啊\",\"url\":\"5.jpeg\"},{\"title\":\"你好啊\",\"url\":\"6.jpeg\"},{\"title\":\"是很好\",\"url\":\"7.jpeg\"}]}";
    NSDictionary *infoDic = [self dictionaryWithJsonString:string];
    return infoDic;
}


-(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers  error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}



- (NSMutableArray *)modelArray {
    if (!_modelArray) {
        _modelArray = [NSMutableArray array];
    }
    return _modelArray;
}


- (void)createRightCollectionView{
    LHCollerctionViewLayout * layout = [[LHCollerctionViewLayout alloc] init];
    _moreCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT * SCREEN_RATE) collectionViewLayout:layout];
    _moreCollectionView.backgroundColor = [UIColor clearColor];
    _moreCollectionView.tag = 22;
    _moreCollectionView.dataSource = self;
    _moreCollectionView.delegate = self;
    _moreCollectionView.alwaysBounceHorizontal = NO;
    _moreCollectionView.alwaysBounceVertical = YES;
    _moreCollectionView.backgroundColor = [UIColor colorWithRed:186 / 255.0 green:186 / 255.0 blue:186 / 255.0 alpha:0.9];
    _moreCollectionView.showsHorizontalScrollIndicator = NO;
    _moreCollectionView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_moreCollectionView];
    [_moreCollectionView registerClass:[imageCell class] forCellWithReuseIdentifier:moreImageC];
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.modelArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollModel * model = self.modelArray[indexPath.row];
    imageCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:moreImageC forIndexPath:indexPath];
    cell.itemModel = model;
    return cell;
}


#pragma mark - UICollectionViewDelegate点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CollModel * model = self.modelArray[indexPath.row];
    NSLog(@"self.appModelArray----%@",model.title);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
