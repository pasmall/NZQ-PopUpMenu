//
//  ZQMenu.h
//  MyMenuView
//
//  Created by 聂自强 on 16/6/22.
//  Copyright © 2016年 lyice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZQMenuItem.h"


@interface ZQMenu : UIView

typedef NS_ENUM(NSUInteger, ZQMenuDirection) {
    ZQMenuDirectionTopLeft,        //topLeft
    ZQMenuDirectionTopMiddle,      //topMiddle
    ZQMenuDirectionTopRight,       //topRight
    ZQMenuDirectionBottomLeft,     //bottomLeft
    ZQMenuDirectionBottomMiddle,   //bottomMiddle
    ZQMenuDirectionBottomRight     //bottomRight
};

/** set edge margin when popDirection is not ZQMenuDirectionTopMiddle or ZQMenuDirectionBottomMiddle, default is 6.f */
@property (nonatomic, assign) CGFloat edgeMargin;

/** set arrow's horizontal offset in the menuView, default is menuView width's half */
@property (nonatomic, assign) CGFloat arrowHorizontalOffset;

/**
 *  default initializer
 *
 *  @param items ZQMenuItem array, at least two.
 *
 *  @return a RFPopupMenu instance
 */
+ (instancetype)popupMenuWithItems:(NSArray<ZQMenuItem *> *)items;
- (instancetype)initWithItems:(NSArray<ZQMenuItem *> *)items;

/**
 *  add RFPopupMenu instance to a target view to show
 *
 *  @param view       target view.
 *  @param targetRect target rect it decide to the menuView popup point.
 *  @param direction  menuView pop direction.
 *  @param animated   whether need animation or not.
 */
- (void)showInView:(UIView *)view
        targetRect:(CGRect)targetRect
      popDirection:(ZQMenuDirection)direction
          animated:(BOOL)animated;

/**
 *  remove RFPopupMenu instance frome it's superView if there exist.
 *
 *  @param animated whether need animation or not.
 */
- (void)dismissAnimated:(BOOL)animated;

@end
