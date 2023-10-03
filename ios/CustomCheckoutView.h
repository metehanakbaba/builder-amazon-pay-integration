#import <UIKit/UIKit.h>
#import "PayFortSDK-Swift.h" // Swift sınıflarına erişim için

@interface CustomCheckoutView : UIView

@property (nonatomic, strong) NSString *environment;
@property (nonatomic, strong) NSDictionary *payButtonProps;
@property (nonatomic, strong) NSDictionary *requestObject;

@property (nonatomic, copy) RCTDirectEventBlock onSuccess;
@property (nonatomic, copy) RCTDirectEventBlock onFailure;

@end
