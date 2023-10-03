#import "DirectPayView.h"
#import "PayFortSDK/PayFortSDK-Swift.h" // PayFortSDK'nin Swift modülünü import ettiğinizden emin olun

@interface DirectPayView ()

@property (nonatomic, strong) PayButton *payButton;
@property (nonatomic, strong) NSString *environmentString;
@property (nonatomic, strong) NSString *tokenNameString;
@property (nonatomic, strong) NSMutableDictionary *requestDictionary;
@property (nonatomic, strong) NSMutableDictionary *payButtonStyleDictionary;
@property (nonatomic, strong) UIViewController *vc;

@end

@implementation DirectPayView

- (instancetype)init {
    self = [super init];
    if (self) {
        _vc = RCTPresentedViewController();
    }
    return self;
}

- (void)setEnvironment:(NSString *)environment {
    if (![_environment isEqualToString:environment]) {
        _environment = environment;
        NSLog(@"%@", environment);
        _environmentString = environment;
        [self setupView];
    }
}

- (void)setPayButtonProps:(NSDictionary *)payButtonProps {
    if (![_payButtonProps isEqualToDictionary:payButtonProps]) {
        _payButtonProps = payButtonProps;
        _payButtonStyleDictionary = [NSMutableDictionary dictionaryWithDictionary:payButtonProps];
        [self setupView];
    }
}

- (void)setRequestObject:(NSDictionary *)requestObject {
    if (![_requestObject isEqualToDictionary:requestObject]) {
        _requestObject = requestObject;
        _requestDictionary = [NSMutableDictionary dictionaryWithDictionary:requestObject];
        [self setupView];
    }
}

- (void)setupView {
    if (_environmentString.length == 0 || _requestDictionary.count == 0) {
        return;
    }

    if (![_environmentString isEqualToString:@"TEST"] && ![_environmentString isEqualToString:@"PRODUCTION"]) {
        return;
    }

    _payButton = [[PayButton alloc] init];
    _payButton = [Utils customizeButtonWithPayButton:_payButton payButtonStyleDictionary:_payButtonStyleDictionary];

    [_payButton setupWith:_requestDictionary environment:(_environmentString isEqualToString:@"PRODUCTION"] ? PFEnvironmentProduction : PFEnvironmentSandBox viewController:_vc];

    [_payButton addTarget:self action:@selector(payButtonTapped:) forControlEvents:UIControlEventTouchUpInside];

    _payButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_payButton];

    CGFloat payButtonPaddingVertical = [_payButtonStyleDictionary[@"buttonHeight"] floatValue] ?: 30;
    CGFloat payButtonPaddingHorizontal = [_payButtonStyleDictionary[@"buttonWidth"] floatValue] ?: 40;
    CGFloat payButtonMarginLeft = [_payButtonStyleDictionary[@"marginLeft"] floatValue] ?: 15;
    CGFloat payButtonMarginTop = [_payButtonStyleDictionary[@"marginTop"] floatValue] ?: 15;

    NSLayoutConstraint *topConstraint = [_payButton.topAnchor constraintEqualToAnchor:self.topAnchor constant:payButtonMarginTop];
    NSLayoutConstraint *leftConstraint = [_payButton.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:payButtonMarginLeft];
    NSLayoutConstraint *widthConstraint = [_payButton.widthAnchor constraintEqualToConstant:payButtonPaddingHorizontal * 2];
    NSLayoutConstraint *heightConstraint = [_payButton.heightAnchor constraintEqualToConstant:payButtonPaddingVertical * 2];

    [NSLayoutConstraint activateConstraints:@[topConstraint, leftConstraint, widthConstraint, heightConstraint]];
}

- (void)payButtonTapped:(id)sender {
    [_payButton setTitle:@"..." forState:UIControlStateNormal];

    [_payButton startCheckoutWithSuccess:^(NSDictionary * _Nonnull responseDict) {
        NSLog(@"success");
        [_payButton setTitle:@" Done " forState:UIControlStateNormal];
        if (_onSuccess) {
            _onSuccess(@{@"response": responseDict});
        }
    } failure:^(NSDictionary * _Nonnull responseDict, NSString * _Nonnull message) {
        NSLog(@"failed");
        [_payButton setTitle:@" Failed " forState:UIControlStateNormal];
        if (_onFailure) {
            _onFailure(@{@"response": responseDict});
        }
    }];
}

@end
