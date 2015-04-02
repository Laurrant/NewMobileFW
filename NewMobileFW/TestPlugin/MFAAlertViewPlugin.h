//
//  MFAAlertViewPlugin.h
//  NewMobileFW
//
//  Created by ElandApple02 on 15-3-30.
//  Copyright (c) 2015年 eland. All rights reserved.
//

#import "MFABasePlugin.h"
#import <UIKit/UIKit.h>

@interface MFAAlertViewPlugin : MFABasePlugin<UIAlertViewDelegate>
{
    /**
     *  title
     */
    NSString* title;
    
    /**
     *  message
     */
    NSString* message;
    
    /**
     *  cancelButtonTitle
     */
    NSString* cancelButtonTitle;
    
    /**
     *  otherButtonTitles
     */
    NSArray* otherButtonTitles;
}

@end
