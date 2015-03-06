//
//  MSMyCardViewController.m
//  MoShang
//
//  Created by stonedong on 15/1/28.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSMyCardViewController.h"
#import "MSUserInfo.h"
#import <DZProgramDefines.h>
#import "MSCardItem.h"
#import "MSCardItemCell.h"
@interface MSMyCardViewController ()
{
    NSArray* _cardInfoArray;
}
@end
@implementation MSMyCardViewController

INIT_DZ_EXTERN_STRING(kDZQianMing, 个性签名)
INIT_DZ_EXTERN_STRING(kDZMyTag, 个人标签)
INIT_DZ_EXTERN_STRING(kDZChengJiu, 旅行成就)
INIT_DZ_EXTERN_STRING(kDZMyStyle, 旅行Style)
INIT_DZ_EXTERN_STRING(kDZMyZuJi, 我的足迹)
INIT_DZ_EXTERN_STRING(kDZGuanzhu, 我的关注)
INIT_DZ_EXTERN_STRING(kDZMyXinxi, 我的信息)
INIT_DZ_EXTERN_STRING(kDZSocialNetWork, 社交网络)
- (void) viewDidLoad
{
    [super viewDidLoad];
    
    MSUserInfo* info;
    
    NSMutableArray* infos = [NSMutableArray new];
    
    void(^AddCard)(NSString* name, MSCardContent* content) = ^(NSString* name, MSCardContent* content) {
        MSCardItem* cardItem= [MSCardItem new];
        cardItem.title = name;
        cardItem.content = content;
        [infos addObject:cardItem];
    };

    
    void(^AddCartTemp)(NSString*name) = ^(NSString*name) {
        AddCard(name, [MSCardContent new]);
    };
    
    AddCartTemp(kDZQianMing);
    AddCartTemp(kDZMyTag);
    AddCartTemp(kDZChengJiu);
    AddCartTemp(kDZMyStyle);
    AddCartTemp(kDZMyZuJi);
    AddCartTemp(kDZGuanzhu);
    AddCartTemp(kDZMyXinxi);
    AddCartTemp(kDZSocialNetWork);
    
    _cardInfoArray = infos;
    [self.tableView reloadData];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _cardInfoArray.count;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    INIT_DZ_EXTERN_STRING(kDZCellIdentifier, xxxxxx)
    MSCardItemCell* cell = [tableView dequeueReusableCellWithIdentifier:kDZCellIdentifier];
    if (!cell) {
        cell = [[MSCardItemCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kDZCellIdentifier];
    }
    
    MSCardItem* item = _cardInfoArray[indexPath.row];
    cell.titleLabel.text = item.title;
    return cell;
}
@end
