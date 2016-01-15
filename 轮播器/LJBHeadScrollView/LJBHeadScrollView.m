//
//  LJBHeadScrollView.m
//  test1
//
//  Created by liuguopan on 15/12/30.
//  Copyright © 2015年 viewcreator3d. All rights reserved.
//

#import "LJBHeadScrollView.h"

@interface LJBHeadScrollView ()<UIScrollViewDelegate>

@property(nonatomic,weak)UIScrollView *scrollView;
@property(nonatomic,weak)UIPageControl *page;
@property(nonatomic,strong)NSTimer *timer;
@end

@implementation LJBHeadScrollView

- (void)setUpVc {
    if (self.scrollView) {
        [self.scrollView removeFromSuperview];
    }
    CGFloat padding = 10;
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    self.scrollView = scrollView;
    scrollView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.delegate = self;
    [self addSubview:scrollView];
    if (self.page) {
        [self.page removeFromSuperview];
    }
    if (self.showPage) {
        UIPageControl *page = [[UIPageControl alloc] init];
        self.page = page;
        page.numberOfPages = self.imageLists.count;
        page.currentPage = 0;
        CGFloat pageWidth = padding * page.numberOfPages;
        CGFloat pageHeight = padding;
        page.frame = CGRectMake(self.frame.size.width * 0.5 - pageWidth * 0.5, self.frame.size.height - pageHeight - 2 * padding, pageWidth, pageHeight);
        page.pageIndicatorTintColor = [UIColor lightGrayColor];
        page.currentPageIndicatorTintColor = [UIColor orangeColor];
        [self addSubview:page];
    }
}

- (void)setImageLists:(NSArray *)imageLists {
    _imageLists = imageLists;
    [self setUpVc];
    
    NSInteger count = imageLists.count < 2?imageLists.count:(imageLists.count + 2);
    for (int i = 0; i < count; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        NSString *image = nil;
        if (i == 0) {
            image = [imageLists lastObject];
        } else if (i == count - 1) {
            image = [imageLists firstObject];
        } else {
            image = imageLists[i - 1];
        }
        imageView.image = [UIImage imageNamed:image];
        imageView.frame = CGRectMake(i * self.scrollView.frame.size.width, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
        imageView.tag = i - 1;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)];
        [imageView addGestureRecognizer:tap];
        [self.scrollView addSubview:imageView];
    }
    self.scrollView.contentSize = CGSizeMake(count * self.scrollView.frame.size.width, 0);
    self.scrollView.contentOffset = CGPointMake(count < 2?0:self.scrollView.frame.size.width, 0);
    
    [self createTimer];
}

- (void)createTimer {
    [self.timer invalidate];
    self.timer = nil;
    if (self.useTimer && self.times) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:self.times target:self selector:@selector(changeImage) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
    }
}

- (void)changeImage {
    NSInteger count = self.imageLists.count < 2?self.imageLists.count:(self.imageLists.count + 2);
    if (count >= 2) {
        CGPoint point = self.scrollView.contentOffset;
        if (point.x == (count - 1) * self.scrollView.frame.size.width
            || point.x == (count - 2) * self.scrollView.frame.size.width) {
            point.x = self.scrollView.frame.size.width;
            self.scrollView.contentOffset = point;

        } else {
            point.x += self.scrollView.frame.size.width;
            [UIView animateWithDuration:0.5 animations:^{
                self.scrollView.contentOffset = point;
            }];

        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self createTimer];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint point = scrollView.contentOffset;
    NSInteger count = self.imageLists.count < 2?self.imageLists.count:(self.imageLists.count + 2);
    if (count >= 2) {
        if (point.x >= scrollView.frame.size.width * (count - 1)) {
            scrollView.contentOffset = CGPointMake(scrollView.frame.size.width, 0);
        }
        if (point.x <= 0) {
            scrollView.contentOffset = CGPointMake(scrollView.frame.size.width * (count - 2), 0);
        }
        point = scrollView.contentOffset;
        NSInteger currentPage = (point.x + self.scrollView.frame.size.width * 0.5) / self.scrollView.frame.size.width;

        self.page.currentPage = currentPage - 1;
        
    }
}

- (void)tapImage:(UITapGestureRecognizer *)tap {
    NSInteger tag = tap.view.tag;
    if ([self.delegate respondsToSelector:@selector(LJBHeadScrollView:index:)]) {
        [self.delegate LJBHeadScrollView:self index:tag];
    }
}

@end
