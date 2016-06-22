//
//  ZQMenu.m
//  MyMenuView
//
//  Created by 聂自强 on 16/6/22.
//  Copyright © 2016年 lyice. All rights reserved.
//

#import "ZQMenu.h"
#import "ZQMenuContentView.h"

#define kScreenWidth  (CGRectGetWidth([UIScreen mainScreen].bounds))
#define kScreenHeight (CGRectGetHeight([UIScreen mainScreen].bounds))

@interface ZQMenu()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) ZQMenuContentView *menuView;
@property (nonatomic, assign) BOOL                   isShow;

@end


@implementation ZQMenu

#pragma mark - LifeCircle
+ (instancetype)popupMenuWithItems:(NSArray<ZQMenuItem *> *)items{
    return  [[self alloc] initWithItems:items];
}

- (instancetype)initWithItems:(NSArray<ZQMenuItem *> *)items
{
    if ([super init]) {
        
        self.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.9];
        self.edgeMargin      = 6.f;
        self.menuView        = [[ZQMenuContentView alloc] initWithItems:items];
        [self addSubview:_menuView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOverlayView)];
        tap.delegate = self;
        [self addGestureRecognizer:tap];
    }
    return self;
}

#pragma mark - Show
- (void)showInView:(UIView *)view
        targetRect:(CGRect)targetRect
      popDirection:(ZQMenuDirection)direction
          animated:(BOOL)animated
{
    if (_isShow)
    {
        [self dismissAnimated:animated];
    }
    else
    {
        self.frame = view.bounds;
        self.alpha = 0;
        [view addSubview:self];
        
        
        CGPoint menuOrigin = [self calculateMenuOriginInView:view popDirection:direction targetRect:targetRect];
        self.menuView.frame = (CGRect){menuOrigin, self.menuView.frame.size};
        self.menuView.transform = CGAffineTransformMakeScale(0.1, 0.1);
        
        
        [UIView animateWithDuration:(animated ? 0.25f : 0) delay:0 usingSpringWithDamping:0.5f initialSpringVelocity:20 options:UIViewAnimationOptionCurveLinear animations:^{
            
            self.alpha = 1;
            self.menuView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            
            _isShow = YES;
        }];
    }
}

#pragma mark - Hide
- (void)dismissAnimated:(BOOL)animated
{
    if (_isShow) {
        
        [UIView animateWithDuration:(animated ? 0.3f : 0) delay:0 usingSpringWithDamping:1.f initialSpringVelocity:10 options:UIViewAnimationOptionCurveLinear animations:^{
            
            self.alpha = 0;
            self.menuView.transform = CGAffineTransformMakeScale(0.1, 0.1);;
        } completion:^(BOOL finished) {
            
            [self removeFromSuperview];
            _isShow = NO;
        }];
    }
}

#pragma mark - Help methods
/** handle can't send messages to other's object if there is exist a gesture. */
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    CGPoint point = [gestureRecognizer locationInView:self];
    
    return !CGRectContainsPoint(self.menuView.frame, point);
}

- (void)tapOverlayView
{
    [self dismissAnimated:YES];
}

- (void)setArrowHorizontalOffset:(CGFloat)arrowHorizontalOffset{
    _arrowHorizontalOffset = arrowHorizontalOffset;
    
    self.menuView.arrowHorizontalOffset = arrowHorizontalOffset;
}

