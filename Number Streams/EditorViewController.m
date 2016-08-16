//
//  EditorViewController.m
//  Number Streams
//
//  Created by Chan Hee Park on 6/3/14.
//  Copyright (c) 2014 Chan Park. All rights reserved.
//

#import "EditorViewController.h"
#define CLASSIC_MAX_NUMBER 50
#define ZEN_TIME 30
@interface EditorViewController ()
{
    BOOL _initialPress;
    
    int _numberOfDigitPressed;
    
    float _elapsedTime;
    NSTimer *_timer;
    
    
    SystemSoundID correctButtonSound, wrongButtonSound;
}

@property (weak, nonatomic) IBOutlet UIButton *mute;
@property (weak, nonatomic) IBOutlet UILabel *stream1;
@property (weak, nonatomic) IBOutlet UILabel *stream2;
@property (weak, nonatomic) IBOutlet UILabel *stream3;
@property (weak, nonatomic) IBOutlet UILabel *stream4;
@property (weak, nonatomic) IBOutlet UILabel *stream5;
@property (weak, nonatomic) IBOutlet UILabel *stream6;
@property (weak, nonatomic) IBOutlet UILabel *stream7;
@property (weak, nonatomic) IBOutlet UILabel *stream8;
@property (weak, nonatomic) IBOutlet UILabel *stream9;
@property (weak, nonatomic) IBOutlet UILabel *reactionStream;
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;
@property (weak, nonatomic) IBOutlet UIButton *button5;
@property (weak, nonatomic) IBOutlet UIButton *button6;
@property (weak, nonatomic) IBOutlet UIButton *button7;
@property (weak, nonatomic) IBOutlet UIButton *button8;
@property (weak, nonatomic) IBOutlet UIButton *button9;
@property (weak, nonatomic) IBOutlet UIButton *button0;
@property (weak, nonatomic) IBOutlet UIButton *buttonPause;
@property (weak, nonatomic) IBOutlet UIButton *uselessButton;
@property float time;
@property (weak, nonatomic) IBOutlet UILabel *info;
@property (weak, nonatomic) IBOutlet UILabel *instruction;
@property (weak, nonatomic) IBOutlet UILabel *beginsWhenTapped;
@property (weak, nonatomic) IBOutlet UILabel *dots;
- (IBAction)digitPressed:(id)sender;
- (void)loadStream;
- (void)enqueue;
- (void)dequeue;
- (void)buttonLayoutInitialize;
@end

@implementation EditorViewController
@synthesize mode;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(saveGameState) name: UIApplicationDidEnterBackgroundNotification object: nil];
    }
    return self;
}

- (void)saveGameState {
    NSLog(@"hi");
}

