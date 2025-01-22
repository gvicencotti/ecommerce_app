class ViaCepService
  include HTTParty
  base_uri "https://viacep.com.br/ws"

  def self.get_address(cep)
    response = get("/#{cep}/json/")
    return nil if response.code != 200 || response.parsed_response["erro"]

    response.parsed_response
  end
end
