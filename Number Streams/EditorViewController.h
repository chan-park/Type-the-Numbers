//
//  EditorViewController.h
//  Number Streams
//
//  Created by Chan Hee Park on 6/3/14.
//  Copyright (c) 2014 Chan Park. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import <QuartzCore/QuartzCore.h>
#import "ViewController.h"
#import "GameOverViewController.h"
#import "CongratulationViewController.h"
#import "PauseViewController.h"
@import AudioToolbox;
@interface EditorViewController : UIViewController <ADBannerViewDelegate>
@property (nonatomic, strong) NSString *mode;
- (void) stopTimer;
@end
