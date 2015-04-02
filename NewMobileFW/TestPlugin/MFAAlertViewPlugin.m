//
//  MFAAlertViewPlugin.m
//  NewMobileFW
//
//  Created by ElandApple02 on 15-3-30.
//  Copyright (c) 2015年 eland. All rights reserved.
//

#import "MFAAlertViewPlugin.h"

@implementation MFAAlertViewPlugin

-(void)showAlert:(NSMutableDictionary *)data
{
    self.callBack=[data objectForKey:@"callbackId"];
    
    title=@"MFA";
    message=@"";
    cancelButtonTitle=@"取消";
    
    if([data objectForKey:@"title"])
    {
        title=[data objectForKey:@"title"];
    }
    if([data objectForKey:@"message"])
    {
        message=[data objectForKey:@"message"];
    }
    if([data objectForKey:@"cancelButtonTitle"])
    {
        cancelButtonTitle=[data objectForKey:@"cancelButtonTitle"];
    }
    if([data objectForKey:@"otherButtonTitles"])
    {
        otherButtonTitles= [data objectForKey:@"otherButtonTitles"];
    }
    
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles: nil];
    
    if(otherButtonTitles.count!=0)
    {
        for(int i=0;i<otherButtonTitles.count;i++)
        {
            [alertView addButtonWithTitle:otherButtonTitles[i]];
        }
    }
    [alertView show];
}
// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    //NSString *cmdString=[NSString stringWithFormat: @"%@()",self.callBack];
    //[[NSNotificationCenter defaultCenter]postNotificationName:@"__MFA__SENDJSTOPAGE__" object:cmdString];
}

// Called when we cancel a view (eg. the user clicks the Home button). This is not called when the user clicks the cancel button.
// If not defined in the delegate, we simulate a click in the cancel button
- (void)alertViewCancel:(UIAlertView *)alertView
{
    
}
@end
