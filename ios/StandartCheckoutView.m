#import <UIKit/UIKit.h>
#import <React/RCTView.h>

@interface StandardCheckoutView : UIView

@property (nonatomic, strong) NSString *environment;
@property (nonatomic, strong) NSDictionary *requestObject;
@property (nonatomic, strong) NSNumber *showLoading;
@property (nonatomic, strong) NSNumber *showResponsePage;
@property (nonatomic, copy) RCTDirectEventBlock onSuccess;
@property (nonatomic, copy) RCTDirectEventBlock onFailure;
@property (nonatomic, strong) NSNumber *requestCode;

@end
