//
//  LTNaviDropMenu.m
//  LTNaviDropMenu
//
//  Created by liangtong on 15/7/24.
//  Copyright (c) 2015年 com.personal.liangtong. All rights reserved.
//

#import "LTNaviDropMenu.h"
#import "LTNaviDropMenuButton.h"
//设备的高
#define DEVICE_HEIGHT MAX([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)
//设备的宽
#define DEVICE_WIDTH MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)
#define AnimateDuration 0.4
#define NaviDropMenuTABLECELLHEIGHT 44

@interface LTNaviDropMenu()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) LTNaviDropMenuButton *menuButton;
@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) UIView *menuContainer;

@property (nonatomic,strong)    UIView* footerView;

@property (readwrite) BOOL isShown;

@end

@implementation LTNaviDropMenu
@synthesize isShown = _isShown;

- (id)initWithFrame:(CGRect)frame title:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        frame.origin.y += 1.0;
        
        self.menuButton = [[LTNaviDropMenuButton alloc] initWithFrame:frame];
        self.menuButton.title.text = title;
        [self.menuButton addTarget:self action:@selector(onHandleMenuTap:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.menuButton];
        }
    return self;
}


- (void)removeFooter
{
    self.table.tableFooterView = nil;
}

- (void)displayMenuInView:(UIView *)view
{
    self.menuContainer = view;
}

-(void)setTitle:(NSString*)title{
    [self.menuButton.title setText: title];
    [self.menuButton.title sizeToFit];
}

#pragma mark -
#pragma mark Actions
- (void)onHandleMenuTap:(id)sender
{
    
    if (!_isShown) {
        [self show];
    } else {
        [self hide];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(menuBtnOrBackgroundPressed)]) {
        [_delegate menuBtnOrBackgroundPressed];
    }
}

- (void)show
{
    _isShown = YES;
    
    if (!self.table) {
        UIWindow *mainWindow = [[UIApplication sharedApplication] keyWindow];
        CGRect frame = mainWindow.frame;
        frame.origin.y += self.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height;
        
        self.table = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
        
        self.table.backgroundColor = [UIColor clearColor];
        
        self.table.dataSource = self;
        self.table.delegate = self;

    }
    
    if(!_currentSelectIndex){
        _currentSelectIndex = [NSIndexPath indexPathForRow:0 inSection:0];
    }
    
    //根据title来确定选中的是那个
    NSString* currentTitle = self.menuButton.title.text;
    if (currentTitle) {
        for (int i = 0; i < [self.dataSource numberOfRows]; i++) {
            NSString* title = [self.dataSource dataInIndex:i] ;
            if (title && [title isEqualToString:currentTitle]) {
                _currentSelectIndex = [NSIndexPath indexPathForRow:i inSection:0];
                break;
            }
        }
    }
    
    [self.menuContainer addSubview:self.table];
    [self rotateArrow:M_PI];
    CGFloat height = DEVICE_HEIGHT;
    self.table.transform = CGAffineTransformIdentity;
    self.table.frame =  CGRectMake(0,  - height, DEVICE_WIDTH, height);

    [self initFooter];
    
    [UIView animateWithDuration:AnimateDuration animations:^{
        self.table.transform = CGAffineTransformMakeTranslation(0,height);
    }completion:^(BOOL finished) {
        //可以在这里对footerView进行设置
        _footerView.backgroundColor = [UIColor colorWithRed:45.0/255.0 green:105.0/255.0 blue:166.0/255.0 alpha:0.1];
        [self.table reloadData];
    }];


}

- (void)hide
{
    _isShown = false;
    [self rotateArrow:0];
    self.footerView.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:AnimateDuration animations:^{
            self.table.transform = CGAffineTransformMakeTranslation(0,-DEVICE_HEIGHT);
    }completion:^(BOOL finished) {
        [self.table removeFromSuperview];
    }];

}

- (void)initFooter
{
    if (!_footerView) {
        _footerView = [[UIView alloc] init];
        
        self.table.tableFooterView = _footerView;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didBackgroundTap)];
        [_footerView addGestureRecognizer:tap];
    }
    [_footerView setFrame:CGRectMake(0, 0, [[UIApplication sharedApplication] keyWindow].frame.size.width, self.table.bounds.size.height - NaviDropMenuTABLECELLHEIGHT*[self.dataSource numberOfRows])];
    _footerView.backgroundColor = [UIColor clearColor];
    
}

- (void)rotateArrow:(float)degrees
{
    [UIView animateWithDuration:AnimateDuration delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.menuButton.arrow.layer.transform = CATransform3DMakeRotation(degrees, 0, 0, 1);
    } completion:NULL];
}

#pragma mark -- UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NaviDropMenuTABLECELLHEIGHT;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self hide];
    _currentSelectIndex = indexPath;
    [self.delegate chooseAtIndex:indexPath.row];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource numberOfRows];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    id cellItem =  [self.dataSource dataInIndex:indexPath.row];

    if (_currentSelectIndex && [_currentSelectIndex isEqual:indexPath] ) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    cell.textLabel.text = cellItem;
    
    cell.imageView.image = [UIImage imageNamed:@"LTNaviDropMenu.bundle/building"];
    
    
    return cell;
}
- (void)didBackgroundTap
{
    [self onHandleMenuTap:nil];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath

{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

@end
