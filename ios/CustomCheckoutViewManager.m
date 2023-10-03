#import "CustomCheckout.h"
#import "CustomCheckoutView.h" // CustomCheckoutView sınıfının import edildiğinden emin olun

@implementation CustomCheckout

RCT_EXPORT_MODULE(CustomCheckout)

+ (BOOL)requiresMainQueueSetup {
    return YES;
}

- (UIView *)view {
    return [[CustomCheckoutView alloc] init];
}

@end
