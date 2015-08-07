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

- (void)run:(float)distance
{
    originPoint = self.layer.position;
    if ([self.layer animationForKey:runAnimationKey])
    {
        [self.layer addAnimation:[self.layer animationForKey:runAnimationKey] forKey:runAnimationKey];
    }else
    {
        CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
        basicAnimation.duration = 0.5;
        basicAnimation.delegate = self;
        basicAnimation.removedOnCompletion = NO;
        basicAnimation.fillMode = kCAFillModeForwards;
        basicAnimation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
        basicAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(originPoint.x + distance, originPoint.y)];
        [self.layer addAnimation:basicAnimation forKey:runAnimationKey];
    }
}


- (void)dropAfter:(void(^)(void))endGrowHandler
{
    endGrowHandler();
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
