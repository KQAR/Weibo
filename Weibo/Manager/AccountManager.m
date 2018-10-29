//
//  AccountTool.m
//  Weibo
//
//  Created by he on 2018/10/18.
//  Copyright © 2018年 huashan. All rights reserved.
//

#define AccountFilePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]

#import "AccountManager.h"
#import "Account.h"

@interface AccountManager()
@property (nonatomic, strong) NSData *data;
@end

@implementation AccountManager

+ (void)save:(Account *)account
{
    //  归档
    [NSKeyedArchiver archiveRootObject:account toFile:AccountFilePath];
//    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:account requiringSecureCoding:YES error:nil];
//    [data writeToFile:AccountFilePath atomically:YES];
//    self.data = data;
}

+ (Account *)account
{
    //  解档
    //  读取账号
    Account *account = [NSKeyedUnarchiver unarchiveObjectWithFile:AccountFilePath];
//    return [NSKeyedUnarchiver unarchivedObjectOfClass:[NSObject class] fromData:self.data error:nil];
    
    // 判断账号是否过期  
//    NSDate *now = [NSDate date];
//    if ([now compare:account.expires_time] != NSOrderedAscending) {
//        account = nil;
//    }
    return account;
}

+ (void)accessTokenWithParam:(AccessTokenParam *)param success:(void (^)(Account *))success failure:(void (^)(NSError *))failure
{
    [self postWithUrl:URL_access_token param:param resultClass:[Account class] success:success failure:failure];
}

@end
