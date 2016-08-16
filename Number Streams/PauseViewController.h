//
//  PauseViewController.h
//  Number Streams
//
//  Created by Chan Hee Park on 6/5/14.
//  Copyright (c) 2014 Chan Park. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import "EditorViewController.h"
@import AudioToolbox;
@interface PauseViewController : UIViewController <ADBannerViewDelegate>
@property BOOL resumePressed;
- (IBAction)buttonPressed:(id)sender;

@end
