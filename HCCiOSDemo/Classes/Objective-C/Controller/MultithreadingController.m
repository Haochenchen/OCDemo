//
//  MultithreadingController.m
//  HCCiOSDemo
//
//  Created by info on 2018/5/11.
//  Copyright © 2018年 hao. All rights reserved.
//

#import "MultithreadingController.h"

@interface MultithreadingController ()
{
    NSArray *imageArray;
    NSMutableArray *imageViews;
}
@property (nonatomic, strong)UIImageView *imageView;
@end

@implementation MultithreadingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    imageArray = @[@"http://fd.topitme.com/d/a8/1d/11315383988791da8do.jpg",@"http://pic29.photophoto.cn/20131115/0005018628741904_b.jpg",@"http://d.hiphotos.baidu.com/zhidao/pic/item/bf096b63f6246b60bfac143de9f81a4c500fa2dd.jpg",@"http://pic.58pic.com/58pic/13/69/82/65Z58PICpiT_1024.jpg",@"http://www.hcc.com/ios.jpg"];
    
    [self setupUI];
}
#pragma mark --UI布局
//UI布局
- (void)setupUI{
    
    
    [self creatImageView];
    
    NSMutableArray *array;
    
    array = [self creatThreadButton];
   
    array = [self creatOperationButton:array];
    
    array = [self creatGCDButton:array];
    
}
//创建展示图片视图
- (void)creatImageView{
    imageViews = [NSMutableArray arrayWithCapacity:3];
    for (int i = 0; i<3; i++) {
        UIImageView *imageView = [UIImageView new];
        imageView.image = [UIImage imageNamed:@"defaultImage"];
        imageView.backgroundColor = [UIColor lightGrayColor];
        imageView.tag = 40+i;
        [self.view addSubview:imageView];
        [imageViews addObject:imageView];
    }
    self.imageView = imageViews[1];
    [imageViews mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:10 leadSpacing:10 tailSpacing:10];
    [imageViews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(Height_NavBar+10);
        make.height.mas_equalTo(150);
    }];
}
//创建NSThread按钮
- (NSMutableArray *)creatThreadButton{
    
    UILabel *titleLabel = [UILabel hcc_labelWithTitle:@"NSThread" withColor:[UIColor orangeColor]];
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.imageView.mas_bottom).offset(10);
    }];
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:3];
    NSArray *titles = @[@"实例方法",@"类方法",@"隐式创建"];
    for (int i = 0; i<titles.count; i++) {
        UIButton *button = [UIButton hcc_buttonWithTitle:titles[i] withColor:[UIColor greenColor]];
        button.tag = 50+i;
        [button addTarget:self action:@selector(buttonWithThread:) forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:button];
        [array addObject:button];
    }
    
    [array mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:10 leadSpacing:10 tailSpacing:10];
    [array mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(30);
    }];
    
    return array;
}
//创建NSOperation按钮
- (NSMutableArray *)creatOperationButton:(NSMutableArray *)arr{
    
    UIButton *btn = arr [0];
    UILabel *titleLabel = [UILabel hcc_labelWithTitle:@"NSOperation" withColor:[UIColor orangeColor]];
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(btn.mas_bottom).offset(10);
    }];
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:3];
    NSArray *titles = @[@"Invocation实例创建",@"Block实例创建",@"加入队列"];
    for (int i = 0; i<titles.count; i++) {
        UIButton *button = [UIButton hcc_buttonWithTitle:titles[i] withColor:[UIColor greenColor]];
        button.tag = 60+i;
        [button addTarget:self action:@selector(buttonWithOperation:) forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:button];
        [array addObject:button];
    }
    [array mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:10 leadSpacing:10 tailSpacing:10];
    [array mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(30);
    }];
    
    return array;
}
//创建GCD按钮
- (NSMutableArray *)creatGCDButton:(NSMutableArray *)arr{
    
    UIButton *btn = arr [0];
    UILabel *titleLabel = [UILabel hcc_labelWithTitle:@"GCD" withColor:[UIColor orangeColor]];
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(btn.mas_bottom).offset(10);
    }];
    //第一行
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:3];
    NSArray *titles = @[@"同步串行",@"异步串行",@"同步并发",@"异步并发"];
    for (int i = 0; i<titles.count; i++) {
        UIButton *button = [UIButton hcc_buttonWithTitle:titles[i] withColor:[UIColor greenColor]];
        button.tag = 70+i;
        [button addTarget:self action:@selector(buttonWithGCD:) forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:button];
        [array addObject:button];
    }
    [array mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:10 leadSpacing:10 tailSpacing:10];
    [array mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(30);
    }];
    //第二行
    NSArray *otherTitles = @[@"栅栏",@"快速迭代",@"group",@"延时操作"];
    UIButton *secBtn = array[0];
    [array removeAllObjects];
    for (int i = 0; i<otherTitles.count; i++) {
        UIButton *button = [UIButton hcc_buttonWithTitle:otherTitles[i] withColor:[UIColor greenColor]];
        button.tag = 80+i;
        [button addTarget:self action:@selector(buttonWithGCD:) forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:button];
        [array addObject:button];
    }
    [array mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:10 leadSpacing:10 tailSpacing:10];
    [array mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(secBtn.mas_bottom).offset(10);
        make.height.mas_equalTo(30);
    }];
    //第三行
    NSArray *elseTitles = @[@"定时器",@"单例"];
    UIButton *thirdBtn = array[0];
    [array removeAllObjects];
    for (int i = 0; i<elseTitles.count; i++) {
        UIButton *button = [UIButton hcc_buttonWithTitle:elseTitles[i] withColor:[UIColor greenColor]];
        button.tag = 90+i;
        [button addTarget:self action:@selector(buttonWithGCD:) forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:button];
        [array addObject:button];
    }
    [array mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:10 leadSpacing:10 tailSpacing:10];
    [array mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(thirdBtn.mas_bottom).offset(10);
        make.height.mas_equalTo(30);
    }];
    
    return array;
}



