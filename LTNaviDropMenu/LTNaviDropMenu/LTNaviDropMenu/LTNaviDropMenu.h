//
//  LTNaviDropMenu.h
//  LTNaviDropMenu
//
//  Created by liangtong on 15/7/24.
//  Copyright (c) 2015年 com.personal.liangtong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LTNaviDropMenuProtocol.h"

/**
 *  导航栏上展示用UI控件
 **/
@interface LTNaviDropMenu : UIView

@property (nonatomic, assign) id<LTNaviDropMenuDelegate> delegate;
@property (nonatomic, assign) id<LTNaviDropMenuDateSource> dataSource;

@property (nonatomic,strong)NSIndexPath * currentSelectIndex;

/**
 *  初始化
 **/
- (id)initWithFrame:(CGRect)frame title:(NSString *)title;

/**
 *  设置展示区域
 **/
- (void)displayMenuInView:(UIView *)view;

/**
 *  设置显示Title
 **/
-(void)setTitle:(NSString*)title;

@property (readonly) BOOL isShown;

- (void)show;
- (void)hide;
@end
