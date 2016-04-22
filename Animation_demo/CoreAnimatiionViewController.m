//
//  CoreAnimatiionViewController.m
//  Animation_demo
//
//  Created by rong on 16/4/20.
//  Copyright © 2016年 rong. All rights reserved.
//

#import "CoreAnimatiionViewController.h"

@interface CoreAnimatiionViewController ()

@property (assign, nonatomic) AnimationType type;
@property (strong, nonatomic) CALayer *layer;

@end

@implementation CoreAnimatiionViewController

- (instancetype)initWithAnimationType:(AnimationType)type{
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _layer = [[CALayer alloc] init];
    _layer.bounds = CGRectMake(0, 0, 20, 20);
    _layer.position = CGPointMake(20, 74);
    
    UIImage *image = [UIImage imageNamed:@"img2"];
    [_layer setContents:(id)image.CGImage];
    
    [self.view.layer addSublayer:_layer];
        
    if (_type == AnimationTypeCoreKeyframe) {
        [self keyframeAnimation];
    }
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (_type == AnimationTypeCoreBase) {
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:self.view];
        CAAnimation *animation = [_layer animationForKey:@"base_animation"];
        if (animation) {
            if (_layer.speed == 0) {
                [self animationResume];
            }else{
                [self animationPause];
            }
        }else{
            [self baseAnimation:point];
            [self rotationAnimation];
        }
    }
}

//位置变化
- (CABasicAnimation *)baseAnimation:(CGPoint)point{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.toValue = [NSValue valueWithCGPoint:point];
    animation.duration = 1.0;
    animation.delegate = self;
    [animation setValue:[NSValue valueWithCGPoint:point] forKey:@"base_animation_value"];
    [_layer addAnimation:animation forKey:@"base_animation"];
    return animation;
}

//旋转
- (CABasicAnimation *)rotationAnimation{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.toValue = [NSNumber numberWithFloat:M_PI_2*3];
    animation.duration = 1.0;
    animation.autoreverses = YES;
    [_layer addAnimation:animation forKey:@"rotation_animation"];
    return animation;
}


//开始
- (void)animationResume{
    CFTimeInterval interval = [_layer convertTime:CACurrentMediaTime() fromLayer:nil];
    [_layer setTimeOffset:interval];
    _layer.speed = 0;
}

//暂停
- (void)animationPause{
    CFTimeInterval beginTime = CACurrentMediaTime()-_layer.timeOffset;
    _layer.timeOffset = 0;
    _layer.beginTime = beginTime;
    _layer.speed = 1.0;
}

//关键帧动画-贝塞尔曲线
- (CAKeyframeAnimation *)keyframeAnimation{
    CAKeyframeAnimation *keyframeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];

    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, _layer.position.x, _layer.position.y);
    CGPathAddCurveToPoint(path, NULL, 160, 280, -30, 300, 55, 400);
    keyframeAnimation.path = path;
    CGPathRelease(path);
    
    keyframeAnimation.duration = 5.0;
    keyframeAnimation.beginTime = CACurrentMediaTime()+1.0;
    keyframeAnimation.repeatCount = HUGE_VALF;
    
    [_layer addAnimation:keyframeAnimation forKey:@"keyframe_animation"];
    return keyframeAnimation;
}


////关键帧动画-属性值
//- (void)keyframeAnimation{
//    CAKeyframeAnimation *keyframeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
//    NSValue *key1 = [NSValue valueWithCGPoint:_layer.position];
//    NSValue *key2=[NSValue valueWithCGPoint:CGPointMake(80, 220)];
//    NSValue *key3=[NSValue valueWithCGPoint:CGPointMake(45, 300)];
//    NSValue *key4=[NSValue valueWithCGPoint:CGPointMake(55, 400)];
//    NSArray *values = @[key1,key2,key3,key4];
//    keyframeAnimation.values = values;
//
//    keyframeAnimation.duration = 5.0;
//    keyframeAnimation.beginTime = CACurrentMediaTime()+1.0;
//    keyframeAnimation.repeatCount = HUGE_VALF;
//    
//    [_layer addAnimation:keyframeAnimation forKey:@"keyframe_animation"];
//}

#pragma mark - delegate methods
- (void)animationDidStart:(CAAnimation *)anim{
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    _layer.position = [[anim valueForKey:@"base_animation_value"] CGPointValue];
    [CATransaction commit];
    [self animationPause];
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
