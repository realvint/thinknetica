# frozen_string_literal: true
require_relative 'instance_counter'
require_relative 'validation'
require_relative 'accessors'

class Station
  include InstanceCounter
  include Validation
  include Accessors

  NAME_FORMAT = /^[а-яa-z]{3}$/i.freeze

  attr_reader :trains, :name

  attr_accessor_with_history :first, :last
  strong_attr_accessor :strong, String

  validate :name, :presence
  validate name, :format, NAME_FORMAT

  def initialize(name)
    register_instance
    @name = name
    validate!
    @trains = []
    self.class.all ||= []
    self.class.all << self
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def self.all
    @all ||= []
  end

  def train_arrive(train)
    @trains.push(train)
  end

  def trains_list_type(type)
    @trains.select { |train| train.type == type }
  end

  def train_depart(train)
    @trains.delete(train)
  end

  def trains_each(&block)
    @trains.each { |train| block.call(train) }
  end
end
