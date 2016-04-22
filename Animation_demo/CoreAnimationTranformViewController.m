//
//  CoreAnimationTranformViewController.m
//  Animation_demo
//
//  Created by rong on 16/4/21.
//  Copyright © 2016年 rong. All rights reserved.
//

#import "CoreAnimationTranformViewController.h"

#define IMAGE_COUNT 5

@interface CoreAnimationTranformViewController ()

@property (strong, nonatomic) UIImageView *imageView;
@property (assign, nonatomic) NSInteger currentIndex;

@end

@implementation CoreAnimationTranformViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    _imageView = [[UIImageView alloc] init];
    [self.view addSubview:_imageView];
    [_imageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.left.right.bottom.equalTo(self.view);
    }];
    _imageView.image = [UIImage imageNamed:@"1.jpg"];
    _currentIndex = 1;
    
    UISwipeGestureRecognizer *leftSwip = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipImage:)];
    leftSwip.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:leftSwip];
    
    UISwipeGestureRecognizer *rightSwip = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipImage:)];
    rightSwip.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightSwip];

    
}

- (void)leftSwipImage:(UISwipeGestureRecognizer *)swip{
    [self transitionAnimation:YES];
}

- (void)rightSwipImage:(UISwipeGestureRecognizer *)swip{
    [self transitionAnimation:NO];
}

- (void)transitionAnimation:(BOOL)isNext{
    CATransition *transition = [[CATransition alloc] init];
    transition.type = @"cube";
    
    if (isNext) {
        transition.subtype = kCATransitionFromRight;
    }else{
        transition.subtype = kCATransitionFromLeft;
    }
    
    transition.duration = 1.0f;
    if ((_currentIndex == IMAGE_COUNT && isNext) || (!isNext && _currentIndex == 1))return;
    _imageView.image = [self getImage:isNext];
    [_imageView.layer addAnimation:transition forKey:@"transition_animation"];
}

- (UIImage *)getImage:(BOOL)isNext{
    if (isNext) {
//        _currentIndex = (_currentIndex+1)%IMAGE_COUNT;
        _currentIndex ++;
        NSLog(@"下一张：%ld",_currentIndex);
    }else{
//        _currentIndex = (_currentIndex-1+IMAGE_COUNT)%IMAGE_COUNT;
        _currentIndex --;
        NSLog(@"上一张：%ld",_currentIndex);
    }
    NSString *imgName = [NSString stringWithFormat:@"%ld.jpg",_currentIndex];
    UIImage *image = [UIImage imageNamed:imgName];
    return image;
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
