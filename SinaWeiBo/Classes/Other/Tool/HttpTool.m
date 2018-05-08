//
//  HttpTool.m
//  SinaWeiBo
//
//  Created by TecsonChan on 4/4/16.
//  Copyright © 2016 itcast. All rights reserved.
//

#import "HttpTool.h"
#import "AFHTTPClient.h"
#import "AFNetworking.h"
#import "Weibocfg.h"
#import "AccountTool.h"
#import "UIImageView+WebCache.h"
#import "Common.h"

@implementation HttpTool

+ (void)requestWithPath:(NSString *)path params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure method:(NSString *)method
{
    MyLog(@"请求的url是:%@%@",kBaseURL,path);
    MyLog(@"请求的method是:%@",method);
    MyLog(@"请求的参数是:%@",params);
    //创建post请求
    AFHTTPClient *client = [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:kBaseURL]];
    
    NSMutableDictionary *allParams = [NSMutableDictionary dictionary];
    //拼接传进来的参数
    if (params) {
        [allParams setDictionary:params];
    }
    
    //拼接token参数
    NSString *token = [AccountTool sharedAccountTool].account.accessToken;
    MyLog(@"请求的access_token是:%@",token);
    if (token) {
        [allParams setObject:token forKey:@"access_token"];
    }
    
    NSURLRequest *post = [client requestWithMethod:method path:path parameters:allParams];
    MyLog(@"请求的URL是:%@",post.URL);
    
    //2.创建AFJSONRequestOperation对象
    NSOperation *op = [AFJSONRequestOperation JSONRequestOperationWithRequest:post success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        //MyLog(@"Request Success!--%@",JSON);
        if (success == nil) return;
        success(JSON);
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        MyLog(@"Request Failed!--%@--%@",[error localizedDescription],JSON);
        if (failure == nil) return;
        failure(error);
    }];
    
    //3.发送post请求
    [op start];
    
}

+(void)postWithPath:(NSString *)path params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure
{
    [self requestWithPath:path params:params success:success failure:failure method:@"POST"];

}

+(void)getWithPath:(NSString *)path params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure
{
    [self requestWithPath:path params:params success:success failure:failure method:@"GET"];

}

+ (void)downloadImage:(NSString *)url place:(UIImage *)place imageView:(UIImageView *)imageView
{
    [imageView setImageWithURL:[NSURL URLWithString:url] placeholderImage:place options:SDWebImageLowPriority | SDWebImageRetryFailed];
}

@end
