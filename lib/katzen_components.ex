defmodule Katzen.Components do
  defmacro __using__(_) do
    quote do
      import Katzen.Components.{
        Accordion,
        Container,
        Button,
        Link,
        Typography.Headers,
        Typography.Text,
        Separator,
        Modal
      }
    end
  end
end
