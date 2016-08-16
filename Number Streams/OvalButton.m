//
//  OvalButton.m
//  Number Streams
//
//  Created by Chan Hee Park on 6/8/14.
//  Copyright (c) 2014 Chan Park. All rights reserved.
//

#import "OvalButton.h"

@implementation OvalButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    //// Color Declarations
    UIColor* color2 = [UIColor colorWithRed: 0.788 green: 0.316 blue: 0.806 alpha: 1];
    
    //// Oval Drawing
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(60, 12, 50, 50)];
    [color2 setFill];
    [ovalPath fill];

}


@end
