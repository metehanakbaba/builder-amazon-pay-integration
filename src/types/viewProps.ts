import type { RequestObject } from './requestObject';
import type { ViewStyle } from 'react-native';

/**
 * Represents the properties for the PayButton component.
 */
export interface payButtonProps {
  /**
   * The left margin of the button.
   */
  marginLeft: number;

  /**
   * The top margin of the button.
   */
  marginTop: number;

  /**
   * The text displayed on the button.
   */
  text: string;

  /**
   * Optional: The background color of the button.
   */
  backgroundColor?: string;

  /**
   * Optional: The text color of the button.
   */
  textColor?: string;

  /**
   * Optional: The font size of the text on the button.
   */
  textSize?: number;

  /**
   * The width of the button.
   */
  buttonWidth: number;

  /**
   * The height of the button.
   */
  buttonHeight: number;

  /**
   * Optional: The width of the button border.
   */
  borderWidth?: number;

  /**
   * Optional: The border radius of the button.
   */
  borderRadius?: number;

  /**
   * Optional: The color of the button border.
   */
  borderColor?: string;

  /**
   * Optional: The font family of the text on the button.
   */
  textFontFamily?: string;
}

/**
 * Represents the properties for the CustomCheckoutView component.
 */
export interface customCheckoutViewProps {
  /**
   * The request object for the payment operation.
   */
  requestObject: RequestObject;

  /**
   * The environment in which the payment will be processed ('TEST' or 'PRODUCTION').
   */
  environment: 'TEST' | 'PRODUCTION';

  /**
   * Callback function invoked on successful payment.
   */
  onSuccess?: (response: any) => void;

  /**
   * Callback function invoked on payment failure.
   */
  onFailure?: (response: any) => void;

  /**
   * The style object for the CustomCheckoutView component.
   */
  style: ViewStyle;

  /**
   * The properties for the PayButton component.
   */
  payButtonProps: payButtonProps;
}

/**
 * Represents the properties for the StandardCheckoutView component.
 */
export interface standardCheckoutViewProps {
  /**
   * Boolean flag indicating whether to show the standard checkout page.
   */
  showStandardCheckoutPage: boolean;

  /**
   * The environment in which the payment will be processed ('TEST' or 'PRODUCTION').
   */
  environment: 'TEST' | 'PRODUCTION';

  /**
   * The code associated with the checkout.
   */
  requestCode: any;

  /**
   * Boolean flag indicating whether to show the loading spinner.
   */
  showLoading: boolean;

  /**
   * Boolean flag indicating whether to show the response page.
   */
  showResponsePage: boolean;

  /**
   * The request object for the payment operation.
   */
  requestObject: RequestObject;

  /**
   * Callback function invoked on successful payment.
   */
  onSuccess: (response: string) => void;

  /**
   * Callback function invoked on payment failure.
   */
  onFailure: (response: string) => void;

  /**
   * Optional: Callback function invoked when the user cancels the payment.
   */
  onCancel?: (response: string) => void;
}
