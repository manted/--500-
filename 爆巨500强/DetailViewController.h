//
//  DetailViewController.h
//  爆巨500强
//
//  Created by Manted on 2/02/2014.
//  Copyright (c) 2014 Ye Hua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApiObject.h"
#import "WXApi.h"

@protocol SendMsgToWeChatViewDelegate <NSObject>
- (void) sendTextContent:(NSString*)text toScene:(int)scene;
@end

@interface DetailViewController : UIViewController <UIActionSheetDelegate,SendMsgToWeChatViewDelegate>

@property (nonatomic, strong) NSArray *monthArray;
@property (nonatomic) NSInteger dateIndex;
@property (nonatomic) NSInteger messageIndex;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *year;
@property (nonatomic, strong) NSString *date;

//@property (nonatomic, assign) id<SendMsgToWeChatViewDelegate,NSObject> delegate;

//-(void)showSuccessView;

@end
