//
//  ViewController.m
//  Number Streams
//
//  Created by Chan Hee Park on 6/3/14.
//  Copyright (c) 2014 Chan Park. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    SystemSoundID buttonSound;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSString *buttonSoundFile = [[NSBundle mainBundle]pathForResource:@"transition" ofType:@"wav"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef) [NSURL fileURLWithPath:buttonSoundFile], &buttonSound);
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger launchCount = [userDefaults integerForKey: @"launchCount"];
    BOOL rated = [userDefaults boolForKey:@"rated"];
    
    if (launchCount == 10) {
        launchCount++;
        UIAlertView *rateAlertView = [[UIAlertView alloc] initWithTitle:@"Like my App?"
                                                                message:@"Please rate in on the App Store!"
                                                               delegate:self
                                                      cancelButtonTitle:@"No Thanks"
                                                      otherButtonTitles:@"OK, Rate Now", nil];
        
        [rateAlertView show];
    } else if (! rated && launchCount == 20) {
        launchCount++;
        UIAlertView *rateAlertView = [[UIAlertView alloc] initWithTitle:@"Like my App?"
                                                                message:@"Please rate in on the App Store!"
                                                               delegate:self
                                                      cancelButtonTitle:@"No Thanks"
                                                      otherButtonTitles:@"Don't ask me again, Rate Now", nil];
        
        [rateAlertView show];
    }
    
    
    
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)unwindToMain:(UIStoryboardSegue *)segue {
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"gameScene"]) {
        ((EditorViewController *)segue.destinationViewController).mode = ((UIButton *)sender).titleLabel.text;
    }
}
- (IBAction)buttonPressed:(id)sender {
    AudioServicesPlaySystemSound(buttonSound);
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        // code here to go to apple store [[UIApplication sharedApplication] openURL: "URL to the app here"];
        [[NSUserDefaults standardUserDefaults] setBool: YES forKey: @"rated"];
        
        
    }
}
#pragma mark iAd Delegate Methods
- (void)bannerViewDidLoadAd:(ADBannerView *)banner {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [banner setAlpha:1];
    [UIView commitAnimations];
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [banner setAlpha:0];
    [UIView commitAnimations];
}
@end
