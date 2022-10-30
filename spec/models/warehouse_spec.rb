require 'rails_helper'

describe Warehouse do
  context '.all' do
    it 'deve retornar todos os galpões' do
      json_data = File.read(Rails.root.join('spec/support/json/warehouses.json'))
      fake_response = double('faraday_response', status: 200, body: json_data)
      allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/warehouses').and_return(fake_response)


      result = Warehouse.all

      expect(result.length).to eq 2
      expect(result[0].name).to eq 'Maceio'
      expect(result[0].code).to eq 'MCZ'
      expect(result[0].city).to eq 'Maceio'
      expect(result[0].area).to eq 50000
      expect(result[0].address).to eq 'Av do Aeroporto, 20'
      expect(result[0].cep).to eq '80000000'
      expect(result[0].description).to eq 'Galpão de Maceio'
      expect(result[1].name).to eq 'Fortaleza'
      expect(result[1].code).to eq 'FOR'
      expect(result[1].city).to eq 'Fortaleza'
      expect(result[1].area).to eq 4000
      expect(result[1].address).to eq 'Av. Heráclito Graça, 1000'
      expect(result[1].cep).to eq '60000021'
      expect(result[1].description).to eq 'Localizado no Ceará'
    end

    it 'deve retornar vazio se a API estiver indisponível' do
      fake_response = double('faraday_response', status: 500, body: "{ 'error': 'Erro ao obter dados' }")
      allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/warehouses').and_return(fake_response)

      result = Warehouse.all

      expect(result).to eq []
    end
  end
end
