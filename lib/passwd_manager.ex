defmodule PasswdManager do
  def prompt do
    IO.puts("1. Register a password\n2. View a password\n3. Delete")
    {op, _} = IO.gets("What do you want to do: ") |> String.trim |> Integer.parse
    case op do
      1 -> PasswdManager.register()
      2 -> PasswdManager.view()
      3 -> PasswdManager.delete()
      _ -> IO.puts("Invalid option.")
    end
  end # end of prompt

  def register do
    username = IO.gets("Enter the name of a programme: ") |> String.trim
    password = IO.gets("Enter your password: ") |> String.trim
    binary = :erlang.term_to_binary(password)
    
    case File.exists?("./#{username}") do
      true -> 
        IO.puts("File already exists.")
        answer = Prompt.confirm("Do you want to overwrite it?")
        if answer == :yes do
          File.write(username, binary)
          IO.puts("File overwriten.")
        end

      false -> 
        File.write(username, binary)
        IO.puts("The password has been stored.")
    end # end of case
  end

  def view do 
    username = IO.gets("Enter the name of a programme: ") |> String.trim
    
    case File.read(username) do
      {:ok, binary} -> 
        :erlang.binary_to_term(binary)
      {:error, _reason} -> "Password for that programme has not been saved."
    end
  
  end # end of view

  def delete do
    username = IO.gets("Enter the name of a programme: ") |> String.trim

    case File.exists?("./#{username}") do
      true -> File.rm(username)
      false -> "Password for that programme has not been saved."
    end

  end

end
