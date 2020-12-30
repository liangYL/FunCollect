//
//  STCameraSheet.m
//  photo
//
//  Created by steve on 13-7-1.
//  Copyright (c) 2013年 刘国君. All rights reserved.
//

#import "STCameraSheet.h"

@implementation STCameraSheet

static STCameraSheet *stCameraSheet;
+(STCameraSheet *)CameraSheet
{
    @synchronized(stCameraSheet)
    {
        if (stCameraSheet == nil)
        {
            stCameraSheet = [[STCameraSheet alloc] init];
        }
    }
    return stCameraSheet;
}

-(void)CameraWithController:(UIViewController *)toController editing:(STCameraEditingType)Type onDismiss:(DismissBlock)dismissed onError:(ErrorBlock)errorBlock
{
    _toController=toController;
    _type=Type;
    _dismissBlock=[dismissed copy];
    _errorBlock=[errorBlock copy];
    [self sheet];
}

-(void)OpenCameraController:(UIViewController *)toController editing:(STCameraEditingType)Type onDismiss:(DismissBlock)dismissed onError:(ErrorBlock)errorBlock
{
    _toController=toController;
    _type=Type;
    _dismissBlock=[dismissed copy];
    _errorBlock=[errorBlock copy];
    [self openPhotoToViewController:toController sourceType:UIImagePickerControllerSourceTypeCamera];
}

-(void)OpenPhotoLibraryController:(UIViewController *)toController editing:(STCameraEditingType)Type onDismiss:(DismissBlock)dismissed onError:(ErrorBlock)errorBlock
{
    _toController=toController;
    _type=Type;
    _dismissBlock=[dismissed copy];
    _errorBlock=[errorBlock copy];
    [self openPhotoToViewController:toController sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

-(void)sheet
{
    UIActionSheet *actionsheet=[[UIActionSheet alloc]initWithTitle:@"选择照片来源" delegate:self cancelButtonTitle:@"退出" destructiveButtonTitle:@"照相机" otherButtonTitles:@"图片库", nil];
    [actionsheet showInView:_toController.view];
    [actionsheet release];
    //[self openPhotoToViewController:_toController sourceType:UIImagePickerControllerSourceTypeCamera];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) 
        [self openPhotoToViewController:_toController sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    if (buttonIndex==0) 
        [self openPhotoToViewController:_toController sourceType:UIImagePickerControllerSourceTypeCamera];
    
}

- (UIImagePickerController *)openPhotoToViewController:(UIViewController *)viewController sourceType:(UIImagePickerControllerSourceType)sourceType
{
    NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:sourceType];
    
    if ([UIImagePickerController isSourceTypeAvailable:sourceType] && [mediaTypes count] > 0)
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.mediaTypes = mediaTypes;
        
        picker.navigationBarHidden = YES;
        //判断是否可编辑
        if (_type==Editing)
        {
            picker.allowsEditing = YES;
        }
        else
        {
            picker.allowsEditing = NO;
        }
        
        picker.delegate = self;
        picker.sourceType = sourceType;
        [viewController presentModalViewController:picker animated:YES];
        [picker release];
        
        return picker;
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"警告" message:@"该设备不支持!" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
    return nil;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    //判断是静态图像还是视频
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage])
    {
        UIImage* editedImage =nil;
        if ([info objectForKey:UIImagePickerControllerEditedImage]!=nil)
        {
            //获取用户编辑之后的图像
            editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
        }
        else
        {
            //获取原始的图像
            editedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
        
        //判断是调用照相机还是图片库，如果是照相机的话，将图像保存到媒体库中
        if (picker.sourceType==UIImagePickerControllerSourceTypeCamera)
        {
            //将该图像保存到媒体库中
            UIImageWriteToSavedPhotosAlbum(editedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
        }
//        UIImage *img = [editedImage fixOrientation];//图片矫正
        UIImage *img = editedImage;
        _dismissBlock(img);
    }
    [picker dismissModalViewControllerAnimated:YES];
    [_dismissBlock release];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissModalViewControllerAnimated:YES];
    [_dismissBlock release];
}

- (void)image:(UIImage*)image didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo
{
    NSString *str=nil;
    if (!error)
        str=@"picture saved with no error.";
    else
        str=@"error occured while saving the picture%@";
    _errorBlock(str);
    [_errorBlock release];
}
@end
