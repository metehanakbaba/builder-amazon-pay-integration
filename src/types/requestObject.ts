/**
 * Represents the request object for general payment operations like AUTHORIZATION or PURCHASE.
 */
export interface RequestObject {
  /**
   * The command for the payment operation. Should be either 'AUTHORIZATION' or 'PURCHASE'.
   */
  command: 'AUTHORIZATION' | 'PURCHASE';

  /**
   * A unique reference identifier provided by the merchant for tracking purposes.
   */
  merchant_reference: string;

  /**
   * The amount of the transaction as a string.
   */
  amount: string;

  /**
   * The currency in which the transaction is conducted.
   */
  currency: string;

  /**
   * The language code used for communication, e.g., 'en' for English.
   */
  language: string;

  /**
   * The email address of the customer initiating the payment.
   */
  customer_email: string;

  /**
   * The SDK token associated with the payment request.
   */
  sdk_token: string;

  /**
   * Optional: The name of the token being used, if applicable.
   */
  token_name?: string;

  /**
   * Optional: The chosen payment option for the transaction.
   */
  payment_option?: string;

  /**
   * Optional: The Electronic Commerce Indicator (ECI) for the payment.
   */
  eci?: string;

  /**
   * Optional: A description of the order or transaction.
   */
  order_description?: string;

  /**
   * Optional: The IP address of the customer initiating the payment.
   */
  customer_ip?: string;

  /**
   * Optional: The name of the customer.
   */
  customer_name?: string;

  /**
   * Optional: The phone number of the customer.
   */
  phone_number?: string;

  /**
   * Optional: A reference identifier for settlement purposes.
   */
  settlement_reference?: string;

  /**
   * Optional: Additional merchant-specific data (extra field 1).
   */
  merchant_extra?: string;

  /**
   * Optional: Additional merchant-specific data (extra field 2).
   */
  merchant_extra1?: string;

  /**
   * Optional: Additional merchant-specific data (extra field 3).
   */
  merchant_extra2?: string;

  /**
   * Optional: Additional merchant-specific data (extra field 4).
   */
  merchant_extra3?: string;

  /**
   * Optional: Additional merchant-specific data (extra field 5).
   */
  merchant_extra4?: string;

  /**
   * Optional: Additional merchant-specific data (extra field 6).
   */
  merchant_extra5?: string;
}

/**
 * Represents the request object for direct payment operations like AUTHORIZATION or PURCHASE
 * where card security code information is required.
 */
export interface RequestObjectDirectPay extends RequestObject {
  /**
   * The name of the token associated with the payment request.
   */
  token_name: string;

  /**
   * The card security code required for direct payment transactions.
   */
  card_security_code: string;
}
