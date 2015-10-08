//
//  TouchGrowView.m
//  TouchGrowGame
//
//  Created by Songchao Zhang on 15/8/6.
//  Copyright (c) 2015年 UcfPay. All rights reserved.
//

#import "TouchGrowView.h"

typedef NS_ENUM(NSUInteger, TouchGrowViewRotationType)
{
    kTouchGrowRotationEndGrow = 0,
    kTouchGrowRotationDrop
};

@interface TouchGrowView()
{
    
}
@property (nonatomic, assign)float rate;        //设置0.01秒的速率

@end

@implementation TouchGrowView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame rate:(float)rate
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.layer.anchorPoint = CGPointMake(0, 1);
        _rate = rate;
        self.backgroundColor = [UIColor blackColor];
        self.frame = frame;
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.layer.anchorPoint = CGPointMake(0, 1);
        _rate = 1;
        self.backgroundColor = [UIColor blackColor];
        self.frame = frame;
    }
    return self;
}
static int isGrowUP = 1;

- (void)growHeight
{
    CGRect myRect = self.frame;
    if (myRect.origin.y <= 40)
    {
        isGrowUP = -1;
    }else if (myRect.size.height <= 0){
        isGrowUP = 1;
    }
    myRect.size.height += _rate*isGrowUP;
    myRect.origin.y -= _rate*isGrowUP;
    self.frame = myRect;
}

- (void)endGrowAfter:(void (^)(float))endGrowHandler
{
    [self rotaionWithAngle:M_PI_2 type:kTouchGrowRotationEndGrow handler:endGrowHandler];
}

- (void)dropAfter:(void (^)(float))endGrowHandler
{
    [self rotaionWithAngle:M_PI_2 type:kTouchGrowRotationDrop handler:endGrowHandler];
}

#pragma mark - Private Method

- (void)rotaionWithAngle:(float)angle type:(TouchGrowViewRotationType )type handler:(void (^)(float))endGrowHandler
{
    [UIView animateWithDuration:0.4 animations:^{
        self.transform = CGAffineTransformRotate(self.transform, angle);
    } completion:^(BOOL finished) {
        endGrowHandler(self.frame.size.width);
    }];
}
@end
