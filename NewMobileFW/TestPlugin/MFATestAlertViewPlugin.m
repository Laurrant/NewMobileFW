//
//  TestAlertView.m
//  NewMobileFW
//
//  Created by ElandApple02 on 15-3-24.
//  Copyright (c) 2015年 eland. All rights reserved.
//

#import "MFATestAlertViewPlugin.h"

@implementation MFATestAlertViewPlugin

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)test:(NSMutableDictionary *)data
{
    NSLog(@"testtttt");
    NSString *callBack=[data objectForKey:@"callbackId"];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"__MFA__SENDJSTOPAGE__" object:[NSString stringWithFormat:@"%@('%@')",callBack,@"test"]];
}
@end