#pragma mark -- 按钮方法
- (void)buttonWithThread:(UIButton *)button{
    //随机获取url
    int i = arc4random()%4;
    NSString *imageURL = imageArray[i];
    
    switch (button.tag) {
        case 50:
            [self threadWithInit:imageURL];
            break;
        case 51:
            [self threadWithClass:imageURL];
            break;
        case 52:
            [self threadWithObject:imageURL];
            break;
        default:
            break;
    }
}

- (void)buttonWithOperation:(UIButton *)button{
    //随机获取url
    int i = arc4random()%4;
    NSString *imageURL = imageArray[i];
    
    switch (button.tag) {
        case 60:
            [self invocationOperation:imageURL flag:YES];
            break;
        case 61:
            [self blockOperation:imageURL flag:YES];
            break;
        case 62:
            [self invocationOperation:imageURL flag:NO];
            break;
        default:
            break;
    }
}

- (void)buttonWithGCD:(UIButton *)button{
    
    switch (button.tag) {
        case 70:
            [self GCDWithSyncSerial];
            break;
        case 71:
            [self GCDWithAsyncSerial];
            break;
        case 72:
            [self GCDWithSyncConcurrent];
            break;
        case 73:
            [self GCDWithAsyncConcurrent];
            break;
        case 80:
            [self GCDWithBarrier];
            break;
        case 81:
            [self GCDWithApply];
            break;
        case 82:
            [self GCDWithGroup];
            break;
        case 83:
            [self GCDWithAfter];
            break;
        case 90:
            [self GCDWithTimer];
            break;
        case 91:
            [self GCDWithOnce];
            break;
        default:
            break;
    }
}

#pragma mark -- NSThread
//通过NSThread实例创建
- (void)threadWithInit:(NSString *)url{
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(loadImageWithURL:) object:url];
    [thread start];
}

//通过NSThread类方法创建
- (void)threadWithClass:(NSString *)url{
    [NSThread detachNewThreadSelector:@selector(loadImageWithURL:) toTarget:self withObject:url];
}

//通过隐式创建
- (void)threadWithObject:(NSString *)url{
    [self performSelectorInBackground:@selector(loadImageWithURL:) withObject:url];
}

