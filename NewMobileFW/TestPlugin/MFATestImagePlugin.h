//
//  MFATestImagePlugin.h
//  NewMobileFW
//
//  Created by ElandApple02 on 15-3-25.
//  Copyright (c) 2015年 eland. All rights reserved.
//

#import "MFABasePlugin.h"
#import <UIKit/UIKit.h>

@class MainViewController;
@class AFHTTPClient;
@class AFHTTPRequestOperation;


@interface MFATestImagePlugin : MFABasePlugin<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(strong,nonatomic)UIImagePickerController *picker;
@property(strong,nonatomic)AFHTTPClient *uploadFileClient;
@property(strong,nonatomic)AFHTTPRequestOperation *fileUploadOp;

-(void)callCamera:(NSMutableDictionary *)data;

- (void)uploadImageWithImage:(NSString *)imagePath;

@end