- (IBAction)digitPressed:(id)sender {
    UIButton *buttonPressed = (UIButton *) sender;
    if (_initialPress == NO && ![buttonPressed.titleLabel.text isEqualToString:@"PAUSE"]) {
        _initialPress = YES;
        [self startTimer];
        
        [UIView transitionWithView:self.instruction
                          duration:0.4
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:NULL
                        completion:NULL];
        self.instruction.hidden = YES;
        self.beginsWhenTapped.hidden = YES;
    }
    
    
    if ([self.mode isEqualToString:@"classic"]) {
        if (_numberOfDigitPressed == 40) {
            self.dots.hidden = YES;
        }
        
        if ([buttonPressed.titleLabel.text isEqualToString: self.stream1.text]) {
            int temp = self.info.text.intValue - 1;
            self.info.text = [NSString stringWithFormat:@"%i", temp];
            [self dequeue];
            [self enqueue];
            
            _numberOfDigitPressed++;
            
            AudioServicesPlaySystemSound(correctButtonSound);
        } else if (![buttonPressed.titleLabel.text isEqualToString: @"PAUSE"] && ![buttonPressed.titleLabel.text isEqualToString: self.stream1.text]){
            self.mute.hidden = NO;
            AudioServicesPlayAlertSound(wrongButtonSound);
            [self stopTimer];
            [self performSelector:@selector(gameOver) withObject:nil afterDelay:1];
        }
        
        if (_numberOfDigitPressed == CLASSIC_MAX_NUMBER) {
            [self congrats];
        }
    } else if ([self.mode isEqualToString:@"zen"]){
        if ([buttonPressed.titleLabel.text isEqualToString: self.stream1.text]) {
            [self dequeue];
            [self enqueue];
            AudioServicesPlaySystemSound(correctButtonSound);
            _numberOfDigitPressed++;
        } else if (![buttonPressed.titleLabel.text isEqualToString: @"PAUSE"] && ![buttonPressed.titleLabel.text isEqualToString: self.stream1.text]){
            self.mute.hidden = NO;
            AudioServicesPlayAlertSound(wrongButtonSound);

            [self stopTimer];
            [self performSelector:@selector(gameOver) withObject:nil afterDelay:1];
        }

    } else if ([self.mode isEqualToString:@"reaction"]) {
        if ([buttonPressed.titleLabel.text isEqualToString: self.reactionStream.text]) {
            [self loadStream];
            AudioServicesPlaySystemSound(correctButtonSound);
            _numberOfDigitPressed++;
        } else if (![buttonPressed.titleLabel.text isEqualToString: @"PAUSE"] && ![buttonPressed.titleLabel.text isEqualToString: self.reactionStream.text]){
            self.mute.hidden = NO;
            AudioServicesPlayAlertSound(wrongButtonSound);
            [self stopTimer];
            [self performSelector:@selector(gameOver) withObject:nil afterDelay:1];
        }
    }
}

- (void)dequeue {
    self.stream1.text = self.stream2.text;
    self.stream2.text = self.stream3.text;
    self.stream3.text = self.stream4.text;
    self.stream4.text = self.stream5.text;
    self.stream5.text = self.stream6.text;
    self.stream6.text = self.stream7.text;
    self.stream7.text = self.stream8.text;
    self.stream8.text = self.stream9.text;
    
}

- (void)enqueue {
  
    
    if (_numberOfDigitPressed < 41 || [self.mode isEqualToString:@"zen"]) {
        self.stream9.text = [NSString stringWithFormat: @"%i", arc4random_uniform(10)];
    } else {
        self.stream9.text = [NSString stringWithFormat: @""];
    }
    
}

- (void)congrats {
    [self stopTimer];
    [self performSegueWithIdentifier:@"congratulation" sender:self];
}

- (void)gameOver {
    
    [self performSegueWithIdentifier:@"gameover" sender:self];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString: @"congratulation"]) {
        CongratulationViewController *vc = [segue destinationViewController];
        if ([self.mode isEqualToString:@"classic"]) {
            vc.time = self.time;
        } else if ([self.mode isEqualToString:@"zen"]) {
            vc.steps = _numberOfDigitPressed;
        } else if ([self.mode isEqualToString:@"reaction"]) {
            vc.steps = _numberOfDigitPressed;
        }
        
    } else if ([[segue identifier] isEqualToString: @"gameover"]) {
        
    } else if ([[segue identifier] isEqualToString: @"pause"]){
        [self pauseTimer];
    }
    
}