#pragma mark -- NSOperation
//通过NSInvocationOperation创建
- (void)invocationOperation:(NSString *)url flag:(BOOL)flag{
    NSInvocationOperation *invocationOperation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(loadImageWithURL:) object:url];
    if (flag) {
        //直接执行
        [invocationOperation start];
    }else{
        //添加到队列执行
        NSOperationQueue *queue = [[NSOperationQueue alloc]init];
        [queue addOperation:invocationOperation];
    }
    
    
}
//通过NSBlockOperation创建
- (void)blockOperation:(NSString *)url flag:(BOOL)flag{
    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        [self loadImageWithURL:url];
    }];
    if (flag) {
        //直接执行
        [blockOperation start];
    }else{
        //添加到队列执行
        NSOperationQueue *queue = [[NSOperationQueue alloc]init];
        [queue addOperation:blockOperation];
    }
    
}


#pragma mark -- GCD
//同步串行
- (void)GCDWithSyncSerial{
    dispatch_queue_t  image_queue =  dispatch_queue_create("sync.serial.queue", DISPATCH_QUEUE_SERIAL);
    //添加任务1
    dispatch_sync(image_queue, ^{
        [NSThread sleepForTimeInterval:2];
        [self setImageWithImageView:imageViews[0]];
    });
    //添加任务2
    dispatch_sync(image_queue, ^{
        [NSThread sleepForTimeInterval:2];
        [self setImageWithImageView:imageViews[1]];
    });
    //添加任务3
    dispatch_sync(image_queue, ^{
        [NSThread sleepForTimeInterval:2];
        [self setImageWithImageView:imageViews[2]];
    });
}
//异步串行
- (void)GCDWithAsyncSerial{
    dispatch_queue_t  image_queue =  dispatch_queue_create("async.serial.queue", DISPATCH_QUEUE_SERIAL);
    //添加任务1
    dispatch_async(image_queue, ^{
        [NSThread sleepForTimeInterval:2];
        [self setImageWithImageView:imageViews[0]];
    });
    //添加任务2
    dispatch_async(image_queue, ^{
        [NSThread sleepForTimeInterval:2];
        [self setImageWithImageView:imageViews[1]];
    });
    //添加任务3
    dispatch_async(image_queue, ^{
        [NSThread sleepForTimeInterval:2];
        [self setImageWithImageView:imageViews[2]];
    });
}
//同步并发
- (void)GCDWithSyncConcurrent{
    dispatch_queue_t  image_queue =  dispatch_queue_create("sync.concurrent.queue", DISPATCH_QUEUE_CONCURRENT);
    //添加任务1
    dispatch_sync(image_queue, ^{
        [NSThread sleepForTimeInterval:2];
        [self setImageWithImageView:imageViews[0]];
    });
    //添加任务2
    dispatch_sync(image_queue, ^{
        [NSThread sleepForTimeInterval:2];
        [self setImageWithImageView:imageViews[1]];
    });
    //添加任务3
    dispatch_sync(image_queue, ^{
        [NSThread sleepForTimeInterval:2];
        [self setImageWithImageView:imageViews[2]];
    });
}
//异步并发
- (void)GCDWithAsyncConcurrent{
    dispatch_queue_t  image_queue =  dispatch_queue_create("async.concurrent.queue", DISPATCH_QUEUE_CONCURRENT);
    //添加任务1
    dispatch_async(image_queue, ^{
        [NSThread sleepForTimeInterval:2];
        [self setImageWithImageView:imageViews[0]];
    });
    //添加任务2
    dispatch_async(image_queue, ^{
        [NSThread sleepForTimeInterval:2];
        [self setImageWithImageView:imageViews[1]];
    });
    //添加任务3
    dispatch_async(image_queue, ^{
        [NSThread sleepForTimeInterval:2];
        [self setImageWithImageView:imageViews[2]];
    });
}

