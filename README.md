# Iugu

Elixir library for working with the [Iugu REST API](https://dev.iugu.com/v1.0).

Since the lib is still in its early days one may find some missing endpoints,
so please check the [Endpoint Coverage](#endpoint-coverage) section for more details.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `iugu` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:iugu, "~> 0.1.0"}]
    end
    ```

  2. Ensure `iugu` is started before your application:

    ```elixir
    def application do
      [applications: [:iugu]]
    end
    ```

## Endpoint Coverage

- [ ] Accounts
  - [ ] Financial Statement
  - [ ] Invoice Statement
- [ ] API Tokens
  - [ ] Renew Access Token
  - [x] Create API Token
  - [ ] Remove API Token
  - [ ] List API Tokens
- [ ] Chargebacks
  - [ ] Contest Chargeback
  - [ ] Accept Chargeback
  - [ ] Show Chargeback
  - [ ] List Chargebacks
- [ ] Customers
  - [ ] Create Customer
  - [ ] Update Customer
  - [ ] Remove Customer
  - [ ] Show Customer
  - [x] List Customers
- [ ] Emails
  - [ ] List Available Email Identifiers
  - [ ] Show Default Layout
  - [ ] Preview Email
  - [ ] Send Test Email
  - [ ] Create Email
  - [ ] Update Email
  - [ ] Remove Email
  - [ ] Show Email
  - [ ] List Emails
- [ ] Financial Transaction Requests
  - [ ] List Receivables
  - [ ] Simulate Anticipation of Receivables
  - [ ] Anticipate Receivables
- [ ] Invoices
  - [ ] Create Invoice
  - [ ] Capture Invoice
  - [ ] Refund Invoice
  - [ ] Cancel Invoice
  - [ ] Update Invoice
  - [ ] Remove Invoice
  - [ ] Show Invoice
  - [ ] List Invoices
- [ ] Marketplaces
  - [ ] Create Account
  - [ ] Send Account Verification
  - [ ] Account Information
  - [ ] Account Configuration
  - [ ] Add Bank Verification
  - [ ] Show Bank Verification
  - [ ] Request Withdraw
  - [ ] List Accounts
- [ ] Payment Methods
  - [ ] Create Payment Method
  - [ ] Update Payment Method
  - [ ] Remove Payment Method
  - [ ] Show Payment Method
  - [ ] List Payment Methods
- [ ] Plans
  - [ ] Create Plan
  - [ ] Update Plan
  - [ ] Remove Plan
  - [ ] Show Plan
  - [ ] Search Plan by Identifier
  - [ ] List Plans
- [ ] Subscriptions
  - [ ] Create Subscription
  - [ ] Activate Subscription
  - [ ] Suspend Subscription
  - [ ] Update Subscription
  - [ ] Simulate Subscription Plan Change
  - [ ] Update Subscription Plan
  - [ ] Add Credits to Subscription
  - [ ] Remove Credits from Subscription
  - [ ] Remove Subscription
  - [ ] Show Subscription
  - [ ] List Subscriptions
- [ ] Transfers
  - [ ] Transfer Value
  - [ ] Show Transfers
  - [ ] List Transfers
- [ ] Web Hooks
  - [ ] List Supported Events
  - [ ] Create Web Hook
  - [ ] Update Web Hook
  - [ ] Remove Web Hook
  - [ ] Show Web Hook
  - [ ] List Web Hooks
- [ ] Withdraw Requests
  - [ ] Show Withdraw Request
  - [ ] List Withdraw Requests

## Usage

### Customer

#### List

```elixir
request = %Iugu.Request{api_key: "YOUR_API_KEY"}
Iugu.Customer.list(request)
#=> {:ok, [%Iugu.Customer{cc_emails: nil, city: "Campo Mourão", complement: "Cobertura", ...}], 128}
```
