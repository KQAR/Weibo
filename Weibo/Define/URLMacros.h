//
//  URLMacros.h
//  Weibo
//
//  Created by he on 2018/10/18.
//  Copyright © 2018年 huashan. All rights reserved.
//

#ifndef URLMacros_h
#define URLMacros_h

/** 应用信息 **/
#define AppKey @"717603166"
#define AppSecret @"afcd29607251403aa783ac2ddb7f7010"
#define RedirectURI @"https://www.baidu.com/"

/** URL **/

//  请求登录页面
#define URL_Login @"https://api.weibo.com/oauth2/authorize?client_id=717603166&redirect_uri=https://www.baidu.com/"

//  获取access_token
#define URL_access_token @"https://api.weibo.com/oauth2/access_token"

//  获取最新微博数据
#define URL_NewStatus @"https://api.weibo.com/2/statuses/home_timeline.json"

//  发表有图片微博
#define URL_Upload @"https://upload.api.weibo.com/2/statuses/upload.json"

//  发表无图片的微博
#define URL_Update @"https://api.weibo.com/2/statuses/update.json"

//  获取用户信息
#define URL_User @"https://api.weibo.com/2/users/show.json"

//  获取用户未读数
#define URL_UnreadCount @"https://rm.api.weibo.com/2/remind/unread_count.json"

#endif /* URLMacros_h */
