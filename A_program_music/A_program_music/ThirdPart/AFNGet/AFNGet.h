#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#warning block使用第一步:声明block
typedef void(^myblock) (id backData);
typedef void(^errorBlock) (NSError *error);

@interface AFNGet : NSObject

#warning block使用第二部:声明方法,将block作为方法中的一个参数

+(void)GetData:(NSString *)string block:(myblock)block;



+(void)GetData:(NSString *)string block:(myblock)block blockError:(errorBlock)blockError;




@end
