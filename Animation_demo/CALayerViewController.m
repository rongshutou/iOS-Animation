//
//  CALayerViewController.m
//  Animation_demo
//
//  Created by rong on 16/4/20.
//  Copyright © 2016年 rong. All rights reserved.
//

#import "CALayerViewController.h"

#define WIDTH 50.0

@interface CALayerViewController ()

@end

@implementation CALayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initLayer];
    
    UILabel *tip = [[UILabel alloc] init];
    tip.text = @"touch anywhere you want";
    [self.view addSubview:tip];
    [tip makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.centerX.equalTo(self.view);
    }];

    
}

- (void)initLayer{
    CALayer *layer = [[CALayer alloc] init];
    layer.backgroundColor = [UIColor colorWithRed:0 green:146/255.0 blue:1.0 alpha:1.0].CGColor;
    layer.cornerRadius = WIDTH/2.0;
    layer.position = self.view.center;
    layer.bounds = CGRectMake(0, 0, WIDTH, WIDTH);
    
    layer.shadowColor = [UIColor grayColor].CGColor;
    layer.shadowOffset = CGSizeMake(5, 5);
    layer.shadowOpacity = .9;
    
    [self.view.layer addSublayer:layer];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint newPoint = [touch locationInView:self.view];
    CALayer *layer = self.view.layer.sublayers[0];
    CGFloat width = layer.bounds.size.width;
    if (width == WIDTH) {
        width = WIDTH *4;
    }else{
        width = WIDTH;
    }
    layer.bounds = CGRectMake(0, 0, width, width);
    layer.position = newPoint;
    layer.cornerRadius = width/2.0;
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
