//
//  STCameraSheet.h
//  photo
//
//  Created by steve on 13-7-1.
//  Copyright (c) 2013年 刘国君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MobileCoreServices/MobileCoreServices.h"
#import "AssetsLibrary/AssetsLibrary.h"

typedef void (^DismissBlock)(UIImage *cameraImage);
typedef void (^ErrorBlock)(NSString *str);
typedef enum
{
    //是否可编辑
    Editing,
    NOEditing,
}STCameraEditingType;

@interface STCameraSheet : NSObject<UINavigationControllerDelegate, UIImagePickerControllerDelegate,UIActionSheetDelegate>
{
    UIViewController *_toController;
    STCameraEditingType _type;
    
    DismissBlock _dismissBlock;
    ErrorBlock _errorBlock;
}
+(STCameraSheet *)CameraSheet;
-(void)CameraWithController:(UIViewController *)toController editing:(STCameraEditingType)Type onDismiss:(DismissBlock)dismissed onError:(ErrorBlock)errorBlock;
-(void)OpenCameraController:(UIViewController *)toController editing:(STCameraEditingType)Type onDismiss:(DismissBlock)dismissed onError:(ErrorBlock)errorBloc;
-(void)OpenPhotoLibraryController:(UIViewController *)toController editing:(STCameraEditingType)Type onDismiss:(DismissBlock)dismissed onError:(ErrorBlock)errorBlock;
@end
