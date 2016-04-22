//
//  NormalViewController.m
//  Animation_demo
//
//  Created by rong on 16/4/19.
//  Copyright © 2016年 rong. All rights reserved.
//

#import "NormalViewController.h"

@interface NormalViewController ()

@property (assign, nonatomic) AnimationType type;
@property (assign, nonatomic) BOOL isSelect;

@property (strong, nonatomic) UIView *animationView;
@property (strong, nonatomic) UIButton *animationBtn;
@property (strong, nonatomic) MASConstraint *startTopConstraint;
@property (strong, nonatomic) MASConstraint *startLeftConstraint;
@property (strong, nonatomic) MASConstraint *endBottomConstraint;
@property (strong, nonatomic) MASConstraint *endRightConstraint;

@end

@implementation NormalViewController

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
    self.animationView = [[UIView alloc] init];
    self.animationView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.animationView];
    [self.animationView makeConstraints:^(MASConstraintMaker *make) {
        self.startTopConstraint = make.top.equalTo(self.view).offset(70);
        self.startLeftConstraint = make.left.equalTo(self.view).offset(30);
        make.width.height.equalTo(@80);
    }];
    
    self.animationBtn = [[UIButton alloc] init];
    [self.animationBtn setTitle:@"开始动画" forState:UIControlStateNormal];
    [self.animationBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:self.animationBtn];
    [self.animationBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(70);
        make.right.equalTo(self.view).offset(-30);
    }];
    [self.animationBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];

}

#pragma mark -  翻转动画
- (void)clickBtn:(UIButton *)btn
{
     _isSelect = btn.selected;
    
    switch (_type) {
        case AnimationTypeNormal:
        {
            [self normalAnimation];
            break;}
        case AnimationTypeSpring:
        {
            [self springAnimation];
            break;}
        case AnimationTypeKeyframe:
        {
            [self keyframeAnimation];
            break;}
        case AnimationTransition:
        {
            [self transitionAnimation];
            break;}            
        default:
            break;
    }
}

#pragma mark - 常规动画
- (void)normalAnimation{
    [UIView animateWithDuration:1.0 animations:^{
        [self.animationView updateConstraints:^(MASConstraintMaker *make) {
            if (_isSelect) {
                self.startTopConstraint = make.top.equalTo(self.view).offset(70);
                self.startLeftConstraint = make.left.equalTo(self.view).offset(30);
                self.animationBtn.selected = NO;
                [self.endBottomConstraint uninstall];
                [self.endRightConstraint uninstall];
            }else{
                self.endBottomConstraint = make.bottom.equalTo(self.view).offset(-30);
                self.endRightConstraint = make.right.equalTo(self.view).offset(-30);
                self.animationBtn.selected = YES;
                [self.startTopConstraint uninstall];
                [self.startLeftConstraint uninstall];
            }
        }];
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark -  弹簧动画
- (void)springAnimation{
    [UIView animateWithDuration:6.0 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.animationView updateConstraints:^(MASConstraintMaker *make) {
            if (_isSelect) {
                self.startTopConstraint = make.top.equalTo(self.view).offset(70);
                self.startLeftConstraint = make.left.equalTo(self.view).offset(30);
                make.width.height.equalTo(@80);
                self.animationBtn.selected = NO;
                [self.endBottomConstraint uninstall];
                [self.endRightConstraint uninstall];
            }else{
                self.endBottomConstraint = make.center.equalTo(self.view);
                make.width.height.equalTo(@200);
                self.animationBtn.selected = YES;
                [self.startTopConstraint uninstall];
                [self.startLeftConstraint uninstall];
            }
        }];
        [self.view layoutIfNeeded];

    } completion:^(BOOL finished) {

    }];
}

#pragma mark - 关键帧动画
- (void)keyframeAnimation{
    [UIView animateKeyframesWithDuration:6.0 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        [self.animationView updateConstraints:^(MASConstraintMaker *make) {
            if (_isSelect) {
                self.startTopConstraint = make.top.equalTo(self.view).offset(70);
                self.startLeftConstraint = make.left.equalTo(self.view).offset(30);
                self.animationBtn.selected = NO;
                [self.endBottomConstraint uninstall];
                [self.endRightConstraint uninstall];
            }else{
                self.endBottomConstraint = make.bottom.equalTo(self.view).offset(-30);
                self.endRightConstraint = make.right.equalTo(self.view).offset(-30);
                self.animationBtn.selected = YES;
                [self.startTopConstraint uninstall];
                [self.startLeftConstraint uninstall];
            }
        }];
        [self.view layoutIfNeeded];
        
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:1/3.0 animations:^{
            self.animationView.backgroundColor = [UIColor redColor];
        }];
        
        [UIView addKeyframeWithRelativeStartTime:1/3.0 relativeDuration:1/3.0 animations:^{
            self.animationView.backgroundColor = [UIColor yellowColor];
        }];
        
        [UIView addKeyframeWithRelativeStartTime:2/3.0 relativeDuration:1/3.0 animations:^{
            self.animationView.backgroundColor = [UIColor redColor];
        }];
        
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - 转场动画
- (void)transitionAnimation{
    [UIView transitionWithView:self.animationView duration:2.0 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
        [self.animationView updateConstraints:^(MASConstraintMaker *make) {
            if (_isSelect) {
                self.startTopConstraint = make.top.equalTo(self.view).offset(70);
                self.startLeftConstraint = make.left.equalTo(self.view).offset(30);
                make.width.height.equalTo(@80);
                self.animationBtn.selected = NO;
                [self.endBottomConstraint uninstall];
                [self.endRightConstraint uninstall];
            }else{
                self.endBottomConstraint = make.center.equalTo(self.view);
                make.width.height.equalTo(@200);
                self.animationBtn.selected = YES;
                [self.startTopConstraint uninstall];
                [self.startLeftConstraint uninstall];
            }
        }];
        [self.view layoutIfNeeded];

    } completion:^(BOOL finished) {
        
    }];
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
