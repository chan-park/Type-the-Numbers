//
//  ViewController.h
//  Number Streams
//
//  Created by Chan Hee Park on 6/3/14.
//  Copyright (c) 2014 Chan Park. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditorViewController.h"
#import <iAd/iAd.h>
@import AudioToolbox;
@interface ViewController : UIViewController <ADBannerViewDelegate, UIAlertViewDelegate>

- (IBAction)buttonPressed:(id)sender;
@end
