//
//  ViewController.m
//  PreDemObjcDemo
//
//  Created by WangSiyu on 21/02/2017.
//  Copyright © 2017 pre-engineering. All rights reserved.
//

#import "ViewController.h"
#import <PreDemObjc/PREDemObjc.h>


@interface ViewController ()
<
UIPickerViewDataSource,
UIPickerViewDelegate
>

@property (nonatomic, strong) IBOutlet UILabel *versionLable;
@property (nonatomic, strong) IBOutlet UIPickerView *logLevelPicker;
@property (nonatomic, strong) NSArray *logPickerKeys;
@property (nonatomic, strong) NSArray *logPickerValues;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.versionLable.text = PREDManager.version;
    self.logLevelPicker.dataSource = self;
    self.logLevelPicker.delegate = self;
    self.logPickerKeys = @[
                               @"不上传 log",
                               @"PREDLogLevelOff",
                               @"PREDLogLevelError",
                               @"PREDLogLevelWarning",
                               @"PREDLogLevelInfo",
                               @"PREDLogLevelDebug",
                               @"PREDLogLevelVerbose",
                               @"PREDLogLevelAll"
                               ];
    self.logPickerValues = @[
                           @(PREDLogLevelOff),
                           @(PREDLogLevelError),
                           @(PREDLogLevelWarning),
                           @(PREDLogLevelInfo),
                           @(PREDLogLevelDebug),
                           @(PREDLogLevelVerbose),
                           @(PREDLogLevelAll)
                           ];
}

- (IBAction)logTest:(id)sender {
    PREDLogVerbose(@"verbose log test");
    PREDLogDebug(@"debug log test");
    PREDLogInfo(@"info log test");
    PREDLogWarn(@"warn log test");
    PREDLogError(@"error log test");
}

- (IBAction)sendHTTPRequest:(id)sender {
    NSArray *urls = @[@"http://www.baidu.com", @"https://www.163.com", @"http://www.qq.com", @"https://www.dehenglalala.com", @"http://www.balabalabalatest.com", @"http://www.alipay.com"];
    for (NSString *urlString in urls) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            NSURL *url = [NSURL URLWithString:urlString];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            NSURLSession *session = [NSURLSession sharedSession];
            NSURLSessionDataTask *task = [session dataTaskWithRequest:request];
            [task resume];
        });
    }
}

- (IBAction)diagnoseNetwork:(id)sender {
    [PREDManager  diagnose:@"www.qiniu.com" complete:^(PREDNetDiagResult * _Nonnull result) {
        NSLog(@"new diagnose completed with result:\n %@", result);
    }];
}

- (IBAction)forceCrash:(id)sender {
    @throw [NSException exceptionWithName:@"Manually Exception" reason:@"嗯，我是故意的" userInfo:nil];
}

- (IBAction)diyEvent:(id)sender {
    int rand = arc4random_uniform(100);
    NSDictionary *dict = @{
                           @"stringKey": [NSString stringWithFormat:@"test_%d", rand],
                           @"longKey": @(rand),
                           @"floatKey": @1.5
                           };
    [PREDManager trackEventWithName:@"test_ios_event_4" event:dict];
}

- (IBAction)blockMainThread:(id)sender {
    sleep(1);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.logPickerKeys.count;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component __TVOS_PROHIBITED {
    return self.logPickerKeys[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component __TVOS_PROHIBITED; {
    if (row == 0) {
        [PREDLogger stopCaptureLog];
    } else {
        [PREDLogger startCaptureLogWithLevel:(PREDLogLevel)[self.logPickerValues[row-1] intValue]];
    }
}


@end
