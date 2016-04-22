//
//  CALayerDrawViewController.m
//  Animation_demo
//
//  Created by rong on 16/4/20.
//  Copyright © 2016年 rong. All rights reserved.
//

#import "CALayerDrawViewController.h"

#define PHOTO_HEIGHT 150.0

@interface CALayerDrawViewController ()

@end

@implementation CALayerDrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    CALayer *layer = [[CALayer alloc] init];
    layer.delegate = self;
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.position = self.view.center;
    layer.cornerRadius = PHOTO_HEIGHT/2.0;
    layer.masksToBounds = YES;;
//    layer.transform = CATransform3DMakeRotation(M_PI, 1, 0, 0);
    layer.bounds = CGRectMake(0, 0, PHOTO_HEIGHT, PHOTO_HEIGHT);
    
//    UIImage *image = [UIImage imageNamed:@"img1.jpg"];
//    [layer setContents:(id)image.CGImage];
    [self.view.layer addSublayer:layer];

    
    [layer setNeedsDisplay];

}

#pragma mark - 
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    CGContextSaveGState(ctx);
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -PHOTO_HEIGHT);
    UIImage *image = [UIImage imageNamed:@"img1.jpg"];
    
    CGContextDrawImage(ctx, CGRectMake(0, 0, PHOTO_HEIGHT, PHOTO_HEIGHT), image.CGImage);
    CGContextRestoreGState(ctx);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    CALayer *layer = self.view.layer.sublayers[0];
    layer.delegate = nil;
}

- (void)dealloc{
    NSLog(@"self.view:%@",self.view);
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
