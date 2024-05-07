defmodule EntradaSaida do
	def lerRegistros(path) do
		case File.read(path) do
			{:ok, conteudo} ->
				String.split(conteudo,"\n")
				|> Enum.chunk_every(5,5,:discard)
				|> Enum.map(fn registro -> [banco, moeda, data, valor, convenio] = registro
				%{banco: banco, moeda: moeda, dataVencimento: data, valor: valor, convenio: convenio} end)
			{:error, _reason} ->
				IO.puts "Erro ao ler o arquivo"
				%{}
		end
	end

	def lerCodigos(path) do
		case File.read(path) do
			{:ok, conteudo} ->
				String.split(conteudo,"\n")
			{:error, _reason} ->
				IO.puts "Erro ao ler o arquivo"
				%{}
		end
	end
end