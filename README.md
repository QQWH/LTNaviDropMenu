# LTNaviDropMenu
导航栏下拉选择框。<br>
这里提供一种导航栏下拉选择控件的实现思路，供参考。

![](https://github.com/l900416/LTNaviDropMenu/blob/master/ScreenShots/1.png)
![](https://github.com/l900416/LTNaviDropMenu/blob/master/ScreenShots/2.png)

##使用方法
###前期准备
```Objective-C
/**
  * UI控件及数据源
 **/
@property(nonatomic,strong)LTNaviDropMenu *naviDropMenu;
@property(nonatomic,strong)NSArray* dropItemArray;
```
###初始化
```Objective-C
/**
  * 初始化数据源
 **/
self.dropItemArray =  [[NSArray alloc] initWithObjects:
                           @"Objective-C",
                           @"Swift",
                           @"C",
                           @"C++",
                           @"Java",
                           @"C#",
                           @"Phython",
                           nil];
                           
 /**
  * 初始化UI控件，设置代理
 **/
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
```
###实现协议方法
```Objective-C
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
```

## Licence
LTNaviDropMenu被许可在 MIT 协议下使用。查阅 LICENSE 文件来获得更多信息。

## 其他
如有问题，可以通过mail联系我：l900416@163.com
