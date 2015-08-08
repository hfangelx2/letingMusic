#import "AFNGet.h"
#import "DXAlertView.h"
@implementation AFNGet

+(void)GetData:(NSString *)string block:(myblock)block
{
 
    AFNetworkReachabilityManager *netWorkManager = [AFNetworkReachabilityManager sharedManager];
    NSString *url_string =string;
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html",nil];
    [manager GET:url_string parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [netWorkManager stopMonitoring];
        //block回调
        block(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"提示" contentText:@"无网络,请链接网络后重试" leftButtonTitle:nil rightButtonTitle:@"确认"];
//        [alert show];
        NSLog(@"失败==== %@",error);
        
    }];

}
+(void)GetData:(NSString *)string block:(myblock)block blockError:(errorBlock)blockError
{
    
    AFNetworkReachabilityManager *netWorkManager = [AFNetworkReachabilityManager sharedManager];
    NSString *url_string =string;
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html",nil];
    [manager GET:url_string parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [netWorkManager stopMonitoring];
        //block回调
        block(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"提示" contentText:@"无网络,请链接网络后重试" leftButtonTitle:nil rightButtonTitle:@"确认"];
        [alert show];
        blockError(error);
        
    }];
    
  
}



@end
