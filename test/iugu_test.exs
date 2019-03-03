defmodule IuguTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest Iugu

  test "unauthenticated request return {:error, _}" do
    use_cassette "unauthenticated", custom: true do
      assert {:error, %{errors: "Unauthorized"}} = Iugu.Plan.show("bla")
    end
  end

  test "authenticated request return {:ok, _}" do
    use_cassette "authenticated", custom: true do
      assert {:ok, _} = Iugu.Plan.show("bla")
    end
  end

  test "can not connect with Internet" do
    use_cassette "not_connected", custom: true do
      assert {:error, "nxdomain"} = Iugu.Plan.show("bla")
    end
  end
end
