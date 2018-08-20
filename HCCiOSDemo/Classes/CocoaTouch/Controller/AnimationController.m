//
//  AnimationController.m
//  HCCiOSDemo
//
//  Created by info on 2018/6/19.
//  Copyright © 2018年 hao. All rights reserved.
//

#import "AnimationController.h"

@interface AnimationController ()<CAAnimationDelegate>
@property(nonatomic, strong)UIImageView *redIV;
@property(nonatomic, strong)UIImageView *yellowIV;
@end

@implementation AnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
}

#pragma mark -- 页面布局
//UI布局
- (void)setupUI{
    
    NSMutableArray *array;
    
    array = [self creatViewAnimationButtons];
    
    [self creatCoreAnimationButtons:array];
    
}
//设置UIView动画方式
- (NSMutableArray *)creatViewAnimationButtons{
    
    UILabel *titleLabel = [UILabel hcc_labelWithTitle:@"UIView动画" withColor:[UIColor orangeColor]];
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.redIV.mas_bottom).offset(20);
    }];
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:2];
    NSArray *titles = @[@"普通方式",@"简单block",@"Spring",@"Keyframes"];
    for (int i = 0; i<titles.count; i++) {
        UIButton *button = [UIButton hcc_buttonWithTitle:titles[i] withColor:[UIColor greenColor]];
        button.tag = 50+i;
        [button addTarget:self action:@selector(buttonWithViewAnimation:) forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:button];
        [array addObject:button];
    }
    
    [array mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:10 leadSpacing:10 tailSpacing:10];
    [array mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(30);
    }];
    
    //第二行
    NSArray *otherTitles = @[@"单视图转变",@"转场"];
    UIButton *secBtn = array[0];
    [array removeAllObjects];
    for (int i = 0; i<otherTitles.count; i++) {
        UIButton *button = [UIButton hcc_buttonWithTitle:otherTitles[i] withColor:[UIColor greenColor]];
        button.tag = 54+i;
        [button addTarget:self action:@selector(buttonWithViewAnimation:) forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:button];
        [array addObject:button];
    }
    [array mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:10 leadSpacing:10 tailSpacing:10];
    [array mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(secBtn.mas_bottom).offset(10);
        make.height.mas_equalTo(30);
    }];
    
    return array;
}

- (void)creatCoreAnimationButtons:(NSMutableArray *)arr{
    
    UIButton *btn = arr [0];
    
    UILabel *titleLabel = [UILabel hcc_labelWithTitle:@"核心动画" withColor:[UIColor orangeColor]];
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(btn.mas_bottom).offset(20);
    }];
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:2];
    NSArray *titles = @[@"位移",@"透明度",@"缩放",@"旋转",@"背景色"];
    for (int i = 0; i<titles.count; i++) {
        UIButton *button = [UIButton hcc_buttonWithTitle:titles[i] withColor:[UIColor greenColor]];
        button.tag = 60+i;
        [button addTarget:self action:@selector(baseCoreAnimation:) forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:button];
        [array addObject:button];
    }
    
    [array mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:10 leadSpacing:10 tailSpacing:10];
    [array mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(30);
    }];
    
    //第二行
    NSArray *otherTitles = @[@"CASpring",@"CAKeyframe",@"CATransition",@"Group"];
    UIButton *secBtn = array[0];
    [array removeAllObjects];
    for (int i = 0; i<otherTitles.count; i++) {
        UIButton *button = [UIButton hcc_buttonWithTitle:otherTitles[i] withColor:[UIColor greenColor]];
        button.tag = 70+i;
        [button addTarget:self action:@selector(CAAnimationTypes:) forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:button];
        [array addObject:button];
    }
    [array mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:10 leadSpacing:10 tailSpacing:10];
    [array mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(secBtn.mas_bottom).offset(10);
        make.height.mas_equalTo(30);
    }];
}

#pragma mark -- UIView动画
- (void)buttonWithViewAnimation:(UIButton *)button{
    switch (button.tag) {
        case 50:
            [self viewAnimationWithNormal];
            break;
        case 51:
            [self viewAnimationWithSimpleBlock];
            break;
        case 52:
            [self viewAnimationWithSpringBlock];
            break;
        case 53:
            [self viewAnimationWithKeyframesBlock];
            break;
        case 54:
            [self viewAnimationWithTransitionBlock];
            break;
        case 55:
            [self ViewTransferAnimation];
            break;
        default:
            break;
    }
}

