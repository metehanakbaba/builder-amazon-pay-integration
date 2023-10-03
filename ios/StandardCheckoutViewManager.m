#import "StandardCheckoutViewManager.h"
#import "StandardCheckoutView.h" // StandardCheckoutView sınıfının import edildiğinden emin olun

@implementation StandardCheckoutViewManager

RCT_EXPORT_MODULE(StandardCheckoutViewManager)

+ (BOOL)requiresMainQueueSetup {
    return YES;
}

- (UIView *)view {
    return [[StandardCheckoutView alloc] init];
}

@end
