//
//  Singleton.h
//  Weibo
//
//  Created by he on 2018/10/22.
//  Copyright © 2018年 huashan. All rights reserved.
//

#ifndef Singleton_h
#define Singleton_h

// ## : 连接字符串和参数
#define singleton_h(name) + (instancetype)shared##name;

#if __has_feature(objc_arc) //ARC

#define singleton_m(name)\
static id _instance;\
\
+ (id)allocWithZone:(struct _NSZone *)zone {\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [super allocWithZone:zone];\
});\
return _instance;\
}\
\
+ (instancetype)shared##name {\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [[self alloc] init];\
});\
return _instance;\
}\
\
+ (id)copyWithZone:(struct _NSZone *)zone\
{\
return _instance;\
}

#else  //非ARC

#define singleton_m(name)\
static id _instance;\
\
+ (id)allocWithZone:(struct _NSZone *)zone {\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [super allocWithZone:zone];\
});\
return _instance;\
}\
\
+ (instancetype)shared##name {\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [[self alloc] init];\
});\
return _instance;\
}\
\
+ (id)copyWithZone:(struct _NSZone *)zone\
{\
return _instance;\
}\
- (oneway void)release\
{\
\
}\
\
- (id)autorelease\
{\
return self;\
}\
\
- (id)retain\
{\
return self;\
}\
\
- (NSUInteger)retainCount\
{\
return 1;\too
}

#endif


#endif /* Singleton_h */
