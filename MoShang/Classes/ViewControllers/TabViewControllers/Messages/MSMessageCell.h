//
//  MSMessageCell.h
//  MoShang
//
//  Created by stonedong on 15/1/28.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DZProgramDefines.h>
#import "MSMessageHistoryModel.h"
@interface MSMessageCell : UITableViewCell
DEFINE_PROPERTY_STRONG_UIImageView(avarterImageView);
DEFINE_PROPERTY_STRONG_UILabel(lastTextLabel);
DEFINE_PROPERTY_STRONG_UILabel(lastTimeLabel);
DEFINE_PROPERTY_STRONG_UILabel(nickNameLabel);
@property (nonatomic, strong) MSMessageHistoryModel* messageHistory;
@end
