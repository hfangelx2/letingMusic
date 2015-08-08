#define SingletonH(name) + (instancetype)share##name;

#define SingletonM(name) \
static id _instance;\
\
+ (instancetype)allocWithZone:(struct _NSZone *)zone\
{\
    static dispatch_once_t onceToken;\
    dispatch_once(&onceToken, ^{\
        \
        _instance = [super allocWithZone:zone];\
        \
    });\
    return _instance;\
}\
\
\
+ (instancetype)share##name\
{\
    static dispatch_once_t onceToken;\
    dispatch_once(&onceToken, ^{\
        \
        _instance = [[self alloc] init];\
        \
    });\
    return _instance;\
}\
\
\
- (id)copyWithZone:(NSZone *)zone\
{\
    return _instance;\
}\
\
- (oneway void)release\
{\
    \
}\
\
- (instancetype)retain\
{\
    return self;\
}\
\
- (NSUInteger)retainCount\
{\
    return 1;\
}\
\
- (instancetype)autorelease\
{\
    return self;\
}

