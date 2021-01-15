# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ConfigFileTransform do
  describe 'validate parse' do
    context 'invalid config file' do
      it 'returns an empty hash when the file is not found' do
        expect(ConfigFileTransform.new('missingfile.txt').to_hash).to eq({})
      end
      it 'returns an empty hash when the file is not readable' do
        # TODO
      end
      it 'returns an empty hash when the file is binary' do
        # TODO
      end
    end
  end

  context 'valid config file' do
    let(:file_with_all_key_value_pair_types_resp) do
      {
        bool_val: true,
        int_val: 1,
        float_val: 1.0,
        string_val: 'hello'
      }
    end
    let(:file_with_embedded_delimeter_value_resp) do
      {
        bool_val: true,
        int_val: 1,
        float_val: 1.0,
        string_val: 'hel=lo'
      }
    end
    let(:file_with_overriden_value_resp) do
      {
        bool_val: true,
        int_val: 1,
        float_val: 1.0,
        string_val: 'hello2'
      }
    end
    it 'returns an empty hash when the file is empty' do
      expect(ConfigFileTransform.new('spec/config_files/empty_file.txt').to_hash).to eq({})
    end
    it 'returns an empty hash when the file is not empty, but contains no key value pairs' do
      expect(ConfigFileTransform.new('spec/config_files/file_with_contents_no_key_value_pairs.txt').to_hash).to eq({})
    end
    it 'returns a hash containing correct value types' do
      expect(ConfigFileTransform.new('spec/config_files/file_with_all_key_value_pair_types.txt').to_hash).to eq(file_with_all_key_value_pair_types_resp)
    end
    it 'returns a hash containing an overriden value' do
      expect(ConfigFileTransform.new('spec/config_files/file_with_overriden_value.txt').to_hash).to eq(file_with_overriden_value_resp)
    end
    it 'returns a hash containing an value with an embedded delimeter' do
      expect(ConfigFileTransform.new('spec/config_files/file_with_embedded_delimeter_value.txt').to_hash).to eq(file_with_embedded_delimeter_value_resp)
    end
  end
end
