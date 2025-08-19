defmodule Orchestra do
  @moduledoc """
  Retrieve modules implementing specific behaviours.
  """

  defstruct apps: []

  @doc """
  Provide a list of applications to search for modules implementing a specific behaviour.
  """
  def apps(apps) when is_list(apps) do
    %Orchestra{apps: apps |> Enum.uniq()}
  end

  @doc """
  Retrieve modules implementing a specific behaviour from the provided applications.
  """
  def get(%__MODULE__{} = orchestra, behaviour) do
    mods =
      for app <- orchestra.apps do
        case :application.get_key(app, :modules) do
          {:ok, modules} ->
            modules
            |> Enum.filter(fn module ->
              try do
                behaviours = module.__info__(:attributes)
                  |> Keyword.get_values(:behaviour)
                  |> List.flatten()

                behaviour in behaviours
              rescue
                _ -> false
              end
            end)

          _ -> []
        end
      end
      |> List.flatten()

    mods
  end
end

