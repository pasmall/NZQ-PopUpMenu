//
//  ZQMenuContentView.h
//  MyMenuView
//
//  Created by 聂自强 on 16/6/22.
//  Copyright © 2016年 lyice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZQMenuItem.h"

typedef NS_ENUM(NSUInteger, ZQMenuArrowDirection) {
    ZQMenuArrowDirectionUp,
    ZQMenuArrowDirectionDown,
};


@interface ZQMenuContentView : UIView


@property (nonatomic, strong) UIView      *popupMenuBackGroundView;
@property (nonatomic, strong) UIImageView *arrowImageView;

/** default direction is ZQMenuArrowDirectionUp */
@property (nonatomic, assign) ZQMenuArrowDirection direction;
/** default arrow Horizontal Offset is arrow menuView width's half */
@property (nonatomic, assign) CGFloat arrowHorizontalOffset;

+ (instancetype)popupMenuWithItems:(NSArray<ZQMenuItem *> *)items;
- (instancetype)initWithItems:(NSArray<ZQMenuItem *> *)items;

- (CGSize)popupMenuSize;

@end
