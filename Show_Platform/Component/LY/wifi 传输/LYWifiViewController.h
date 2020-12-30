//
//  ViewController.h
//  LYWifiTransmission
//
//  Created by liang on 16/2/24.
//  Copyright (c) 2016年 梁银龙. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HTTPServer;
@interface LYWifiViewController : UIViewController
{
    UInt64 currentDataLength;
}
@property (strong, nonatomic) HTTPServer *httpserver;


@end

