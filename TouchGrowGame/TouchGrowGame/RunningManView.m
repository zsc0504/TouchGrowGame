//
//  RunningManView.m
//  TouchGrowGame
//
//  Created by Songchao Zhang on 15/8/6.
//  Copyright (c) 2015年 UcfPay. All rights reserved.
//

#import "RunningManView.h"

static NSString *runAnimationKey = @"runPozitionAnimation";
static NSString *dropAnimationKey = @"dropPozitionAnimation";

@interface RunningManView()
{
    CGPoint originPoint;
}
@end

@implementation RunningManView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)run:(float)distance after:(dispatch_block_t)result
{
    originPoint = self.frame.origin;
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.frame = CGRectMake(originPoint.x + distance, originPoint.y, self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
        result();
    }];
//    if ([self.layer animationForKey:runAnimationKey])
//    {
//        [self.layer addAnimation:[self.layer animationForKey:runAnimationKey] forKey:runAnimationKey];
//    }else
//    {
//        CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
//        basicAnimation.duration = 0.5;
//        basicAnimation.delegate = self;
//        basicAnimation.removedOnCompletion = NO;
//        basicAnimation.fillMode = kCAFillModeForwards;
//        basicAnimation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
//        basicAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(originPoint.x + distance, originPoint.y)];
//        [self.layer addAnimation:basicAnimation forKey:runAnimationKey];
//    }
}


- (void)dropAfter:(void(^)(void))endGrowHandler
{
    CGRect rect = self.frame;
    rect.origin.y = [UIScreen mainScreen].bounds.size.height;
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.frame = rect;
    } completion:^(BOOL finished) {
        endGrowHandler();
    }];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (flag)
    {
        if ([anim isEqual:[self.layer animationForKey:runAnimationKey]])
        {
            
        }
    }

}

@end
