# coding: binary
# Generated by generate-specs
require 'helper'

describe_moneta "adapter_datamapper" do
  require 'dm-core'
  DataMapper.setup(:default, adapter: :in_memory)
  def features
    [:create]
  end

  def new_store
    Moneta::Adapters::DataMapper.new(setup: "mysql://root:@localhost/moneta", table: "adapter_datamapper")
  end

  def load_value(value)
    Marshal.load(value)
  end

  include_context 'setup_store'
  it_should_behave_like 'concurrent_create'
  it_should_behave_like 'create'
  it_should_behave_like 'features'
  it_should_behave_like 'multiprocess'
  it_should_behave_like 'not_increment'
  it_should_behave_like 'null_stringkey_stringvalue'
  it_should_behave_like 'null_pathkey_stringvalue'
  it_should_behave_like 'persist_stringkey_stringvalue'
  it_should_behave_like 'persist_pathkey_stringvalue'
  it_should_behave_like 'returndifferent_stringkey_stringvalue'
  it_should_behave_like 'returndifferent_pathkey_stringvalue'
  it_should_behave_like 'store_stringkey_stringvalue'
  it_should_behave_like 'store_pathkey_stringvalue'
  it_should_behave_like 'store_large'
  it 'does not cross contaminate when storing' do
    first = Moneta::Adapters::DataMapper.new(setup: "mysql://root:@localhost/moneta", table: "datamapper_first")
    first.clear

    second = Moneta::Adapters::DataMapper.new(repository: :sample, setup: "mysql://root:@localhost/moneta", table: "datamapper_second")
    second.clear

    first['key'] = 'value'
    second['key'] = 'value2'

    first['key'].should == 'value'
    second['key'].should == 'value2'
  end

  it 'does not cross contaminate when deleting' do
    first = Moneta::Adapters::DataMapper.new(setup: "mysql://root:@localhost/moneta", table: "datamapper_first")
    first.clear

    second = Moneta::Adapters::DataMapper.new(repository: :sample, setup: "mysql://root:@localhost/moneta", table: "datamapper_second")
    second.clear

    first['key'] = 'value'
    second['key'] = 'value2'

    first.delete('key').should == 'value'
    first.key?('key').should be_false
    second['key'].should == 'value2'
  end

end