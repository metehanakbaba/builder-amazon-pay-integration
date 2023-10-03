#import "Utils.h"

@implementation Utils

+ (PayButton *)customizeButtonWithPayButton:(PayButton *)payButton payButtonStyleDictionary:(NSDictionary *)payButtonStyleDictionary {
    payButton.backgroundColor = [UIColor colorWithHexString:payButtonStyleDictionary[@"backgroundColor"] ?: @"#026cff"];
    [payButton setTitle:payButtonStyleDictionary[@"text"] forState:UIControlStateNormal];

    NSString *payButtonTitleColorHex = payButtonStyleDictionary[@"textColor"] ?: @"#ffffff";
    [payButton setTitleColor:[UIColor colorWithHexString:payButtonTitleColorHex] forState:UIControlStateNormal];

    CGFloat payButtonTitleSize = [payButtonStyleDictionary[@"textSize"] floatValue] ?: 20;
    NSString *payButtonTitleFont = payButtonStyleDictionary[@"textFontFamily"] ?: @"";
    if (payButtonTitleFont.length > 0) {
        payButton.titleLabel.font = [UIFont fontWithName:payButtonTitleFont size:payButtonTitleSize];
    } else {
        payButton.titleLabel.font = [UIFont systemFontOfSize:payButtonTitleSize];
    }

    CGFloat payButtonBorderRadius = [payButtonStyleDictionary[@"borderRadius"] floatValue] ?: 20;
    CGFloat payButtonBorderWidth = [payButtonStyleDictionary[@"borderWidth"] floatValue] ?: 0;
    NSString *payButtonBorderColorHex = payButtonStyleDictionary[@"borderColor"] ?: @"";

    payButton.layer.cornerRadius = payButtonBorderRadius;
    payButton.layer.borderWidth = payButtonBorderWidth;
    payButton.layer.borderColor = [UIColor colorWithHexString:payButtonBorderColorHex].CGColor;

    return payButton;
}

@end
