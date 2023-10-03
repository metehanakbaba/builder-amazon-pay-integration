#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PayFortSDK/PayFortSDK-Swift.h" // PayFortSDK'nin Swift modülünü import ettiğinizden emin olun

@interface Utils : NSObject

+ (PayButton *)customizeButtonWithPayButton:(PayButton *)payButton payButtonStyleDictionary:(NSDictionary *)payButtonStyleDictionary;

@end
