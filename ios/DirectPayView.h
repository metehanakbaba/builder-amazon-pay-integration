#import <UIKit/UIKit.h>
#import <React/RCTView.h>
#import <React/RCTBridgeModule.h>

@interface DirectPayView : UIView

@property (nonatomic, strong) NSString *environment;
@property (nonatomic, strong) NSDictionary *payButtonProps;
@property (nonatomic, strong) NSDictionary *requestObject;

@property (nonatomic, copy) RCTDirectEventBlock onSuccess;
@property (nonatomic, copy) RCTDirectEventBlock onFailure;

@end
