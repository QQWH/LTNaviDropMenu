//
//  LTNaviDropMenuButton.h
//  LTNaviDropMenu
//
//  Created by liangtong on 15/7/25.
//  Copyright (c) 2015年 com.personal.liangtong. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  导航栏上展示用UI控件，包括名字和方向箭头
 **/

@interface LTNaviDropMenuButton : UIControl

@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UIImageView *arrow;

@end