//普通方式创建UIView动画
- (void)viewAnimationWithNormal{
    // 第一个参数: 动画标识
    // 第二个参数: 附加参数,在设置代理情况下，此参数将发送到setAnimationWillStartSelector和setAnimationDidStopSelector所指定的方法，大部分情况，设置为nil.
    [UIView beginAnimations:@"translation" context:nil];
    //设置动画代理
    [UIView setAnimationDelegate:self];
    //设置动画开始时执行方法
    [UIView setAnimationWillStartSelector:@selector(animationStart)];
    //设置动画停止时执行方法
    [UIView setAnimationDidStopSelector:@selector(animationStop)];
    //设置动画持续时间
    [UIView setAnimationDuration:1.0];
    //设置动画延迟执行时间
    [UIView setAnimationDelay:2.0];
    //设置动画持续次数
    [UIView setAnimationRepeatCount:5.0];
    //设置动画的曲线
    /*
     UIViewAnimationCurve的枚举值：
     UIViewAnimationCurveEaseInOut,         // 慢进慢出（默认值）
     UIViewAnimationCurveEaseIn,            // 慢进
     UIViewAnimationCurveEaseOut,           // 慢出
     UIViewAnimationCurveLinear             // 匀速
     */
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    //设置是否从当前状态开始播放动画
    /*假设上一个动画正在播放，且尚未播放完毕，我们将要进行一个新的动画：
     当为YES时：动画将从上一个动画所在的状态开始播放
     当为NO时：动画将从上一个动画所指定的最终状态开始播放（此时上一个动画马上结束）*/
    [UIView setAnimationBeginsFromCurrentState:YES];
    //设置动画是否继续执行相反的动画
    [UIView setAnimationRepeatAutoreverses:NO];
    //是否禁用动画效果（对象属性依然会被改变，只是没有动画效果）
    [UIView setAnimationsEnabled:NO];
    //设置视图的过渡效果
    /* 第一个参数：UIViewAnimationTransition的枚举值如下
     UIViewAnimationTransitionNone,              //不使用动画
     UIViewAnimationTransitionFlipFromLeft,      //从左向右旋转翻页
     UIViewAnimationTransitionFlipFromRight,     //从右向左旋转翻页
     UIViewAnimationTransitionCurlUp,            //从下往上卷曲翻页
     UIViewAnimationTransitionCurlDown,          //从上往下卷曲翻页
     第二个参数：需要过渡效果的View
     第三个参数：是否使用视图缓存，YES：视图在开始和结束时渲染一次；NO：视图在每一帧都渲染*/
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.redIV cache:YES];
    //提交动画
    [UIView commitAnimations];
}

