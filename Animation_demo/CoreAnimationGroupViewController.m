//
//  CoreAnimationGroupViewController.m
//  Animation_demo
//
//  Created by rong on 16/4/21.
//  Copyright © 2016年 rong. All rights reserved.
//

#import "CoreAnimationGroupViewController.h"

@interface CoreAnimationGroupViewController ()

@property (strong, nonatomic) CALayer *layer;


@end

@implementation CoreAnimationGroupViewController

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
    
    [self groupAnimation];

}

//动画组
- (void)groupAnimation{
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    CABasicAnimation *basicAnimation = [self rotationAnimation];
    CAKeyframeAnimation *keyframeAnimation = [self keyframeAnimation];
    animationGroup.animations = @[basicAnimation,keyframeAnimation];
    
    animationGroup.delegate = self;
    animationGroup.duration = 5.0;
    animationGroup.beginTime = CACurrentMediaTime()+1.0;
    animationGroup.repeatCount = HUGE_VALF;
    
    [_layer addAnimation:animationGroup forKey:nil];
}

//旋转
- (CABasicAnimation *)rotationAnimation{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.toValue = [NSNumber numberWithFloat:M_PI_2*3];
    animation.duration = 1.0;
    animation.autoreverses = YES;
    [animation setValue:[NSNumber numberWithFloat:M_PI_2*3] forKey:@"base_animation_toValue"];
    return animation;
}

//关键帧动画-贝塞尔曲线
- (CAKeyframeAnimation *)keyframeAnimation{
    CAKeyframeAnimation *keyframeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    CGPoint endPoint = CGPointMake(55, 400);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, _layer.position.x, _layer.position.y);
    CGPathAddCurveToPoint(path, NULL, 160, 280, -30, 300, endPoint.x, endPoint.y);
    keyframeAnimation.path = path;
    CGPathRelease(path);
    
    [keyframeAnimation setValue:[NSValue valueWithCGPoint:endPoint] forKey:@"keyframeAnimation_endPosition"];
    
    return keyframeAnimation;
}

#pragma mark - delegate methods
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    CAAnimationGroup *animationGroup = (CAAnimationGroup *)anim;
    CABasicAnimation *basicAnimation = animationGroup.animations[0];
    CAKeyframeAnimation *keyframeAnimation = animationGroup.animations[1];
    CGFloat toValue = [[basicAnimation valueForKey:@"base_animation_toValue"] floatValue];
    CGPoint endPoint = [[keyframeAnimation valueForKey:@"keyframeAnimation_endPosition"] CGPointValue];
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    _layer.position = endPoint;
    _layer.transform = CATransform3DMakeRotation(toValue, 0, 0, 1);
    [CATransaction commit];
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
