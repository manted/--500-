//
//  DetailViewController.m
//  爆巨500强
//
//  Created by Manted on 2/02/2014.
//  Copyright (c) 2014 Ye Hua. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (nonatomic, strong) UIView *sucView;
@property (nonatomic, strong) NSTimer *timer;

- (IBAction)forward:(UIBarButtonItem *)sender;

@end

@implementation DetailViewController

//@synthesize delegate = _delegate;

-(NSArray*)monthArray
{
    if (!_monthArray) {
        _monthArray = [[NSArray alloc]init];
    }
    return _monthArray;
}

-(void)setMessage:(NSString *)message
{
    _message = message;
    self.messageLabel.text = self.message;
}

-(void)setDate:(NSString *)date
{
    _date = date;
    self.dateLabel.text = [NSString stringWithFormat:@"%@.%@",self.year,self.date];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.message = [self getMessageFromDateIndex:self.dateIndex MessageIndex:self.messageIndex];
    self.messageLabel.text = self.message;
    self.dateLabel.text = [NSString stringWithFormat:@"%@.%@",self.year,self.date];
}

- (IBAction)forward:(UIBarButtonItem *)sender
{
    //do wechat thing
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"用微信分享至" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"朋友圈",@"会话", nil];
    [sheet showInView:self.view];
}

-(NSString*)getMessageFromDateIndex:(int)dateIndex MessageIndex:(int)messageIndex
{
    return [[[[self.monthArray objectAtIndex:dateIndex]objectForKey:@"content"]objectAtIndex:messageIndex]objectForKey:@"msg"];
}

-(NSString*)getDateFromDateIndex:(int)dateIndex
{
    return [[self.monthArray objectAtIndex:dateIndex]objectForKey:@"date"];
}

- (IBAction)lastMessage:(UIBarButtonItem *)sender
{
    if (self.messageIndex > 0) {
        self.messageIndex--;
        self.message = [self getMessageFromDateIndex:self.dateIndex MessageIndex:self.messageIndex];
        self.date = [self getDateFromDateIndex:self.dateIndex];
    }else{
        if (self.dateIndex > 0) {
            self.dateIndex --;
            self.messageIndex = [[[self.monthArray objectAtIndex:self.dateIndex]objectForKey:@"content"] count] - 1;
            self.message = [self getMessageFromDateIndex:self.dateIndex MessageIndex:self.messageIndex];
            self.date = [self getDateFromDateIndex:self.dateIndex];
        }
    }
}

- (IBAction)nextMessage:(UIBarButtonItem *)sender
{
    if (self.messageIndex < [[[self.monthArray objectAtIndex:self.dateIndex]objectForKey:@"content"]count] - 1) {
        self.messageIndex++;
        self.message = [self getMessageFromDateIndex:self.dateIndex MessageIndex:self.messageIndex];
        self.date = [self getDateFromDateIndex:self.dateIndex];
    }else{
        if (self.dateIndex < [self.monthArray count] - 1) {
            self.dateIndex++;
            self.messageIndex = 0;
            self.message = [self getMessageFromDateIndex:self.dateIndex MessageIndex:self.messageIndex];
            self.date = [self getDateFromDateIndex:self.dateIndex];
        }
    }
}

#pragma mark - action sheet
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *message = [NSString stringWithFormat:@"【爆巨500强】%@ %@",self.dateLabel.text,self.message];
    if (buttonIndex == 0) { // 朋友圈
        [self sendTextContent:message toScene:WXSceneTimeline];
    }else if (buttonIndex == 1){  // 会话
        [self sendTextContent:message toScene:WXSceneSession];
    }
}

//-(void)showSuccessView
//{
//    int width = 100;
//    int height = 80;
//    self.sucView = [[UIView alloc]initWithFrame:CGRectMake((320 - width) / 2, (480 - height) / 2, width, height)];
//    self.sucView.backgroundColor = [UIColor lightGrayColor];
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(8, 25, 84, 30)];
//    label.text = @"分享成功";
//    [self.sucView addSubview:label];
//    [self.view addSubview:self.sucView];
//    
//    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1
//                                                      target:self
//                                                    selector:@selector(changeAlpha)
//                                                    userInfo:nil
//                                                     repeats:YES];
//    [_timer fire];
//}
//
//-(void)changeAlpha
//{
//    NSLog(@"change alpha");
//    if (self.sucView.alpha > 0.05f) {
//        self.sucView.alpha -= 0.05f;
//    }else{
//        [self.sucView removeFromSuperview];
//        self.sucView = nil;
//        [_timer invalidate];
//    }
//}

#pragma mark - SendMsgToWeChatView delegate

- (void) sendTextContent:(NSString*)text toScene:(int)scene
{
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.text = text;
    req.bText = YES;
    req.scene = scene;
    
    [WXApi sendReq:req];
}

//-(void)onResp:(BaseResp *)resp
//{
//    NSLog(@"detail onResp");
//}

@end
