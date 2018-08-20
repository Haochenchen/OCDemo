//
//  SDWebImageDemoController.m
//  HCCiOSDemo
//
//  Created by info on 2018/5/21.
//  Copyright © 2018年 hao. All rights reserved.
//

#import "SDWebImageDemoController.h"
#import "SDImageCache.h"
#import "EventView.h"
@interface SDWebImageDemoController ()<EventViewDelegate>

@property(nonatomic, strong)NSMutableArray *imageViews;
@end

@implementation SDWebImageDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
    
}

#pragma mark -- 页面布局
//UI布局
- (void)setupUI{
    
    NSMutableArray *array;
    array = [self creatImageView];
    array = [self creatButton];
    
    
    EventView *eventV = [EventView new];
    //设置代理
    eventV.delegate = self;
    eventV.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:eventV];
    [eventV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(100);
        make.bottom.equalTo(self.view.mas_bottom).offset(-SAFE_BOTTOM);
    }];
}

//创建UIImageView
- (NSMutableArray *)creatImageView{
    self.imageViews = [NSMutableArray arrayWithCapacity:4];
    for (int i = 0; i<4; i++) {
        UIImageView *imageView = [UIImageView new];
        imageView.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:imageView];
        [self.imageViews addObject:imageView];
    }
    
    [self.imageViews mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:10 leadSpacing:10 tailSpacing:10];
    [self.imageViews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(Height_NavBar+10);
        make.height.mas_equalTo(100);
    }];
    return self.imageViews;
}

//创建button
- (NSMutableArray *)creatButton{
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:3];
    NSArray *titles = @[@"加载图片",@"清空缓存"];
    for (int i = 0; i<titles.count; i++) {
        UIButton *button = [UIButton hcc_buttonWithTitle:titles[i] withColor:[UIColor greenColor]];
        button.tag = 50+i;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:button];
        [array addObject:button];
    }
    UIImageView *imageView = self.imageViews[0];
    [array mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:10 leadSpacing:10 tailSpacing:10];
    [array mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.mas_bottom).offset(20);
        make.height.mas_equalTo(30);
    }];
    return array;
}

#pragma mark -- 按钮方法
- (void)buttonAction:(UIButton *)button{
    switch (button.tag) {
        case 50:
            [self loadImage];
            break;
        case 51:
            [self clearCache];
            break;
        default:
            break;
    }
}

//加载图片
- (void)loadImage{
    //设置图片url
    NSArray * imageArray = @[@"http://fd.topitme.com/d/a8/1d/11315383988791da8do.jpg",@"http://pic29.photophoto.cn/20131115/0005018628741904_b.jpg",@"http://d.hiphotos.baidu.com/zhidao/pic/item/bf096b63f6246b60bfac143de9f81a4c500fa2dd.jpg",@"http://pic.58pic.com/58pic/13/69/82/65Z58PICpiT_1024.jpg"];
    
    //直接加载网络图片
    UIImageView *iv1 = self.imageViews[0];
    [iv1 sd_setImageWithURL:[NSURL URLWithString:imageArray[0]]];
    
    //先展示默认图片，当网络图片加载完成后替换
    UIImageView *iv2 = self.imageViews[1];
    [iv2 sd_setImageWithURL:[NSURL URLWithString:imageArray[1]] placeholderImage:[UIImage imageNamed:@"defaultImage"]];
    
    //先展示默认图片，并设置网络图片处理方式
    UIImageView *iv3 = self.imageViews[2];
    [iv3 sd_setImageWithURL:[NSURL URLWithString:imageArray[2]] placeholderImage:[UIImage imageNamed:@"defaultImage"] options:SDWebImageCacheMemoryOnly];
    
    //展示默认图片，设置图片处理方式，以及执行图片加载完成后的block内部代码
    UIImageView *iv4 = self.imageViews[3];
    [iv4 sd_setImageWithURL:[NSURL URLWithString:imageArray[3]] placeholderImage:[UIImage imageNamed:@"defaultImage"] options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        NSLog(@"imageSize--height:%f,width:%f",image.size.height,image.size.width);
    }];
    
}

//清理缓存
- (void)clearCache{
    //清理磁盘缓存
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        NSLog(@"磁盘清理完成");
    }];
    //清理内存缓存
    [[SDImageCache sharedImageCache] clearMemory];
}

#pragma mark -- EventViewDelegate
//实现协议方法
- (void)sendValue:(NSString *)value{
    NSLog(@"eventView:%@",value);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
