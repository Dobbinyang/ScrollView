//
//  ViewController.m
//  ScrollView
//
//  Created by ybb on 2017/1/6.
//  Copyright © 2017年 ybb. All rights reserved.
//

#import "ViewController.h"
#import "NewViewController.h"

@interface ViewController ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIPageControl *pc;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    //创建UIScrollView
    [self createScrollView];
    
    //创建UIPageControl
    [self createUIPageControl];
}

- (void)createScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.delegate = self;
    //尺寸等于屏幕的大小
    scrollView.frame = self.view.bounds;
    scrollView.contentSize = CGSizeMake(4 * scrollView.bounds.size.width, scrollView.bounds.size.height);
    for (NSInteger i = 0; i < 4; i ++) {
        UIImageView *imageV = [[UIImageView alloc] init];
        imageV.frame = CGRectMake(i * scrollView.bounds.size.width, 0, scrollView.bounds.size.width, scrollView.bounds.size.height);
        imageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"welcome%ld", i + 1]];
        [scrollView addSubview:imageV];
        if (i == 3) {
            [self createUIButtonClick:imageV];
        }
    }
    [self.view addSubview:scrollView];
    //设置弹簧效果
    scrollView.bounces = NO;
    //页面是否平移
    scrollView.pagingEnabled = YES;
    //水平效果
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
}

- (void)createUIPageControl
{
    UIPageControl *pc = [[UIPageControl alloc] init];
    self.pc = pc;
    pc.frame = CGRectMake(0, self.view.bounds.size.height - 60, self.view.bounds.size.width, 40);
    //UIPageControl的个数
    pc.numberOfPages = 4;
    //未选中的颜色
    pc.pageIndicatorTintColor = [UIColor whiteColor];
    //选中时的颜色
    pc.currentPageIndicatorTintColor = [UIColor orangeColor];
    pc.userInteractionEnabled = NO;
    [self.view addSubview:pc];
}

- (void)createUIButtonClick:(UIImageView *)imageV
{
    imageV.userInteractionEnabled = YES;
    UIButton *enterButton = [[UIButton alloc] init];
    enterButton.frame = CGRectMake(imageV.bounds.size.width * 0.5 - 50, imageV.bounds.size.height * 0.6, 100, 50);
    enterButton.backgroundColor = [UIColor orangeColor];
    [enterButton setTitle:@"立即进入" forState:UIControlStateNormal];
    [enterButton addTarget:self action:@selector(enterApp:) forControlEvents:UIControlEventTouchUpInside];
    [imageV addSubview:enterButton];
}

- (void)enterApp:(UIButton *)Btn
{
    NewViewController *newVC = [[NewViewController alloc] init];
    UIApplication *app = [UIApplication sharedApplication];
    app.keyWindow.rootViewController = newVC;
}

#pragma mark - UIScrollViewDelegate协议
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    self.pc.currentPage = round(offset.x / scrollView.bounds.size.width);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