- (void)loadStream {
    if ([self.mode isEqualToString:@"reaction"]) {
        self.reactionStream.text = [NSString stringWithFormat:@"%i", arc4random_uniform(10)];
    } else {
        self.stream1.text = [NSString stringWithFormat: @"%i", arc4random_uniform(10)];
        self.stream2.text = [NSString stringWithFormat: @"%i", arc4random_uniform(10)];
        self.stream3.text = [NSString stringWithFormat: @"%i", arc4random_uniform(10)];
        self.stream4.text = [NSString stringWithFormat: @"%i", arc4random_uniform(10)];
        self.stream5.text = [NSString stringWithFormat: @"%i", arc4random_uniform(10)];
        self.stream6.text = [NSString stringWithFormat: @"%i", arc4random_uniform(10)];
        self.stream7.text = [NSString stringWithFormat: @"%i", arc4random_uniform(10)];
        self.stream8.text = [NSString stringWithFormat: @"%i", arc4random_uniform(10)];
        self.stream9.text = [NSString stringWithFormat: @"%i", arc4random_uniform(10)];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _numberOfDigitPressed = 0;
    _initialPress = NO;
    [self buttonLayoutInitialize];
    [self loadStream];
    self.dots.hidden = NO;
    _elapsedTime = 0;
    
    NSString *correctButtonSoundFile = [[NSBundle mainBundle]pathForResource:@"lowbeep" ofType:@"wav"];
    NSString *wrongButtonSoundFile = [[NSBundle mainBundle]pathForResource:@"highbeep" ofType:@"wav"];
    
    AudioServicesCreateSystemSoundID((__bridge CFURLRef) [NSURL fileURLWithPath:correctButtonSoundFile], &correctButtonSound);
    AudioServicesCreateSystemSoundID((__bridge CFURLRef) [NSURL fileURLWithPath:wrongButtonSoundFile], &wrongButtonSound);
    
    self.mute.hidden = YES;
    if ([self.mode isEqualToString:@"zen"]) {
        self.info.text = [NSString stringWithFormat:@"%i.00\"", ZEN_TIME];
        
        self.instruction.textColor = [UIColor redColor];
        self.instruction.text = @"Follow as many numbers as you can within 30 seconds";
        self.view.backgroundColor = [UIColor colorWithRed:90.0/255.0 green:200.0/255.0 blue:250.0/255.0 alpha:1.0];
        self.stream1.hidden = NO;
        self.stream2.hidden = NO;
        self.stream3.hidden = NO;
        self.stream4.hidden = NO;
        self.stream5.hidden = NO;
        self.stream6.hidden = NO;
        self.stream7.hidden = NO;
        self.stream8.hidden = NO;
        self.stream9.hidden = NO;
        self.reactionStream.hidden = YES;
    } else if ([self.mode isEqualToString:@"classic"]) {
        self.info.text = [NSString stringWithFormat:@"%i", CLASSIC_MAX_NUMBER];
        
        self.instruction.textColor = [UIColor redColor];
        self.instruction.text = @"Follow 50 numbers as fast as you can";
        self.view.backgroundColor = [UIColor colorWithRed:254.0/255.0 green:217.0/255.0 blue:100.0/255.0 alpha:1.0];
        self.stream1.hidden = NO;
        self.stream2.hidden = NO;
        self.stream3.hidden = NO;
        self.stream4.hidden = NO;
        self.stream5.hidden = NO;
        self.stream6.hidden = NO;
        self.stream7.hidden = NO;
        self.stream8.hidden = NO;
        self.stream9.hidden = NO;
        self.reactionStream.hidden = YES;
    } else if ([self.mode isEqualToString:@"reaction"]) {
        self.info.text = [NSString stringWithFormat:@"%i.00\"", ZEN_TIME];
        
        self.instruction.textColor = [UIColor redColor];
        self.instruction.text = @"Follow as many numbers as you can within 30 seconds";
        self.view.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:200.0/255.0 blue:250.0/255.0 alpha:1.0];
        self.stream1.hidden = YES;
        self.stream2.hidden = YES;
        self.stream3.hidden = YES;
        self.stream4.hidden = YES;
        self.stream5.hidden = YES;
        self.stream6.hidden = YES;
        self.stream7.hidden = YES;
        self.stream8.hidden = YES;
        self.stream9.hidden = YES;
        self.reactionStream.hidden = NO;
        self.dots.hidden = YES;
    }
}

