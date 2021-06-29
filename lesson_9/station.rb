# frozen_string_literal: true

require_relative 'instance_counter'

class Station
  include InstanceCounter

  attr_reader :trains, :name

  NAME_FORMAT = /^[а-яa-z]{3}$/i.freeze

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

  private

  def validate!
    raise StandardError, 'Ошибка! формат названия станции: три буквы' if name !~ NAME_FORMAT
  end
end
