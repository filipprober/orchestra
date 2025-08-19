# Orchestra

Retrieve modules implementing specific behaviours.

## Installation

Add `:orchestra` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:orchestra, "~> 1.0.0"}
  ]
end
```

## Usage

```elixir
# Retrieve the current application name:
current_app = Mix.Project.config()[:app]

# Retrieve all modules implementing the `Illuminate.Console.Command` behaviour:
Orchestra.apps([:illuminate, current_app])
|> Orchestra.get(Illuminate.Console.Command)
```

## License

Orchestra is open-sourced software licensed under the [MIT license](LICENSE.md).
