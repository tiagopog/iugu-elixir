defmodule Iugu.PaymentMethodTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest Iugu.PaymentMethod

  test ".list returns a tupple with {:ok, list, total}" do
    use_cassette "iugu_list_plan", custom: true do
      assert {:ok, [_], _total} = Iugu.Plan.list()
    end
  end

  test ".create with invalid customer_id" do
    use_cassette "iugu_create_payment_method_customer_not_found", custom: true do
      assert {:error, %{errors: "Customer Not Found"}} =
               Iugu.PaymentMethod.create("SomeCustomerId", %{
                 description: "my credit card",
                 token: "401AB53F89264BC9ACA78C99ACB80AB7",
                 set_as_default: true
               })
    end
  end

  test ".create with error in data" do
    use_cassette "iugu_create_payment_method_used", custom: true do
      assert {:error, %{errors: %{token: ["Esse token já foi usado."]}}} =
               Iugu.PaymentMethod.create("7AF40D656FD145FA89D0727ECD0D0803", %{
                 description: "my credit card",
                 token: "401AB53F89264BC9ACA78C99ACB80AB7",
                 set_as_default: true
               })
    end
  end

  test ".create successfull" do
    use_cassette "iugu_create_payment_method", custom: true do
      customer_id = "7AF40D656FD145FA89D0727ECD0D0803"
      description = "my credit card"

      assert {:ok,
              %Iugu.PaymentMethod{
                customer_id: ^customer_id,
                data: %{
                  bin: _,
                  brand: _,
                  display_number: _,
                  holder_name: _,
                  month: _,
                  year: _
                },
                description: ^description,
                id: _,
                item_type: "credit_card"
              }} =
               Iugu.PaymentMethod.create("7AF40D656FD145FA89D0727ECD0D0803", %{
                 description: description,
                 token: "6CB722861E1B4A5389DFDA839CE673E9",
                 set_as_default: true
               })
    end
  end

  test ".show" do
    use_cassette "iugu_show_payment_method", custom: true do
      customer_id = "7AF40D656FD145FA89D0727ECD0D0803"
      id = "A4B29A0C94C04B19B80AB8EFFF9AE25F"

      assert {:ok,
              %Iugu.PaymentMethod{
                customer_id: ^customer_id,
                data: %{
                  bin: _,
                  brand: _,
                  display_number: _,
                  holder_name: _,
                  month: _,
                  year: _
                },
                description: _,
                id: ^id,
                item_type: "credit_card"
              }} = Iugu.PaymentMethod.show(customer_id, id)
    end
  end

  test ".update" do
    # use_cassette "" do
    # end
  end

  test ".delete" do
    # use_cassette "" do
    # end
  end
end
