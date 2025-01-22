function fetchAddress(cep) {
    if (cep.length === 8) {
      fetch(`/addresses/fetch_address?cep=${cep}`)
        .then(response => {
          if (!response.ok) throw new Error("CEP não encontrado");
          return response.json();
        })
        .then(data => {
          document.getElementById("street").value = data.address.logradouro;
          document.getElementById("neighborhood").value = data.address.bairro;
          document.getElementById("city").value = data.address.localidade;
          document.getElementById("state").value = data.address.uf;
        })
        .catch(error => {
          alert("Erro ao buscar o endereço: " + error.message);
        });
    }
  }
  