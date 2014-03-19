//
//  ggPicOperation.m
//  HttpTestDemo
//
//  Created by gogo on 13-8-23.
//  Copyright (c) 2013年 Senlan Corporation. All rights reserved.
//

#import "ggPicOperation.h"
#define DATA(X)	[X dataUsingEncoding:NSUTF8StringEncoding]

// Posting constants
#define IMAGE_CONTENT @"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\nContent-Type: image/jpeg\r\n\r\n"
#define STRING_CONTENT @"Content-Disposition: form-data; name=\"%@\"\r\n\r\n"
#define MULTIPART @"multipart/form-data; boundary=------------0x0x0x0x0x0x0x0x"
@implementation ggPicOperation
@synthesize theImage;
//创建postdata
- (NSData*)generateFormDataFromPostDictionary:(NSDictionary*)dict
{
    id boundary = @"------------0x0x0x0x0x0x0x0x";
    NSArray* keys = [dict allKeys];
    NSMutableData* result = [NSMutableData data];
	
    for (int i = 0; i < [keys count]; i++)
    {
        id value = [dict valueForKey: [keys objectAtIndex:i]];
        [result appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
		
		if ([value isKindOfClass:[NSData class]])
		{
			// handle image data
			NSString *formstring = [NSString stringWithFormat:IMAGE_CONTENT, [keys objectAtIndex:i],imageName];
			[result appendData: DATA(formstring)];
			[result appendData:value];
		}
		else
		{
			// all non-image fields assumed to be strings
			NSString *formstring = [NSString stringWithFormat:STRING_CONTENT, [keys objectAtIndex:i]];
			[result appendData: DATA(formstring)];
			[result appendData:DATA(value)];
		}
		
		NSString *formstring = @"\r\n";
        [result appendData:DATA(formstring)];
    }
	
	NSString *formstring =[NSString stringWithFormat:@"--%@--\r\n", boundary];
    [result appendData:DATA(formstring)];
    return result;
}
//上传图片
- (NSString *) UpLoading:(NSString *) imgName
{
	if (!self.theImage){
        return @"上传的图片文件为空";
    }
		
    imageName=imgName;//获得图片的名称
    
	NSMutableDictionary* post_dict = [[NSMutableDictionary alloc] init];
    
	[post_dict setObject:@"Posted from iPhone" forKey:@"message"];
	[post_dict setObject:UIImageJPEGRepresentation(self.theImage, 0.75f) forKey:@"file"];
	
	NSData *postData = [self generateFormDataFromPostDictionary:post_dict];
    
	
    NSString *baseurl = @"http://192.168.0.43:8080/UpLoad.aspx";
    NSURL *url = [NSURL URLWithString:baseurl];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    if (!urlRequest){
        return @"服务器地址有误";
    }
	
    [urlRequest setHTTPMethod: @"POST"];
	[urlRequest setValue:MULTIPART forHTTPHeaderField: @"Content-Type"];
    [urlRequest setHTTPBody:postData];
	
	// Submit & retrieve results

	NSLog(@"Contacting TwitPic....");
    
    __block NSString *resault=@"";
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection
     sendAsynchronousRequest:urlRequest
     queue:queue
     completionHandler:^(NSURLResponse *response,
                         NSData *data,
                         NSError *error) {
         
         if ([data length] >0  &&
             error == nil){
             
             resault = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
             
             NSLog(@"上传成功");
             
             // NSLog(@"HTML = %@", html);
         }
         else if ([data length] == 0 &&
                  error == nil){
             resault=@"Nothing was downloaded.";
         
         }
         else if (error != nil){
             resault=[NSString stringWithFormat:@"Error happened = %@", error];
             
         }
         
     }];
    
	return nil;
}


@end
