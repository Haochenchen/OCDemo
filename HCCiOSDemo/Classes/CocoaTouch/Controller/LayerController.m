//
//  LayerController.m
//  HCCiOSDemo
//
//  Created by info on 2018/6/28.
//  Copyright © 2018年 hao. All rights reserved.
//

#import "LayerController.h"
#import "CustomLayer.h"
@interface LayerController ()<CALayerDelegate>
{
    CALayer *layer;
}
@property(nonatomic, strong)CAEmitterLayer *emitterLayer;
@end

@implementation LayerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    
    [self setRootLayer];
    
    [self addImageLayer];
    
    [self setupLayerWitdDelegate];
    
    [self setupCustomLayer];
    
    [self setupShapeLayer];
    
    [self setupGradintLayer];
    
    [self startCAEmitterLayer];
    
    [self setupReplicatorLayer];
    
    [self setupTextLayer];
    
}

//根layer简单使用
- (void)setRootLayer{
    //初始化UIimageView对象
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"annotation"]];
    //设置阴影
    imageView.layer.shadowColor = [UIColor grayColor].CGColor;//颜色
    imageView.layer.shadowOffset = CGSizeMake(10, 10);//偏移量
    imageView.layer.shadowOpacity = 0.8;//不透明度
    //设置圆角大小
    imageView.layer.cornerRadius = 10;
    //设置边框
    imageView.layer.borderWidth = 2;//边框宽度
    imageView.layer.borderColor = [UIColor redColor].CGColor;//边框颜色
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(Height_NavBar+20);
        make.left.equalTo(self.view).offset(20);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
}

//添加一个显示显示图片的layer
- (void)addImageLayer{
    //初始化layer对象
    CALayer *imageLayer = [CALayer layer];
    //设置图层的宽高
    imageLayer.bounds = CGRectMake(0, 0, 100, 100);
    //设置图层的位置
    imageLayer.position = CGPointMake(250, Height_NavBar+70);
    //设置需要显示的图片
    imageLayer.contents = (id)[UIImage imageNamed:@"annotation"].CGImage;
    // 设置层的圆角半径为10
    imageLayer.cornerRadius = 10;
    // 如果设置了图片，需要设置这个属性为YES才有圆角效果
    imageLayer.masksToBounds = YES;
    //设置旋转
    imageLayer.transform = CATransform3DMakeRotation(M_PI_4, 0, 0, 1);
    //添加图层到控制器的view的layer上
    [self.view.layer addSublayer:imageLayer];
}

- (void)setupLayerWitdDelegate{
    //初始化layer对象
    layer = [CALayer layer];
    //设置图层的宽高
    layer.bounds = CGRectMake(0, 0, 100, 100);
    //设置图层的位置
    layer.position = CGPointMake(70, Height_NavBar+200);
    //设置图层代理
    layer.delegate = self;
    //添加图层到控制器的view的layer上
    [self.view.layer addSublayer:layer];
    //调用图层setNeedDisplay,否则代理方法不会被调用
    [layer setNeedsDisplay];
}

- (void)setupCustomLayer{
    //初始化layer对象
    CALayer *imageLayer = [CustomLayer layer];
    //设置图层的宽高
    imageLayer.bounds = CGRectMake(0, 0, 100, 100);
    //设置图层的位置
    imageLayer.position = CGPointMake(250, Height_NavBar+200);
    //添加图层到控制器的view的layer上
    [self.view.layer addSublayer:imageLayer];
    //调用图层setNeedDisplay,否则代理方法不会被调用
    [imageLayer setNeedsDisplay];
}

#pragma mark -- 绘制图形、图像到图层，注意参数中的ctx是图层的图形上下文，其中绘图位置也是相对图层而言的
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    CGContextSaveGState(ctx);
    
    //图形上下文形变，解决图片倒立的问题
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -100);
    
    UIImage *image = [UIImage imageNamed:@"annotation"];
    UIImage *image1 = [UIImage imageNamed:@"defaultImage"];
    //注意这个位置是相对于图层而言的不是屏幕
    CGContextDrawImage(ctx, CGRectMake(0, 0, 50, 100), image.CGImage);
    CGContextDrawImage(ctx, CGRectMake(50, 0, 50, 100), image1.CGImage);
    CGContextRestoreGState(ctx);

}


- (void)setupShapeLayer{
    //创建路径
    UIBezierPath *path = [[UIBezierPath alloc]init];
    [path moveToPoint:CGPointMake(50, 320)];
    [path addQuadCurveToPoint:CGPointMake(300, 320) controlPoint:CGPointMake(100, 420)];
    [path addQuadCurveToPoint:CGPointMake(50, 320) controlPoint:CGPointMake(100, 350)];
    //创建shapeLayer
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc]init];
    [self.view.layer addSublayer:shapeLayer];
    //呈现的形状的路径
    shapeLayer.path = path.CGPath;
    //填充路径的颜色,默认颜色为不透明的黑色。
    shapeLayer.fillColor = [UIColor redColor].CGColor;
    //设置描边色，默认无色。
    shapeLayer.strokeColor = [UIColor greenColor].CGColor;
    //线的宽度，默认为1
    shapeLayer.lineWidth = 2;
    //lineJoin为线连接类型，其值也有三个类型，分别为kCALineJoinMiter、kCALineJoinRound、kCALineJoinBevel，默认值是Miter
    shapeLayer.lineJoin = kCALineJoinRound;
    //lineCap为线端点类型，值有三个类型，分别为kCALineCapButt 、kCALineCapRound 、kCALineCapSquare，默认值为Butt
    shapeLayer.lineCap = kCALineCapRound;
    
}

