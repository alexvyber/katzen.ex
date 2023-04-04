defmodule Katzen.Components do
  defmacro __using__(_) do
    quote do
      import Katzen.Components.{
        Container,
        Button,
        Link,
        Typography.Headers,
        Typography.Text,
        Separator
      }
    end
  end
end