//栅栏方法
- (void)GCDWithBarrier{
    dispatch_queue_t  queue =  dispatch_queue_create("barrier.queue",DISPATCH_QUEUE_CONCURRENT);
    //添加任务1
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"-----1-----");
        [self loadImageWithURL:imageArray[0]];
    });
    //添加任务2
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"-----2-----");
        [self loadImageWithURL:imageArray[1]];
    });
    //栅栏方法，添加任务3
    dispatch_barrier_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"-----3-----");
        [self loadImageWithURL:imageArray[2]];
    });
    //添加任务4
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"-----4-----");
        [self loadImageWithURL:imageArray[3]];
    });
    //添加任务5
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"-----5-----");
        [self loadImageWithURL:imageArray[4]];
    });
}
//快速迭代
- (void)GCDWithApply{
    dispatch_apply(imageViews.count, dispatch_get_global_queue(0, 0), ^(size_t index) {
        NSLog(@"%zd----%@",index, [NSThread currentThread]);
        [self setImageWithImageView:imageViews[index]];
    });
}
//group
- (void)GCDWithGroup{
    dispatch_group_t  group = dispatch_group_create();
    __block UIImage *image1 = nil;
    __block UIImage *image2 = nil;
    //添加任务1
    dispatch_group_enter(group);
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        [NSThread sleepForTimeInterval:2];
        image1 = [self setImageWithURL:imageArray[0]];
        dispatch_group_leave(group);
    });
    //添加任务2
    dispatch_group_enter(group);
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        [NSThread sleepForTimeInterval:2];
        image2 = [self setImageWithURL:imageArray[1]];
        dispatch_group_leave(group);
    });
    
    //任务1，2执行完后，收到通知后执行
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
            UIImageView *imageView1 = imageViews[0];
            imageView1.image = image1;
            UIImageView *imageView2 = imageViews[1];
            imageView2.image = image2;
    });
}
//延时操作
- (void)GCDWithAfter{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIImageView *imageView = imageViews[2];
        imageView.image = [self setImageWithURL:imageArray[2]];
        
    });
}

//定时器
- (void)GCDWithTimer{
    __block int count = 0;
    //创建一个定时器
    __block dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
    //设置启动时间
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, 0);
    //设置定时器各项参数
     dispatch_source_set_timer(timer, start, (int64_t)(1.0 * NSEC_PER_SEC), 0);
    // 设置回调
    dispatch_source_set_event_handler(timer, ^{
        NSLog(@"%d----%@", count,[NSThread currentThread]);
        count++;
        if (count == 4) {
            // 取消定时器
            dispatch_cancel(timer);
            timer = nil;
            NSLog(@"定时器销毁");
        }
    });
    //启动定时器
    dispatch_resume(timer);
}
//单例
- (void)GCDWithOnce{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"内部代码只执行一次");
    });
    NSLog(@"点击了单例按钮");
}

#pragma mark -- 请求图片
//加载图片
- (void)loadImageWithURL:(NSString *)url{
    NSLog(@"currentThread----%@",[NSThread currentThread]);
    NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    UIImage *image;
    if (imgData!=nil) {
        image = [UIImage imageWithData:imgData];
    }else{
        image = [UIImage imageNamed:@"defaultImage"];
    }
    //主线程刷新UI
    [self performSelectorOnMainThread:@selector(refreshImageView:) withObject:image waitUntilDone:YES];
}
//刷新图片
-(void)refreshImageView:(UIImage *)image{
    [self.imageView setImage:image];

}
//请求图片并刷新
- (void)setImageWithImageView:(UIImageView *)imageView{
    NSLog(@"currentThread----%@",[NSThread currentThread]);
    //随机获取url
    int i = arc4random()%4;
    NSString *imageURL = imageArray[i];
    NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
    UIImage *image = [UIImage imageWithData:imgData];
    //主线程刷新UI
    dispatch_async(dispatch_get_main_queue(), ^{
        if (imgData != nil) {
            imageView.image = image;
        }else{
            imageView.image = [UIImage imageNamed:@"defaultImage"];
        }
    });
}

//仅请求图片
- (UIImage *)setImageWithURL:(NSString *)url{
    NSLog(@"currentThread----%@",[NSThread currentThread]);
    NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    UIImage *image = [UIImage imageWithData:imgData];
    if (imgData!=nil) {
        return image;
    }else{
        image = [UIImage imageNamed:@"defaultImage"];
        return image;
    }

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
