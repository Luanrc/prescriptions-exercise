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
    tasks_done = (Task.new(size: 5, completed_at: 1.day.ago))
    tasks_remaing = (Task.new(size: 2))
    project.tasks = [tasks_done, tasks_remaing]

    expect(project.remaining_size).to eq(2)
  end

  it "knows its velocity" do
    project = described_class.new
    newly_done = (Task.new(size: 3, completed_at: 1.day.ago))
    project.tasks = [newly_done]

    expect(project.completed_velocity).to eq(3)
 end
  
  it "knows its rate" do
    project = described_class.new
    newly_done = (Task.new(size: 3, completed_at: 1.day.ago))
    old_done = (Task.new(size: 2, completed_at: 6.months.ago))
    project.tasks = [newly_done, old_done]

    expect(project.current_rate).to eq(1.0 / 7)
 end

  it "knows its projected days remaining" do
    project = described_class.new
    newly_done = (Task.new(size: 3, completed_at: 1.day.ago))
    old_done = (Task.new(size: 2, completed_at: 6.months.ago))
    not_done = (Task.new(size: 5))
    project.tasks = [newly_done, old_done, not_done]

    expect(project.projected_days_remaining).to eq(35)
 end

  it "knows if it is not on schedule" do
    project = described_class.new
    old_done = (Task.new(size: 2, completed_at: 6.months.ago))
    project.tasks = [old_done]
    project.due_date = 1.week.from_now

    expect(project).not_to be_on_schedule
  end

  it "knows if it is on schedule" do
    project = described_class.new
    newly_done = (Task.new(size: 3, completed_at: 1.day.ago))
    project.tasks = [newly_done]
    project.due_date = 6.months.from_now

    expect(project).to be_on_schedule
  end

  it "properly handles a blank project" do
    project = described_class.new

    expect(project.completed_velocity).to eq(0)
    expect(project.current_rate).to eq(0)
    expect(project.projected_days_remaining).to be_nan
    expect(project).not_to be_on_schedule
  end
end