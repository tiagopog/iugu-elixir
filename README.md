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

Check which endpoints are already covered on the [Endpoint Coverage](https://github.com/b2beauty/iugu-elixir/wiki/Endpoint-Coverage) wiki page.

## Usage

### Credentials

1. Get your [Iugu's API KEY](https://dev.iugu.com/v1.0/reference#autentica%C3%A7%C3%A3o);

2.1. Set the key on your project's config file:

Directly:

```elixir
# config/config.exs
config :iugu,
  api_key: "foobar"
```

Or export the key to your environment and access it via `System.get_env/1` (recommended):

```sh
# .env
IUGU_API_KEY=foobar
```

```elixir
# config/config.exs
config :iugu,
  api_key: System.get_env("IUGU_API_KEY"),
```

This way you can call the resource actions with no need to pass the `%Iugu.Resource{}` as argument:

```elixir
Iugu.Customer.list() #=> {:ok, [...], 42}
```

2.2. It's also possible to set the key into a `%Iugu.Request{}` struct:

```elixir
%Iugu.Request{api_key: "foobar"} |> Iugu.Customer.list()
```

### Common Actions

The CRUD actions are present in almost all the resources. Here's an usage example for those actions with the "customers" resource:

##### Create

```elixir
%Iugu.Customer{name: "Foobar", email: "foo@bar.com"} |> Iugu.Customer.create()
#=> {:ok, %Iugu.Customer{cc_emails: nil, city: "Campo Mourão", complement: "Cobertura", ...}}
```

##### Show

```elixir
Iugu.Customer.show("6DB324B6859D4D46A3B8689AC745A943")
#=> {:ok, %Iugu.Customer{cc_emails: nil, city: "Campo Mourão", complement: "Cobertura", ...}}
```

##### List

```elixir
Iugu.Customer.list()
#=> {:ok, [%Iugu.Customer{cc_emails: nil, city: "Campo Mourão", complement: "Cobertura", ...}], 128}
```

For more usage examples, please check the [Usage](https://github.com/b2beauty/iugu-elixir/wiki/Usage) wiki page.