- (void)buttonLayoutInitialize {
//    self.button0.layer.cornerRadius = 8.0;
//    self.button1.layer.cornerRadius = 8.0;
//    self.button2.layer.cornerRadius = 8.0;
//    self.button3.layer.cornerRadius = 8.0;
//    self.button4.layer.cornerRadius = 8.0;
//    self.button5.layer.cornerRadius = 8.0;
//    self.button6.layer.cornerRadius = 8.0;
//    self.button7.layer.cornerRadius = 8.0;
//    self.button8.layer.cornerRadius = 8.0;
//    self.button9.layer.cornerRadius = 8.0;
//    self.buttonPause.layer.cornerRadius = 8.0;
//    self.uselessButton.layer.cornerRadius = 8.0;
    
    self.button0.layer.masksToBounds = YES;
    self.button1.layer.masksToBounds = YES;
    self.button2.layer.masksToBounds = YES;
    self.button3.layer.masksToBounds = YES;
    self.button4.layer.masksToBounds = YES;
    self.button5.layer.masksToBounds = YES;
    self.button6.layer.masksToBounds = YES;
    self.button7.layer.masksToBounds = YES;
    self.button8.layer.masksToBounds = YES;
    self.button9.layer.masksToBounds = YES;
    self.buttonPause.layer.masksToBounds = YES;
    self.uselessButton.layer.masksToBounds = YES;
//    self.button0.layer.backgroundColor = [UIColor lightGrayColor].CGColor;
//    self.button1.layer.backgroundColor = [UIColor lightGrayColor].CGColor;
//    self.button2.layer.backgroundColor = [UIColor lightGrayColor].CGColor;
//    self.button3.layer.backgroundColor = [UIColor lightGrayColor].CGColor;
//    self.button4.layer.backgroundColor = [UIColor lightGrayColor].CGColor;
//    self.button5.layer.backgroundColor = [UIColor lightGrayColor].CGColor;
//    self.button6.layer.backgroundColor = [UIColor lightGrayColor].CGColor;
//    self.button7.layer.backgroundColor = [UIColor lightGrayColor].CGColor;
//    self.button8.layer.backgroundColor = [UIColor lightGrayColor].CGColor;
//    self.button9.layer.backgroundColor = [UIColor lightGrayColor].CGColor;
    
//    self.buttonPause.layer.backgroundColor = [UIColor blackColor].CGColor;

}


- (void)viewDidAppear:(BOOL)animated {
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)unwindToEditor: (UIStoryboardSegue *)segue {
    UIViewController *source = segue.sourceViewController;
    
    if ([source isKindOfClass: [CongratulationViewController class]]) {
        self.instruction.hidden = NO;
        _numberOfDigitPressed = 0;
        [self stopTimer];
        _initialPress = NO;
        self.mute.hidden = YES;
        self.beginsWhenTapped.hidden = NO;
        [self loadStream];
        if ([self.mode isEqualToString:@"zen"]) {
            self.dots.hidden = NO;
            self.info.text = [NSString stringWithFormat:@"%i.00\"", ZEN_TIME];
        } else if ([self.mode isEqualToString:@"classic"]) {
            self.dots.hidden = NO;
            self.info.text = [NSString stringWithFormat:@"%i", CLASSIC_MAX_NUMBER];
        } else if ([self.mode isEqualToString:@"reaction"]) {
            self.info.text = [NSString stringWithFormat:@"%i.00\"", ZEN_TIME];
        }
        
    } else if ([source isKindOfClass:[GameOverViewController class]]) {
        self.instruction.hidden = NO;
        _numberOfDigitPressed = 0;
        [self stopTimer];
        _initialPress = NO;
        self.mute.hidden = YES;
        self.beginsWhenTapped.hidden = NO;
        [self loadStream];
        if ([self.mode isEqualToString:@"zen"]) {
            self.dots.hidden = NO;
            self.info.text = [NSString stringWithFormat:@"%i.00\"", ZEN_TIME];
        } else if ([self.mode isEqualToString:@"classic"]) {
            self.dots.hidden = NO;
            self.info.text = [NSString stringWithFormat:@"%i", CLASSIC_MAX_NUMBER];
        } else if ([self.mode isEqualToString:@"reaction"]) {
            self.info.text = [NSString stringWithFormat:@"%i.00\"", ZEN_TIME];
        }
    } else if ([source isKindOfClass:[PauseViewController class]]) {
        PauseViewController *sourceVC = segue.sourceViewController;
        if (sourceVC.resumePressed && _initialPress == YES) {
            NSLog(@"Resume pressed");
            [self resumeTimer];
        } else if (!sourceVC.resumePressed){
            self.instruction.hidden = NO;
            _numberOfDigitPressed = 0;
            [self stopTimer];
            _initialPress = NO;
            [self loadStream];
            self.mute.hidden = YES;
            self.beginsWhenTapped.hidden = NO;
            
            if ([self.mode isEqualToString:@"zen"]) {
                self.dots.hidden = NO;
                self.info.text = [NSString stringWithFormat:@"%i.00\"", ZEN_TIME];
            } else if ([self.mode isEqualToString:@"classic"]) {
                self.dots.hidden = NO;
                self.info.text = [NSString stringWithFormat:@"%i", CLASSIC_MAX_NUMBER];
            } else if ([self.mode isEqualToString:@"reaction"]) {
                self.info.text = [NSString stringWithFormat:@"%i.00\"", ZEN_TIME];
            }
        }
    }
}
#pragma mark - Timer Methods
- (void)startTimer {
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(tickTimer) userInfo:nil repeats:YES];
}

