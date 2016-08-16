//
//  Timer.m
//  Number Streams
//
//  Created by Chan Hee Park on 6/4/14.
//  Copyright (c) 2014 Chan Park. All rights reserved.
//

#import "Timer.h"

@implementation Timer
@synthesize time;
- (void)start {
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.01
                                             target:self
                                           selector:@selector(tick)
                                           userInfo:nil
                                            repeats:YES];
    
}

- (void)tick {
    //NSLog(@"%f", self.time);
    self.time += 0.01;
}

- (void)stop {
    
}


- (void)reset {
    [_timer invalidate];
    self.time = 0.00;
    _timer = nil;
}

@end
