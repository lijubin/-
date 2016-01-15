//
//  ViewController.m
//  轮播器
//
//  Created by 李居彬 on 15/12/31.
//  Copyright © 2015年 ljb. All rights reserved.
//

#import "ViewController.h"
#import "LJBHeadScrollView.h"

@interface ViewController ()<LJBHeadScrollViewDelegate>
@property(assign)int selArrIndex;
@property(nonatomic,weak)LJBHeadScrollView *scrollView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
        LJBHeadScrollView *scrollView = [[LJBHeadScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height * 0.8)];
        scrollView.delegate = self;
        scrollView.showPage = YES;
        scrollView.useTimer = YES;
        scrollView.times = 5;
        self.scrollView = scrollView;
        [self.view addSubview:scrollView];
        [self changeImage];
    
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn.frame = CGRectMake(0, self.view.frame.size.height - 100, 100, 50);
        [btn setTitle:@"更改图片" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(changeImage) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
}

- (void)changeImage {
    if (self.selArrIndex) {
        self.scrollView.imageLists = @[@"达达兔1.jpg",@"达达兔2.jpg",@"达达兔3.jpg"];
        self.selArrIndex = 0;
    } else {
        self.scrollView.imageLists = @[@"0.jpg",@"1.jpg",@"2.jpg",@"3.jpg"];
        self.selArrIndex = 1;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
