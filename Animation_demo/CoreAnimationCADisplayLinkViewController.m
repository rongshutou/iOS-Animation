//
//  CoreAnimationCADisplayLinkViewController.m
//  Animation_demo
//
//  Created by rong on 16/4/21.
//  Copyright © 2016年 rong. All rights reserved.
//

#import "CoreAnimationCADisplayLinkViewController.h"

#define IMAGE_COUNT 10

@interface CoreAnimationCADisplayLinkViewController ()

@property (strong, nonatomic) CALayer *layer;
@property (assign, nonatomic) NSInteger currentIndex;
@property (strong, nonatomic) NSMutableArray *images;

@end

@implementation CoreAnimationCADisplayLinkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view.layer setContents:(id)[UIImage imageNamed:@"bg"].CGImage];
    
    _layer = [[CALayer alloc] init];
    _layer.bounds = CGRectMake(0, 0, 89, 40);
    _layer.position = CGPointMake(190, 310);
    _layer.contents = [UIImage imageNamed:@"fish.0"];
    [self.view.layer addSublayer:_layer];
    
    _images = [NSMutableArray array];
    for (int index = 0; index < IMAGE_COUNT; index ++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"fish%d",index]];
        [_images addObject:image];
    }
    
    CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(step)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];

    
}

- (void)step
{
    static int s = 0;
    if (++s%10 == 0) {
        if (_currentIndex == 9) {
            _currentIndex = 0;
        }else{
            _currentIndex++;
            UIImage *image = _images[_currentIndex];
            [_layer setContents:(id)image.CGImage];
        }
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
