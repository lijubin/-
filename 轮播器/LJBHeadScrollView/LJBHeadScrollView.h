//
//  LJBHeadScrollView.h
//  test1
//
//  Created by liuguopan on 15/12/30.
//  Copyright © 2015年 viewcreator3d. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LJBHeadScrollViewDelegate <NSObject>

@optional
- (void)LJBHeadScrollView:(UIView *)view index:(NSInteger)index;

@end

@interface LJBHeadScrollView : UIView

/** 是否显示UIPageControl */
@property(assign)BOOL showPage;

/** 是否启用计时器 */
@property(assign)BOOL useTimer;

/** 计时器时间 */
@property(assign)NSTimeInterval times;

/** 图片集合 */
@property(nonatomic,strong)NSArray *imageLists;

@property(assign)id<LJBHeadScrollViewDelegate>delegate;

@end
