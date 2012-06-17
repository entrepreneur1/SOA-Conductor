class ClinicExt
  include SoapModel
  attributes :id, :name, :address_id, :created_at, :updated_at
  crud :clinic
end