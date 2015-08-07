//
//  ViewController.m
//  TouchGrowGame
//
//  Created by Songchao Zhang on 15/8/6.
//  Copyright (c) 2015年 UcfPay. All rights reserved.
//

#import "ViewController.h"

#import "TouchGrowView.h"
#import "RandomView.h"
#import "RunningManView.h"


/*只需定义RunningMan的Frame即可，其他的会自适应*/

#define kMainScreenHeight           [[UIScreen mainScreen] bounds].size.height


#define kRunningManViewHeight       20.0
#define kRunningManViewWidth        10.0
#define kRunningManViewInitialX     80.0
#define kRunningManViewInitialY     (kMainScreenHeight*2/3)

#define kTouchGrowViewX     (kRunningManViewInitialX + kRunningManViewWidth)
#define kTouchGrowViewY     (kRunningManViewInitialY + kRunningManViewHeight)

#define kBottomViewY                kTouchGrowViewY
#define kBottomViewHeight           (kMainScreenHeight - kBottomViewY)


@interface ViewController ()
{
    NSTimer *growTimer;
    TouchGrowView *tgView;
    UIView *firstBottomView;
    RunningManView *runningMan;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initSubViews];
}

#pragma mark - Init Views

- (void)initSubViews
{
    [self initRunningManView];
    [self initFirstBottomView];
    [self initTouchView];
}

- (void)initRunningManView
{
    runningMan = [[RunningManView alloc] initWithFrame:CGRectMake(kRunningManViewInitialX, kRunningManViewInitialY, kRunningManViewWidth, kRunningManViewHeight)];
    runningMan.backgroundColor = [UIColor blackColor];
    [self.view addSubview:runningMan];
}

- (void)initFirstBottomView
{
    firstBottomView = [[UIView alloc]initWithFrame:CGRectMake(0, kBottomViewY, kRunningManViewInitialX + kRunningManViewWidth,  kBottomViewHeight)];
    firstBottomView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:firstBottomView];
}


- (void)initTouchView
{
    CGRect touchViewRect = CGRectMake(kTouchGrowViewX, kTouchGrowViewY, 5, 0);
    if (tgView)
    {
        [tgView removeFromSuperview];
    }
    tgView = [[TouchGrowView alloc]initWithFrame:touchViewRect rate:1];
    [self.view addSubview:tgView];
}

/*
 *  随时间增长
 */
- (void)callTimer
{
    growTimer = [NSTimer timerWithTimeInterval:0.01 target:tgView selector:@selector(growHeight) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:growTimer forMode:NSDefaultRunLoopMode];
    [growTimer fire];
}

/*
 *  点击屏幕的时候，自增长
 */
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self initTouchView];
    [self callTimer];
}

/*
 *  离开屏幕后关闭自增长，调用旋转
 */
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [growTimer invalidate];
    [tgView endGrowAfter:^(float length) {
        [runningMan run:length];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
