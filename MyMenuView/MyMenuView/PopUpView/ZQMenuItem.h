//
//  ZQMenuItem.h
//  MyMenuView
//
//  Created by 聂自强 on 16/6/22.
//  Copyright © 2016年 lyice. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZQMenuItem : UIControl

@property (nonatomic, strong) UIColor *norColor;
@property (nonatomic, strong) UIColor *selColor;
@property (nonatomic, assign) CGFloat height;

/**
 *  default initializer
 *
 *  @param title  Item's right title if you are need.
 *  @param image  Item's left image if you are need(Note:both title and image can't be nil at the same time!).
 *  @param target action's target.
 *  @param action action's callback methed.
 *
 *  @return a RFPopupMenuItem instance if init sucessed.
 */
- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image target:(id)target action:(SEL)action;
+ (instancetype)ItemWithTitle:(NSString *)title image:(UIImage *)image target:(id)target action:(SEL)action;

@end
