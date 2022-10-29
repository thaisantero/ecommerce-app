require 'rails_helper'

describe 'Usuário visita tela inicial' do
  it 'e vê galpões' do
    json_data = File.read(Rails.root.join('spec/support/json/warehouses.json'))
    fake_response = double('faraday_response', status: 200, body: json_data)
    allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/warehouses').and_return(fake_response)

    visit root_path

    expect(page).to have_content 'E-Commerce App'
    expect(page).to have_content 'Fortaleza'
    expect(page).to have_content 'Maceio'
  end

  it 'e não há galpões' do
    fake_response = double('faraday_response', status: 200, body: '[]')
    allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/warehouses').and_return(fake_response)

    visit root_path

    expect(page).to have_content 'Nenhum galpão encontrado'
  end

  it 'e vê detalhes do galpão' do
    json_data = File.read(Rails.root.join('spec/support/json/warehouses.json'))
    fake_response = double('faraday_response', status: 200, body: json_data)
    allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/warehouses').and_return(fake_response)

    json_data = File.read(Rails.root.join('spec/support/json/warehouse.json'))
    fake_response = double('faraday_response', status: 200, body: json_data)
    allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/warehouses/2').and_return(fake_response)

    visit root_path
    click_on 'Maceio'

    expect(page).to have_content 'Galpão MCZ - Maceio'
    expect(page).to have_content 'Maceio'
    expect(page).to have_content '50000 m²'
    expect(page).to have_content 'Av do Aeroporto, 20 - CEP 80000-000'
    expect(page).to have_content 'Galpão de Maceio'
  end


  it 'e não é possível carregar detalhes do galpão' do
    json_data = File.read(Rails.root.join('spec/support/json/warehouses.json'))
    fake_response = double('faraday_response', status: 200, body: json_data)
    allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/warehouses').and_return(fake_response)

    error_response = double('faraday_response', status: 500, body: "{}")
    allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/warehouses/2').and_return(error_response)

    visit root_path
    click_on 'Maceio'

    expect(page).to have_content 'Não foi possível carregar detalhes do galpão'
    expect(current_path).to eq root_path
  end
end
