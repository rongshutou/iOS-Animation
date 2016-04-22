//
//  ViewController.m
//  Animation_demo
//
//  Created by rong on 16/4/18.
//  Copyright © 2016年 rong. All rights reserved.
//

#import "ViewController.h"
#import "NormalViewController.h"
#import "CALayerViewController.h"
#import "CALayerDrawViewController.h"
#import "CoreAnimatiionViewController.h"
#import "CoreAnimationGroupViewController.h"
#import "CoreAnimationTranformViewController.h"
#import "CoreAnimationCADisplayLinkViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *data;
@property (strong, nonatomic) NSArray *controllers;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"Masonry动画";
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    self.data = @[@"一般动画",@"弹簧动画",@"关键帧动画",@"转场动画",@"CALayer动画",@"CALayer绘图",@"Core Animation基础动画",@"Core Animation关键帧动画",@"Core Animation动画组",@"Core Animation转场动画",@"Core Animation逐帧动画"];
    self.controllers = @[@(AnimationTypeNormal),@(AnimationTypeSpring),@(AnimationTypeKeyframe),@(AnimationTransition),@(AnimationTypeCALayer),@(AnimationTypeCALayerDraw),@(AnimationTypeCoreBase),@(AnimationTypeCoreKeyframe),@(AnimationTypeCoreGroup),@(AnimationTypeCoreTranform),@(AnimationTypeCoreCADisplayLink)];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = self.data[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AnimationType type = [self.controllers[indexPath.row] integerValue];
    UIViewController *vc;
    if (type == AnimationTypeCALayer) {
        CALayerViewController *calayerVC = [[CALayerViewController alloc] init];
        vc = calayerVC;
    }else if(type == AnimationTypeCALayerDraw){
        CALayerDrawViewController *calayerDrawVC = [[CALayerDrawViewController alloc] init];
        vc = calayerDrawVC;
    }else if(type == AnimationTypeCoreKeyframe || type == AnimationTypeCoreBase){
        CoreAnimatiionViewController *coreVC = [[CoreAnimatiionViewController alloc] initWithAnimationType:type];
        vc = coreVC;

    }else if(type == AnimationTypeCoreGroup){
        CoreAnimationGroupViewController *groupVC = [[CoreAnimationGroupViewController alloc] init];
        vc = groupVC;
    }else if(type == AnimationTypeCoreTranform){
        CoreAnimationTranformViewController *tranformVC = [[CoreAnimationTranformViewController alloc] init];
        vc = tranformVC;
    }else if(type == AnimationTypeCoreCADisplayLink){
        CoreAnimationCADisplayLinkViewController *cadisplayLinkVC = [[CoreAnimationCADisplayLinkViewController alloc] init];
        vc = cadisplayLinkVC;
    }else{
        NormalViewController *normalVC = [[NormalViewController alloc] initWithAnimationType:type];
        vc = normalVC;
    }
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