- (void)tickTimer {
    //NSLog(@"%f", _elapsedTime);
    if ([self.mode isEqualToString:@"zen"] || [self.mode isEqualToString:@"reaction"]) {
        self.info.text = [NSString stringWithFormat:@"%0.2f\"", ZEN_TIME - _elapsedTime];
        SystemSoundID tick;
        NSString *applauseSoundFile = [[NSBundle mainBundle]pathForResource:@"tick" ofType:@"wav"];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef) [NSURL fileURLWithPath:applauseSoundFile], &tick);
        if ([[NSString stringWithFormat:@"%.2f", ZEN_TIME - _elapsedTime] isEqualToString: @"5.00"]) {
            AudioServicesPlaySystemSound(tick);
        } else if([[NSString stringWithFormat:@"%.2f", ZEN_TIME - _elapsedTime] isEqualToString: @"4.00"]) {
            AudioServicesPlaySystemSound(tick);
        } else if([[NSString stringWithFormat:@"%.2f", ZEN_TIME - _elapsedTime] isEqualToString: @"3.00"]) {
            AudioServicesPlaySystemSound(tick);
        } else if([[NSString stringWithFormat:@"%.2f", ZEN_TIME - _elapsedTime] isEqualToString: @"2.00"]) {
            AudioServicesPlaySystemSound(tick);
        } else if([[NSString stringWithFormat:@"%.2f", ZEN_TIME - _elapsedTime] isEqualToString: @"1.00"]) {
            AudioServicesPlaySystemSound(tick);
        } else if([[NSString stringWithFormat:@"%.2f", ZEN_TIME - _elapsedTime] isEqualToString: @"0.00"]){
            AudioServicesPlaySystemSound(tick);
        }
    }
    
    if (_elapsedTime >= ZEN_TIME && ([self.mode isEqualToString: @"zen"] || [self.mode isEqualToString: @"reaction"])) {
        [self stopTimer];
        [self performSegueWithIdentifier:@"congratulation" sender:self];
    }
    
    _elapsedTime += 0.01;
}

- (void)pauseTimer {
    if ([_timer isValid])
        [_timer invalidate];
}

- (void)resumeTimer {
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(tickTimer) userInfo:nil repeats:YES];
}

- (void)stopTimer {
    
    self.time = _elapsedTime;
    _elapsedTime = 0;
    [_timer invalidate];
}


#pragma mark - iAd Delegate Methods
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
