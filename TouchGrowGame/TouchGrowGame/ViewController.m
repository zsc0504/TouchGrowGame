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
#define KMainScreenWidth            [[UIScreen mainScreen] bounds].size.width

#define kRunningManViewHeight       20.0
#define kRunningManViewWidth        10.0
#define kRunningManViewInitialX     80.0
#define kRunningManViewInitialY     (kMainScreenHeight*2/3)

#define kTouchGrowViewX             (kRunningManViewInitialX + kRunningManViewWidth)
#define kTouchGrowViewY             (kRunningManViewInitialY + kRunningManViewHeight)

#define kBottomViewY                kTouchGrowViewY
#define kBottomViewHeight           (kMainScreenHeight - kBottomViewY)


@interface ViewController ()<UIAlertViewDelegate>
{
    NSTimer *growTimer;
    TouchGrowView *tgView;
    UIView *firstBottomView;
    RunningManView *runningMan;
    RandomView *randomBottomView;
    UIView *foreView;
    UIView *nextView;
    NSInteger count;
    UILabel *countL;
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
    [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview) withObject:nil];
    count = 0;
    countL = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, KMainScreenWidth, 30)];
    countL.textColor = [UIColor whiteColor];
    countL.layer.cornerRadius = 5.0f;
    countL.layer.masksToBounds = YES;
    countL.textAlignment = NSTextAlignmentCenter;
    countL.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    countL.text = [NSString stringWithFormat:@"%ld",count];
    [self.view addSubview:countL];
    
    UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, KMainScreenWidth, 80)];
    l.backgroundColor = [UIColor clearColor];
    l.textColor = [UIColor blackColor];
    l.numberOfLines = 0;
    l.textAlignment = NSTextAlignmentCenter;
    l.text = @"将手放在屏幕，使杆变长";
    [self.view addSubview:l];
    
    [self initRunningManView];
    [self initFirstBottomView];
    [self initTouchView];
    foreView = firstBottomView;
    nextView = randomBottomView;
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
    
    randomBottomView = [[RandomView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(firstBottomView.frame)+100, kBottomViewY, 70, kBottomViewHeight)];
    randomBottomView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:randomBottomView];
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
        BOOL isDrop = NO;
        if (length >= CGRectGetMinX(nextView.frame) - CGRectGetMaxX(foreView.frame) && length <= CGRectGetMaxX(nextView.frame) - CGRectGetMaxX(foreView.frame))
        {
            length = CGRectGetMaxX(nextView.frame) - CGRectGetMaxX(foreView.frame);
            count++;
            countL.text = [NSString stringWithFormat:@"%ld",count];
        }else{
            isDrop = YES;
        }
        [runningMan run:length after:^{
            if (isDrop)
            {
                [tgView dropAfter:^(float length) {
                }];
                [runningMan dropAfter:^{
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"失败啦" message:@"再接再厉，重新再来吧！" delegate:self cancelButtonTitle:@"再玩一次" otherButtonTitles:nil, nil];
                    [alert show];
                }];
            }else{
                CGRect foreRect = foreView.frame;
                CGRect nextRect = nextView.frame;
                CGRect runManRect = runningMan.frame;
                CGRect touchGrowRect = tgView.frame;

                CGFloat distance = runManRect.origin.x - kRunningManViewInitialX;
                RandomView *randomView = [[RandomView alloc] initWithFrame:CGRectMake(arc4random_uniform((int)(KMainScreenWidth - kRunningManViewInitialX - kRunningManViewWidth- 80))+kRunningManViewInitialX+kRunningManViewWidth+30, foreView.frame.origin.y, 10, foreView.frame.size.height)];
                randomView.backgroundColor = [UIColor blackColor];
                CGRect randomRect = randomView.frame;
                CGFloat tempX = randomRect.origin.x;
                randomRect.origin.x = KMainScreenWidth;
                randomView.frame = randomRect;
                [self.view addSubview:randomView];
                
                foreRect.origin.x -= distance;
                nextRect.origin.x -= distance;
                runManRect.origin.x -= distance;
                touchGrowRect.origin.x -= distance;
                touchGrowRect.origin.y -= 5;
                randomRect.origin.x = tempX;
                [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    foreView.frame = foreRect;
                    nextView.frame = nextRect;
                    runningMan.frame = runManRect;
                    tgView.frame = touchGrowRect;
                    randomView.frame = randomRect;
                } completion:^(BOOL finished) {
                    [foreView removeFromSuperview];
                    foreView = nextView;
                    nextView = randomView;
                }];
            }
        }];
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [self initSubViews];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
