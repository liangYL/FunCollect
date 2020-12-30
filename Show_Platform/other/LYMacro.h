

//----color

#define RandomColor [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1]

#define RandomColorLight [UIColor colorWithRed:arc4random()%256/255.0 green:(arc4random()%170+80)/255.0 blue:arc4random()%256/255.0 alpha:1]



#define SHOWALERT(message_)    UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:message_ message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];\
[alertView show];


//---------WiFi传输相关
//域
#define  Host 27354

//通知
#define UPLOADSTART @"uploadstart"

#define UPLOADING @"uploading"

#define UPLOADEND @"uploadend"

#define UPLOADISCONNECTED @"uploadisconnected"

