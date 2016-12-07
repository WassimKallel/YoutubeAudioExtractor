//
//  ViewController.m
//  YoutubeAudioExtract
//
//  Created by Wassim Kallel on 15/06/2016.
//  Copyright © 2016 Wizzlabs. All rights reserved.
//

// TODO LIST !!!!
//
// -Check if textFiled Content is a valid Youtube URL
// 
//

#import "ViewController.h"
#import "JXcore.h"
#import "YoutubeApi.h"


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *videoUrlField;
@property (weak, nonatomic) IBOutlet UITextField *directLinkField;

@property (strong, nonatomic) YoutubeApi  *yt;

- (IBAction)btnUpdate:(id)sender;
@end

@implementation ViewController

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _yt = [[YoutubeApi alloc]init];
}

- (IBAction)btnUpdate:(id)sender {
    if (![_yt initialized])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Application not ready"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    } else {
        NSString *Url = [_videoUrlField text];
        NSString *newUrl = [_yt getDirectUrl:Url];
        [self.view endEditing:YES];
        [_directLinkField setText:newUrl];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