//简单block方式创建UIView动画
- (void)viewAnimationWithSimpleBlock{
    
   [UIView animateWithDuration:1.0//动画持续时间
                         delay:2.0//动画延迟执行的时间
                       options:UIViewAnimationOptionRepeat|UIViewAnimationOptionAutoreverse|UIViewAnimationOptionCurveLinear//动画的过渡效果
                    animations:^{
                        //执行的动画
                        self.redIV.alpha = 0;
                        //向下平移300
                        self.redIV.transform = CGAffineTransformTranslate(self.redIV.transform, 0, 300);
                        [self performSelector:@selector(removeAnimation) withObject:nil afterDelay:10];
                    }
                    completion:^(BOOL finished) {
                        //动画执行后的操作
                        self.redIV.alpha = 1;
                        //清空形变属性
                        self.redIV.transform = CGAffineTransformIdentity;
                    }];
    
    
}
//Spring动画
- (void)viewAnimationWithSpringBlock{
    [UIView animateWithDuration:1.0//动画持续时间
                          delay:0.5//动画延迟执行的时间
         usingSpringWithDamping:0.3//震动效果，范围0~1，数值越小震动效果越明显
          initialSpringVelocity:10//初始速度，数值越大初始速度越快
                        options:UIViewAnimationOptionLayoutSubviews//动画的过渡效果
                     animations:^{
                         //旋转弧度为M_PI_2
                         self.redIV.transform = CGAffineTransformRotate(self.redIV.transform, M_PI_2);
                         //放大1.5倍
                         self.redIV.transform = CGAffineTransformScale(self.redIV.transform, 1.5, 1.5);
                         
                     }
                     completion:^(BOOL finished) {
                         //清空形变属性
                         self.redIV.transform = CGAffineTransformIdentity;
                     }];
}
//Keyframes动画
- (void)viewAnimationWithKeyframesBlock{
    [UIView animateKeyframesWithDuration:5.0
                                   delay:0.0
                                 options:UIViewKeyframeAnimationOptionAutoreverse
                              animations:^{
                                  //增加关键帧
                                  [UIView addKeyframeWithRelativeStartTime:0//动画开始的时间（占总时间的比例）
                                                        relativeDuration:0.5//动画持续时间（占总时间的比例）
                                                              animations:^{
                                     //执行的动画
                                      self.redIV.backgroundColor = [UIColor blueColor];
                                  }];
                                  
                                  [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.5 animations:^{
                                      self.redIV.backgroundColor = [UIColor greenColor];
                                  }];
                                  
                              }
                              completion:^(BOOL finished) {
                                  //动画执行后的操作
                                  self.redIV.backgroundColor = [UIColor redColor];
                              }];
    
}
//单个视图的过渡效果
- (void)viewAnimationWithTransitionBlock{
    [UIView transitionWithView:self.redIV//执行动画的视图
                      duration:2.f//动画持续时间
                       options:UIViewAnimationOptionTransitionFlipFromLeft|UIViewKeyframeAnimationOptionAutoreverse//动画的过渡效果
                    animations:^{
                        //执行的动画
                        self.redIV.backgroundColor = [UIColor blackColor];
                    }
                    completion:^(BOOL finished) {
                        //动画执行提交后的操作
                        self.redIV.backgroundColor = [UIColor redColor];
                    }];
    
}
//UIView转场动画
- (void)ViewTransferAnimation{
    [UIView transitionFromView:self.yellowIV
                        toView:self.redIV
                      duration:3.f//动画持续时间
                       options:UIViewAnimationOptionTransitionFlipFromTop
                    completion:^(BOOL finished) {
                       //动画执行提交后的操作
                    }];
}

//暂停动画
- (void)removeAnimation{
    [self.redIV.layer removeAllAnimations];
}
//动画开始时的方法
- (void)animationStart{
    NSLog(@"动画开始了");
}
//动画停止时的方法
- (void)animationStop{
    NSLog(@"动画停止");
}

#pragma mark -- 核心动画
//CABasicAnimation
- (void)baseCoreAnimation:(UIButton *)button{
    //初始化动画对象
    CABasicAnimation * anim = [CABasicAnimation animation];
    //设置动画持续时间
    anim.duration = 2;
    //设置代理
    anim.delegate = self;
    //设置非动画时的状态
    anim.fillMode = kCAFillModeRemoved;
    //是否恢复之前状态
    anim.removedOnCompletion = YES;
    //根据点击对象不同选择不同动画效果
    switch (button.tag) {
        case 60:
            //平移
            anim.keyPath = @"position";
            //改变的值
            anim.byValue = [NSValue valueWithCGPoint:CGPointMake(100, 200)];
            break;
        case 61:
            //透明度
            anim.keyPath = @"opacity";
            //初始值
            anim.fromValue = @(1.0f);
            //结束值
            anim.toValue = @(0.3f);
            break;
        case 62:
            //3D缩放
            anim.keyPath = @"transform";
            //这是X轴方向扩大2倍，Y轴方向扩大1.5倍，Z轴方向不变
            anim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(2, 1.5, 1)];
            break;
        case 63:
            //3D旋转
            anim.keyPath = @"transform.rotation";
            //这是以向量(0, 1, 0)为轴，旋转π弧度
            anim.toValue=[NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0, 1, 0)];
            break;
        case 64:
            //背景色
            anim.keyPath = @"backgroundColor";
            //需要将颜色转换成id对象
            anim.toValue=(__bridge id)[UIColor blackColor].CGColor;
            break;
        default:
            break;
    }
    //添加动画
    [self.yellowIV.layer addAnimation:anim forKey:nil];
    
}

