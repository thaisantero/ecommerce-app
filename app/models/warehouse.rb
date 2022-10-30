class Warehouse
  attr_accessor :id, :name, :city, :code, :address, :area, :cep, :description

  def initialize(id:, name:, city:, code:, address:, area:, cep:, description:)
    @id = id
    @name = name
    @city = city
    @code = code
    @address = address
    @area = area
    @cep = cep
    @description = description
  end

  def self.all
    response = Faraday.get('http://localhost:4000/api/v1/warehouses')
    warehouses = []
    if response.status == 200
      data = JSON.parse(response.body)
      data.each do |d|
        warehouses << Warehouse.new(id: d["id"], name: d["name"], code: d["code"], city: d["city"],
                                    area: d["area"], address: d["address"], cep: d["cep"],
                                    description: d["description"])
      end
    end
    warehouses
  end
end
