#import "CustomCheckoutView.h"
#import "PayFortSDK-Swift.h" // Swift sınıflarına erişim için

@implementation CustomCheckoutView {
    RCTViewController *vc;
    NSString *environmentString;
    NSMutableDictionary<NSString *, NSString *> *requestDictionary;
    NSMutableDictionary<NSString *, id> *payButtonStyleDictionary;

    CardNumberView *cardNumberView;
    ExpiryDateView *expiryDateView;
    CVCNumberView *cvcNumberView;
    HolderNameView *holderNameView;
    UISwitch *saveCardSwitch;
    PayButton *payButton;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        vc = [RCTPresentedViewController new];
        requestDictionary = [NSMutableDictionary dictionary];
        payButtonStyleDictionary = [NSMutableDictionary dictionary];

        [self setupView];
    }
    return self;
}

- (void)setEnvironment:(NSString *)environment {
    NSLog(@"%@", environment);
    environmentString = environment;
    [self setupView];
}

- (void)setPayButtonProps:(NSDictionary *)payButtonProps {
    payButtonStyleDictionary = [payButtonProps mutableCopy];
    [self setupView];
}

- (void)setRequestObject:(NSDictionary *)requestObject {
    requestDictionary = [requestObject mutableCopy];
    [self setupView];
}

- (void)setupView {
    if (environmentString.length == 0 || requestDictionary.count == 0) {
        return;
    }

    if ([environmentString isEqualToString:@"TEST"] || [environmentString isEqualToString:@"PRODUCTION"]) {
        cardNumberView = [CardNumberView new];
        expiryDateView = [ExpiryDateView new];
        cvcNumberView = [CVCNumberView new];
        holderNameView = [HolderNameView new];
        saveCardSwitch = [UISwitch new];
        payButton = [PayButton new];

        saveCardSwitch.on = YES;

        payButton = [Utils customizeButtonWithPayButton:payButton payButtonStyleDictionary:payButtonStyleDictionary];

        PayComponents *builder = [[PayComponents alloc] initWithCardNumberView:cardNumberView
                                                               expiryDateView:expiryDateView
                                                                 cvcNumberView:cvcNumberView
                                                                 holderNameView:holderNameView
                                                                   rememberMe:saveCardSwitch.isOn
                                                                     language:@"en"];

        [payButton setupWith:requestDictionary
                  enviroment:([environmentString isEqualToString:@"PRODUCTION"] ? PayFortEnvironmentProduction : PayFortEnvironmentSandbox)
             payButtonBuilder:builder
            viewController:vc
                   onStart:^{
            // Process started
            [self->payButton setTitle:@"..." forState:UIControlStateNormal];
        } onSuccess:^(NSDictionary *requestDic, NSDictionary *responeDic) {
            // Process success
            [self->payButton setTitle:@" Done " forState:UIControlStateNormal];
            if (self.onSuccess) {
                self.onSuccess(@{@"response": responeDic});
            }
        } onFailure:^(NSDictionary *requestDic, NSDictionary *responeDic, NSString *message) {
            // Process failed
            [self->payButton setTitle:@" Failed " forState:UIControlStateNormal];
            if (self.onFailure) {
                self.onFailure(@{@"response": responeDic});
            }
        }];

        cardNumberView.translatesAutoresizingMaskIntoConstraints = NO;
        expiryDateView.translatesAutoresizingMaskIntoConstraints = NO;
        cvcNumberView.translatesAutoresizingMaskIntoConstraints = NO;
        holderNameView.translatesAutoresizingMaskIntoConstraints = NO;
        // saveCardSwitch.translatesAutoresizingMaskIntoConstraints = NO;
        payButton.translatesAutoresizingMaskIntoConstraints = NO;

        [self addSubview:cardNumberView];
        [self addSubview:expiryDateView];
        [self addSubview:cvcNumberView];
        [self addSubview:holderNameView];
        // [self addSubview:saveCardSwitch];
        [self addSubview:payButton];

        CGFloat payButtonPaddingVertical = [payButtonStyleDictionary[@"buttonHeight"] floatValue] ?: 30;
        CGFloat payButtonPaddingHorizontal = [payButtonStyleDictionary[@"buttonWidth"] floatValue] ?: 40;

        CGFloat payButtonMarginLeft = [payButtonStyleDictionary[@"marginLeft"] floatValue] ?: 15;
        CGFloat payButtonMarginTop = [payButtonStyleDictionary[@"marginTop"] floatValue] ?: 15;

        [NSLayoutConstraint activateConstraints:@[
            [cardNumberView.topAnchor constraintEqualToAnchor:self.topAnchor constant:20],
            [cardNumberView.leftAnchor constraintEqualToAnchor:self.leftAnchor],
            [cardNumberView.widthAnchor constraintEqualToAnchor:self.widthAnchor],

            [expiryDateView.topAnchor constraintEqualToAnchor:cardNumberView.bottomAnchor constant:20],
            [expiryDateView.leftAnchor constraintEqualToAnchor:self.leftAnchor],
            [expiryDateView.widthAnchor constraintEqualToAnchor:self.widthAnchor],

            [cvcNumberView.topAnchor constraintEqualToAnchor:expiryDateView.bottomAnchor constant:20],
            [cvcNumberView.leftAnchor constraintEqualToAnchor:self.leftAnchor],
            [cvcNumberView.widthAnchor constraintEqualToAnchor:self.widthAnchor],

            [holderNameView.topAnchor constraintEqualToAnchor:cvcNumberView.bottomAnchor constant:20],
            [holderNameView.leftAnchor constraintEqualToAnchor:self.leftAnchor],
            [holderNameView.widthAnchor constraintEqualToAnchor:self.widthAnchor],

            [payButton.topAnchor constraintEqualToAnchor:holderNameView.bottomAnchor constant:payButtonMarginTop],
            [payButton.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:payButtonMarginLeft],

            [payButton.widthAnchor constraintEqualToConstant:payButtonPaddingHorizontal * 2],
            [payButton.heightAnchor constraintEqualToConstant:payButtonPaddingVertical * 2]
        ]];
    }
}

@end
