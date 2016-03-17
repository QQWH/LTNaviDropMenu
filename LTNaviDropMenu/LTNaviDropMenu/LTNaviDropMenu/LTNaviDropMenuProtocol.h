//
//  LTNaviDropMenuProtocol.h
//  LTNaviDropMenu
//
//  Created by liangtong on 15/7/24.
//  Copyright (c) 2015年 com.personal.liangtong. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  协议，与UITableView类似。不做赘述
 **/
@protocol LTNaviDropMenuDelegate <NSObject>

@optional
-(void) menuBtnOrBackgroundPressed;
-(void) chooseAtIndex:(NSInteger)index;
@end


@protocol LTNaviDropMenuDateSource <NSObject>

-(NSInteger)numberOfRows;
-(id)dataInIndex:(NSInteger) index;

@end
