//
//  MFATestImagePlugin.m
//  NewMobileFW
//
//  Created by ElandApple02 on 15-3-25.
//  Copyright (c) 2015年 eland. All rights reserved.
//

#import "MFATestImagePlugin.h"
#import "MainViewController.h"
#import <objc/runtime.h>
#import "AFNetworking.h"
#import "AFHTTPClient.h"
#import "AFHTTPRequestOperation.h"

@implementation MFATestImagePlugin

/**
 *  type=2,从SavedPhotosAlbum中取得图片
 *
 *  @param data 传入的参数值
 */
-(void)callSavedPhotosAlbum:(NSMutableDictionary *)data
{
    [self callImage:data withType:2];
}

/**
 *  type=0,从photoLib中取得图片
 *
 *  @param data 传入的参数值
 */
-(void)callPhotoLibrary:(NSMutableDictionary *)data
{
    [self callImage:data withType:0];
}

/**
 *  type=1,从Camera中取得图片
 *
 *  @param data 传入的参数值
 */
-(void)callCamera:(NSMutableDictionary *)data
{
    [self callImage:data withType:1];
}

/**
 *  与图片系统交互
 *
 *  @param data 传入的参数值
 *  @param type UIImagePickerControllerSourceType值
 */
-(void)callImage:(NSMutableDictionary *)data withType:(int)type
{
    //self.mv=[data objectForKey:@"__MFA__MAINVIEW__"];

    
    self.picker=[[UIImagePickerController alloc]init];
    self.picker.sourceType=type;
    //self.picker.delegate=self;
    [self.picker setDelegate:self];
    self.callBack=[data objectForKey:@"callbackId"];
    
    [self.mainViewDelegate presentViewController:self.picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *viewImage=[info objectForKey: UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSData *imgData=UIImageJPEGRepresentation(viewImage, 0.3);
    imgData=[imgData base64EncodedDataWithOptions:0];
    NSString *encodedData=[[NSString alloc]initWithData:imgData encoding:NSUTF8StringEncoding];
    NSString *cmdString=[NSString stringWithFormat: @"%@('%@',%f,%f)",self.callBack,encodedData,viewImage.size.width,viewImage.size.height];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"__MFA__SENDJSTOPAGE__" object:cmdString];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"cancel");
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)uploadImageWithImage:(NSString *)imagePath

{
    
    //上传其他所需参数
    
    //NSString *userId=XXXXXXXXXXX;
    
    //NSString *token=XXXXXXXXXXX;
    //NSDictionary *dic=[[NSDictionary alloc]init];
    //上传请求POST
    
    AFHTTPClient *client=[AFHTTPClient clientWithBaseURL:[NSURL URLWithString:@""]];
    
    
    NSString *urlString=[NSString stringWithFormat:@"上传服务器地址"];
                         
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:@"userid",@"XXXXXX",@"token",@"XXXXXX", nil];
                         
    NSURLRequest *request = [client multipartFormRequestWithMethod:@"POST" path:urlString parameters:dic constructingBodyWithBlock:^(id formData) {
        
        //得到需要上传的数据
        
        NSData *data=[NSData dataWithContentsOfFile:imagePath];
        
        //上传时使用当前的系统事件作为文件名
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
        formatter.dateFormat = @"yyyyMMddHHmmss";
        
        NSString *str = [formatter stringFromDate:[NSDate date]];
        
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
        
        /*
         
         此方法参数
         
         1. 要上传的[二进制数据]
         
         2. 对应网站上[upload.php中]处理文件的[字段"file"]
         
         3. 要保存在服务器上的[文件名]
         
         4. 上传文件的[mimeType]
         
         */
        
        
        //服务器上传文件的字段和类型
        
        [formData appendPartWithFileData:data name:@"XXXXX" fileName:fileName mimeType:@"image/jpg/file"];
        
    }];
                         
    // 3. operation包装的urlconnetion
                         
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
                         
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"上传完成");
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"上传失败->%@", error);
        
    }];
    //执行
    [client.operationQueue addOperation:op];
                         
}

@end

