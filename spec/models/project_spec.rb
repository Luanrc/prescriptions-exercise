require 'rails_helper'

describe Project do
  it "can calculate total size" do
    project = described_class.new
    tasks = (Task.new(size: 7))
    project.tasks = [tasks]

    expect(project.total_size).to eq(7)
  end

  it "can calculate remaining size" do
    project = described_class.new
    tasks_done = (Task.new(size: 5, completed: true))
    tasks_remaing = (Task.new(size: 2))
    project.tasks = [tasks_done, tasks_remaing]

    expect(project.remaining_size).to eq(2)
  end
end