//几种特别的核心动画
- (void)CAAnimationTypes:(UIButton *)button{
    switch (button.tag) {
        case 70:
            [self springAnimation];
            break;
        case 71:
            [self keyFramesAnimation];
            break;
        case 72:
            [self transitionAnimation];
            break;
        case 73:
            [self animationGroup];
            break;
        default:
            break;
    }
}
//CASpringAnimation
- (void)springAnimation{
    if (@available(iOS 9.0, *)) {
        //初始化CASpringAnimation对象，并设置keyPath
        CASpringAnimation *anim = [CASpringAnimation animationWithKeyPath:@"position"];
        //设置质量
        anim.mass = 5.f;
        //设置劲度系数
        anim.stiffness = 120.f;
        //设置阻尼系数
        anim.damping = 8.f;
        //设置初始速度
        anim.initialVelocity = 2.f;
        //向下平移200
        anim.byValue = [NSValue valueWithCGPoint:CGPointMake(0, 200)];
        //设置动画时间，使用参数计算出的时间
        anim.duration = anim.settlingDuration;
        //添加动画
        [self.yellowIV.layer addAnimation:anim forKey:@"spring"];
    } else {
        // Fallback on earlier versions
    }
}
//CAKeyFramesAnimation
- (void)keyFramesAnimation{
    //初始化CAKeyframeAnimation对象，并设置keyPath
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //设置动画时间，使用参数计算出的时间
    anim.duration = 2.f;
    //设置路径
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(SCREEN_WIDTH/2-100, SCREEN_HEIGHT/2-100, 200, 200)];
    anim.path = path.CGPath;
    //设置关键帧
    NSValue *v1 = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
    NSValue *v2 = [NSValue valueWithCGPoint:CGPointMake(200, 150)];
    NSValue *v3 = [NSValue valueWithCGPoint:CGPointMake(250, 400)];
    NSValue *v4 = [NSValue valueWithCGPoint:CGPointMake(100, 250)];
    anim.values = @[v1,v2,v3,v4];
    //动画运算模式
    anim.calculationMode = kCAAnimationCubicPaced;
    //沿路径旋转方式
    anim.rotationMode = kCAAnimationRotateAutoReverse;
    //添加动画
    [self.yellowIV.layer addAnimation:anim forKey:@"keyFrames"];
}
//CATransition
- (void)transitionAnimation{
    //初始化CATransition对象
    CATransition *anim = [CATransition animation];
    //转场类型
    anim.type = kCATransitionPush;
    //动画执行时间
    anim.duration = 2.f;
    //动画执行方向
    anim.subtype = kCATransitionFromLeft;
    //添加动画
    [self.yellowIV.layer addAnimation:anim forKey:nil];
}
-(void)animationGroup{
    
    //创建旋转动画对象
    CABasicAnimation *rotate = [CABasicAnimation animation];
    //旋转属性
    rotate.keyPath = @"transform.rotation";
    //角度
    rotate.toValue = @(M_PI*2);
    //调用CGAffineTransformRotate方法时M_PI*2计算完成后值为0.
    //             anim.toValue = [NSValue valueWithCGAffineTransform:CGAffineTransformRotate(self.yellowIV.transform, M_PI*2)];
    
    
    //创建缩放动画对象
    CABasicAnimation *scale = [CABasicAnimation animation];
    //缩放属性
    scale.keyPath = @"transform.scale";
    //缩放比例
    scale.toValue = @(0.0);
    
    //初始化CAAnimationGroup对象
    CAAnimationGroup *group = [CAAnimationGroup animation];
    //添加到动画组当中
    group.animations = @[rotate,scale];
    //执行动画时间
    group.duration = 2.f;
    //添加动画
    [self.yellowIV.layer addAnimation:group forKey:nil];

}
#pragma mark -- lazyload
- (UIImageView *)redIV{
    if (!_redIV) {
        _redIV = [UIImageView new];
        _redIV.backgroundColor = [UIColor redColor];
        [self.yellowIV addSubview:_redIV];
        [_redIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(Height_NavBar+30);
            make.width.height.mas_equalTo(60);
            make.centerX.equalTo(self.view);
        }];
    }
    return _redIV;
}

- (UIImageView *)yellowIV{
    if (!_yellowIV) {
        _yellowIV = [UIImageView new];
        _yellowIV.backgroundColor = [UIColor yellowColor];
        [self.view addSubview:_yellowIV];
        [_yellowIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(80);
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.view).offset(Height_NavBar+20);
        }];
    }
    return _yellowIV;
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
