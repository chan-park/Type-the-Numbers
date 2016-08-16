//
//  Timer.h
//  Number Streams
//
//  Created by Chan Hee Park on 6/4/14.
//  Copyright (c) 2014 Chan Park. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Timer : NSObject
{
    NSTimer *_timer;
}
@property float time;
- (void) start;
- (void) tick;
- (void) stop;
- (void) reset;
@end