- (CGPoint)calculateMenuOriginInView:(UIView *)view popDirection:(ZQMenuDirection)dircetion targetRect:(CGRect)rect{
    
    CGPoint menuOrigin = CGPointZero;
    
    CGFloat viewWidth  = CGRectGetWidth(view.frame);
    CGFloat viewHeight = CGRectGetHeight(view.frame);
    
    CGFloat targetMidX = CGRectGetMidX(rect);
    CGFloat targetMinY = CGRectGetMinY(rect);
    CGFloat targetMaxY = CGRectGetMaxY(rect);
    
    CGFloat menuWidth  = CGRectGetWidth(self.menuView.frame);
    CGFloat menuHeight = CGRectGetHeight(self.menuView.frame);
    
    
    switch (dircetion) {
        case ZQMenuDirectionTopLeft: {
            menuOrigin = (CGPoint){self.edgeMargin, targetMaxY + self.menuView.arrowImageView.image.size.height};
            
            //adjust anchorPoint to make animation from top right.
            self.menuView.layer.anchorPoint = CGPointMake(0, 0);
            CGPoint originPosition          = self.menuView.layer.position;
            originPosition.x               += CGRectGetWidth(self.menuView.layer.bounds)*0.5;
            originPosition.y               += CGRectGetHeight(self.menuView.layer.bounds)*0.5;
            self.menuView.layer.position    = originPosition;
            
            break;
        }
            
        case ZQMenuDirectionTopMiddle: {
            menuOrigin = (CGPoint){targetMidX - menuWidth * 0.5, targetMaxY + self.menuView.arrowImageView.image.size.height};
            
            //adjust anchorPoint to make animation from top right.
            self.menuView.layer.anchorPoint = CGPointMake(0.5, 0);
            CGPoint originPosition          = self.menuView.layer.position;
            originPosition.y               += CGRectGetHeight(self.menuView.layer.bounds)*0.5;
            self.menuView.layer.position    = originPosition;
            
            break;
        }
            
        case ZQMenuDirectionTopRight: {
            menuOrigin = (CGPoint){viewWidth - menuWidth - self.edgeMargin, targetMaxY + self.menuView.arrowImageView.image.size.height};
            
            //adjust anchorPoint to make animation from top right.
            self.menuView.layer.anchorPoint = CGPointMake(1, 0);
            CGPoint originPosition          = self.menuView.layer.position;
            originPosition.x               += CGRectGetWidth(self.menuView.layer.bounds)*0.5;
            originPosition.y               -= CGRectGetHeight(self.menuView.layer.bounds)*0.5;
            self.menuView.layer.position    = originPosition;
            
            break;
        }
            
        case ZQMenuDirectionBottomLeft: {
            
            self.menuView.direction = ZQMenuArrowDirectionDown;
            menuOrigin = (CGPoint){self.edgeMargin, viewHeight - (menuHeight + self.menuView.arrowImageView.image.size.height) - (viewHeight - targetMinY)};
            
            //adjust anchorPoint to make animation from top right.
            self.menuView.layer.anchorPoint = CGPointMake(0, 1);
            CGPoint originPosition          = self.menuView.layer.position;
            originPosition.x               += CGRectGetWidth(self.menuView.layer.bounds)*0.5;
            originPosition.y               -= CGRectGetHeight(self.menuView.layer.bounds)*0.5;
            self.menuView.layer.position    = originPosition;
            
            break;
        }
            
        case ZQMenuDirectionBottomMiddle: {
            menuOrigin = (CGPoint){targetMidX - menuWidth * 0.5, viewHeight - (menuHeight + self.menuView.arrowImageView.image.size.height) - (viewHeight - targetMinY)};
            
            //adjust anchorPoint to make animation from top right.
            self.menuView.layer.anchorPoint = CGPointMake(0.5, 1);
            self.menuView.direction = ZQMenuArrowDirectionDown;
            CGPoint originPosition          = self.menuView.layer.position;
            originPosition.y               -= CGRectGetHeight(self.menuView.layer.bounds)*0.5;
            self.menuView.layer.position    = originPosition;
            
            break;
        }
        case ZQMenuDirectionBottomRight: {
            
            menuOrigin = (CGPoint){viewWidth - menuWidth - self.edgeMargin, viewHeight - (menuHeight + self.menuView.arrowImageView.image.size.height) - (viewHeight - targetMinY)};
            
            //adjust anchorPoint to make animation from top right.
            self.menuView.layer.anchorPoint = CGPointMake(1, 1);
            self.menuView.direction = ZQMenuArrowDirectionDown;
            CGPoint originPosition          = self.menuView.layer.position;
            originPosition.x               -= CGRectGetWidth(self.menuView.layer.bounds)*0.5;
            originPosition.y               -= CGRectGetHeight(self.menuView.layer.bounds)*0.5;
            self.menuView.layer.position    = originPosition;
            
            break;
        }
    }
    
    return menuOrigin;
}

@end
