#import "StandardCheckoutView.h"
#import "PayFortSDK/PayFortSDK-Swift.h" // PayFortSDK'nin Swift modülünü import ettiğinizden emin olun

@interface StandardCheckoutView ()

@property (nonatomic, strong) UIViewController *vc;
@property (nonatomic, strong) PayFortController *payFort;
@property (nonatomic, strong) NSString *environmentString;
@property (nonatomic, strong) NSMutableDictionary *requestDictionary;
@property (nonatomic, assign) BOOL showLoadingBool;
@property (nonatomic, assign) BOOL showResponsePageBool;

@end

@implementation StandardCheckoutView

- (instancetype)init {
    self = [super init];
    if (self) {
        _vc = RCTPresentedViewController();
        _payFort = [[PayFortController alloc] initWithEnviroment:PFEnvironmentSandBox];
    }
    return self;
}

- (void)setEnvironment:(NSString *)environment {
    if (![_environment isEqualToString:environment]) {
        _environment = environment;
        _environmentString = environment;
        [self callStandardRequest];
    }
}

- (void)setRequestObject:(NSDictionary *)requestObject {
    if (![_requestObject isEqualToDictionary:requestObject]) {
        _requestObject = requestObject;
        _requestDictionary = [NSMutableDictionary dictionaryWithDictionary:requestObject];
        [self callStandardRequest];
    }
}

- (void)setShowLoading:(NSNumber *)showLoading {
    if (![_showLoading isEqualToNumber:showLoading]) {
        _showLoading = showLoading;
        _showLoadingBool = [showLoading isEqualToNumber:@(1)];
        [self callStandardRequest];
    }
}

- (void)setShowResponsePage:(NSNumber *)showResponsePage {
    if (![_showResponsePage isEqualToNumber:showResponsePage]) {
        _showResponsePage = showResponsePage;
        _showResponsePageBool = [showResponsePage isEqualToNumber:@(1)];
        [self callStandardRequest];
    }
}

- (void)callStandardRequest {
    if (_environmentString.length == 0 || _requestDictionary.count == 0 || _showLoading == nil) {
        return;
    }

    if (![_environmentString isEqualToString:@"TEST"] && ![_environmentString isEqualToString:@"PRODUCTION"]) {
        return;
    }

    NSDictionary *request = _requestDictionary;

    _payFort = [[PayFortController alloc] initWithEnviroment:(_environmentString isEqualToString:@"PRODUCTION"] ? PFEnvironmentProduction : PFEnvironmentSandBox];

    _payFort.hideLoading = !_showLoadingBool;
    _payFort.isShowResponsePage = _showResponsePageBool;

    [_payFort callPayFortWithRequest:request currentViewController:_vc
        success:^(NSDictionary * _Nonnull responseDict) {
            NSLog(@"success");
            if (_onSuccess) {
                _onSuccess(@{@"response": responseDict});
            }
        }
        canceled:^(NSDictionary * _Nonnull responseDict) {
            NSLog(@"canceled");
            if (_onFailure) {
                _onFailure(@{@"response": responseDict});
            }
        }
        faild:^(NSDictionary * _Nonnull responseDict, NSString * _Nonnull message) {
            NSLog(@"failed");
            if (_onFailure) {
                _onFailure(@{@"response": responseDict});
            }
        }];
}

@end
