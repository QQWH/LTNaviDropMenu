//
//  LTNaviDropMenuButton.h
//  LTNaviDropMenu
//
//  Created by liangtong on 15/7/25.
//  Copyright (c) 2015年 com.personal.liangtong. All rights reserved.
//

#import "LTNaviDropMenuButton.h"

//设备的高
#define DEVICE_HEIGHT MAX([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)
//设备的宽
#define DEVICE_WIDTH MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)

#define Distance_Bwteen_Title_And_Arrow 8.0f

@implementation LTNaviDropMenuButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        frame.origin.y -= 2.0;
        self.title = [[UILabel alloc] initWithFrame:frame];
        self.title.textAlignment = NSTextAlignmentCenter;
        self.title.backgroundColor = [UIColor clearColor];
        self.title.textColor = [UIColor whiteColor];
        [self addSubview:self.title];
        
        self.arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LTNaviDropMenu.bundle/arrow_down"]];
        [self.arrow setFrame:CGRectMake(0, 0, 16, 16)];
        [self addSubview:self.arrow];
    }
    return self;
}

- (void)layoutSubviews
{
    [self.title sizeToFit];
    
    CGRect frame = self.title.frame;
    if (frame.size.width > DEVICE_WIDTH - 160) {
        frame.size.width = DEVICE_WIDTH - 160;
        [self.title setFrame:frame];
    }
    
    self.title.center = CGPointMake(self.frame.size.width/2  - 16, (self.frame.size.height-2.0)/2);
    self.arrow.center = CGPointMake(CGRectGetMaxX(self.title.frame) + Distance_Bwteen_Title_And_Arrow, self.frame.size.height / 2);
}

@end
