//
//  ViewController.m
//  LTNaviDropMenu
//
//  Created by liangtong on 16/3/17.
//  Copyright © 2016年 com.personal.liangtong. All rights reserved.
//

#import "ViewController.h"
#import "LTNaviDropMenu.h"
#import "LTNaviDropMenuProtocol.h"

@interface ViewController ()<LTNaviDropMenuDateSource,LTNaviDropMenuDelegate>

@property(nonatomic,strong)LTNaviDropMenu *naviDropMenu;
@property(nonatomic,strong)NSArray* dropItemArray;


@property (weak, nonatomic) IBOutlet UILabel *tipLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.navigationController.navigationBar.translucent= NO;
    
    self.dropItemArray =  [[NSArray alloc] initWithObjects:
                           @"Objective-C",
                           @"Swift",
                           @"C",
                           @"C++",
                           @"Java",
                           @"C#",
                           @"Phython",
                           nil];
    
    [self buildNavigationBarDropMenu];
}

-(void)buildNavigationBarDropMenu{
    if (self.navigationItem && self.dropItemArray.count > 0) {
        CGRect frame = CGRectMake(0.0, 0.0, 200.0, self.navigationController.navigationBar.bounds.size.height);
        _naviDropMenu = [[LTNaviDropMenu alloc] initWithFrame:frame title:[self.dropItemArray objectAtIndex:0]];
        [_naviDropMenu displayMenuInView:self.view];
        _naviDropMenu.dataSource = self;
        _naviDropMenu.delegate = self;
        self.navigationItem.titleView = _naviDropMenu;
    }
}
#pragma 下拉导航栏
#pragma 导航栏下拉菜单
-(NSInteger)numberOfRows{
    return self.dropItemArray.count;
}
-(id)dataInIndex:(NSInteger) index{
    return [self.dropItemArray objectAtIndex:index];
}
-(void) chooseAtIndex:(NSInteger)index{
    [self refreshNaviTitle:index];
}

-(void)refreshNaviTitle:(NSInteger)index{
    NSString* text = [self.dropItemArray objectAtIndex:index];
    [_naviDropMenu setTitle:text];
    self.tipLabel.text = text;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