- (void)setupGradintLayer{
    //创建gradientLayer
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.bounds = CGRectMake(0, 0, 100, 100);
    gradientLayer.position = CGPointMake(70, Height_NavBar+370);
    [self.view.layer addSublayer:gradientLayer];
    //渐变颜色的数组
    gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor,
                             (__bridge id)[UIColor blueColor].CGColor];
    //渐变颜色的区间分布，默认是nil，会平均分布。
    gradientLayer.locations =  @[@(0.2), @(0.5), @(0.8)];
    // 起始点
    gradientLayer.startPoint = CGPointMake(0.0, 0.0);
    // 结束点
    gradientLayer.endPoint = CGPointMake(1.0, 1.0);
}

- (void)startCAEmitterLayer {
    // EmitterLayer
    
    self.emitterLayer = [CAEmitterLayer layer];
    self.emitterLayer.frame = CGRectMake(150, Height_NavBar+320, 200, 100);
    self.emitterLayer.masksToBounds = YES;
    self.emitterLayer.emitterShape = kCAEmitterLayerLine;
    self.emitterLayer.emitterMode = kCAEmitterLayerSurface;
    self.emitterLayer.emitterSize = self.emitterLayer.frame.size;
    self.emitterLayer.emitterPosition = CGPointMake(self.emitterLayer.frame.size.width / 2.f, -10);
    self.emitterLayer.backgroundColor = [UIColor cyanColor].CGColor;
    [self setEmitterCell];
    [self.view.layer addSublayer:self.emitterLayer];
}
- (void)setEmitterCell {
    CAEmitterCell *rainflake = [CAEmitterCell  emitterCell];
    rainflake.birthRate = 5.f;
    rainflake.speed = 10.f;
    rainflake.velocity        = 10.f;
    rainflake.velocityRange   = 10.f;
    rainflake.yAcceleration   = 1000.f;
    rainflake.contents        = (__bridge id)([UIImage imageNamed:@"heart.png"].CGImage);
    rainflake.lifetime        = 160.f;
    rainflake.scale           = 0.2f;
    rainflake.scaleRange      = 0.f;
    
    
    CAEmitterCell *snowflake  = [CAEmitterCell emitterCell];
    snowflake.birthRate       = 0.2f;
    snowflake.speed           = 10.f;
    snowflake.velocity        = 5.f;
    snowflake.velocityRange   = 10.f;
    snowflake.yAcceleration   = 10.f;
    snowflake.emissionRange   = 0.5 * M_PI;
    snowflake.spinRange       = 0.25 * M_PI;
    snowflake.contents        = (__bridge id)([UIImage imageNamed:@"kiss.png"].CGImage);
    snowflake.lifetime        = 160.f;
    snowflake.scale           = 0.3f;
    snowflake.scaleRange      = 0.1f;
    //添加到EmitterLayer中
    self.emitterLayer.emitterCells = @[snowflake,rainflake];
}

- (void)setupReplicatorLayer{
    CAReplicatorLayer *relayer = [CAReplicatorLayer layer];
    [relayer addSublayer:layer];
    relayer.frame = self.view.frame;
    relayer.instanceCount = 2;
    
    //move reflection instance below original and flip vertically
    CATransform3D transform = CATransform3DIdentity;
    CGFloat verticalOffset = layer.frame.size.height-140;
    transform = CATransform3DTranslate(transform, 0, verticalOffset, 0);
    transform = CATransform3DScale(transform, 1, -1, 0);
    relayer.instanceTransform = transform;
    
    relayer.instanceAlphaOffset = -0.5;
    
    [self.view.layer addSublayer:relayer];
}

- (void)setupTextLayer{
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.frame = CGRectMake(20, Height_NavBar+440, 340, 100);
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    [self.view.layer addSublayer:textLayer];
    
    //set text attributes
    textLayer.foregroundColor = [UIColor orangeColor].CGColor;
    textLayer.alignmentMode = kCAAlignmentJustified;
    textLayer.wrapped = YES;
    
    //choose a font
    UIFont *font = [UIFont systemFontOfSize:15];
    
    //set layer font
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    textLayer.font = fontRef;
    textLayer.fontSize = font.pointSize;
    CGFontRelease(fontRef);
    
    //choose some text
    NSString *text = @"Core Animation提供了一个CALayer的子类CATextLayer，它以图层的形式包含了UILabel几乎所有的绘制特性，并且额外提供了一些新的特性。";
    
    //set layer text
    textLayer.string = text;
}

- (void)dealloc{
    layer.delegate = nil;
    
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
