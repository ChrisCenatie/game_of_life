require 'minitest/autorun'
require 'minitest/pride'
require_relative 'game_of_life'

class GameOfLifeTest < Minitest::Test

  def test_cell_is_resurrected
    grid = Grid.new(3,3)
    assert_equal false, grid.cell_alive?(0,0)

    grid.ressurect_cell(0,0)

    assert_equal true, grid.cell_alive?(0,0)
  end

  def test_cell_dies_with_only_one_neighbor
    grid = Grid.new(3,3)
    grid.ressurect_cell(0, 0)
    grid.ressurect_cell(1, 0)

    grid.next

    assert_equal false, grid.cell_alive?(0, 0)
  end

  def test_cell_stays_alive_with_only_two_neighbors
    grid = Grid.new(3,3)
    grid.ressurect_cell(0, 0)
    grid.ressurect_cell(1, 0)
    grid.ressurect_cell(0, 1)

    grid.next

    assert_equal true, grid.cell_alive?(0, 0)
  end

  def test_alive_cell_stays_alive_with_three_live_neighbors
    grid = Grid.new(3,3)
    grid.ressurect_cell(0, 0)
    grid.ressurect_cell(1, 0)
    grid.ressurect_cell(0, 1)
    grid.ressurect_cell(1,1)

    grid.next

    assert_equal true, grid.cell_alive?(1, 1)
  end

  def test_alive_cell_is_dead_with_more_than_three_live_neighbors
    grid = Grid.new(3,3)
    grid.ressurect_cell(0, 0)
    grid.ressurect_cell(1, 0)
    grid.ressurect_cell(0, 1)
    grid.ressurect_cell(1,1)
    grid.ressurect_cell(0,2)

    grid.next

    assert_equal false, grid.cell_alive?(1, 1)
  end

  def test_dead_cell_is_alive_with_exactly_three_live_neighbors
    grid = Grid.new(3,3)
    grid.ressurect_cell(0, 0)
    grid.ressurect_cell(1, 0)
    grid.ressurect_cell(0, 1)

    grid.next

    assert_equal true, grid.cell_alive?(1, 1)
  end

  def test_dead_cell_is_dead_with_more_than_three_live_neighbors
    grid = Grid.new(3,3)
    grid.ressurect_cell(0, 0)
    grid.ressurect_cell(1, 0)
    grid.ressurect_cell(0, 1)
    grid.ressurect_cell(0,2)

    grid.next

    assert_equal false, grid.cell_alive?(1, 1)
  end


end
