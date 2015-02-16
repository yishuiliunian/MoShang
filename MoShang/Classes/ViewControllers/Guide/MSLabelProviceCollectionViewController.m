//
//  MSLabelProviceCollectionViewController.m
//  MoShang
//
//  Created by stonedong on 15/2/15.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSLabelProviceCollectionViewController.h"
#import "MSProvinceCollectionViewCell.h"
@interface MSLabelProviceCollectionViewController ()
{
    NSArray* _provinces;
    NSMutableDictionary* _selectedMap;
}
@end

@implementation MSLabelProviceCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    _selectedMap = [NSMutableDictionary new];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[MSProvinceCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    _provinces = @[@"山东",
                   @"河北", @"安徽", @"北京", @"重庆", @"福建", @"甘肃", @"广东", @"广西", @"贵州", @"海南", @"河南", @"黑龙江", @"湖北", @"吉林", @"江苏", @"江西", @"辽宁", @"内蒙古", @"宁夏", @"青海", @"山西", @"陕西", @"上海", @"四川", @"台湾", @"天津", @"西藏", @"新疆", @"云南", @"浙江"];
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _provinces.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MSProvinceCollectionViewCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    NSString* provice = _provinces[indexPath.row];
 
    cell.badgeView.text = _provinces[indexPath.row];
    BOOL selected = [_selectedMap[provice] boolValue];
    cell.mapSelected = selected;
    cell.backgroundColor = [UIColor grayColor];
    return cell;
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* provice = _provinces[indexPath.row];
    BOOL selected = [_selectedMap[provice] boolValue];
    MSProvinceCollectionViewCell* cell = (MSProvinceCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    cell.mapSelected = !selected;
    _selectedMap[provice] = @(!selected);
    
    [_chinaMap setProvince:provice selected:!selected];
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
