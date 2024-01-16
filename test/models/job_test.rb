require "test_helper"

class JobTest < ActiveSupport::TestCase
  setup do
    @user = create(:user)
  end

  test "ordering" do
    list = create_list(:job, 10, user: @user)
    assert_equal list[0], Job.rank(:order).first, "Jobs not being ordered last as they are created"
    assert_equal list[9], Job.rank(:order).last, "Jobs not being ordered last as they are created"
  end

  test "reorder up" do
    list = create_list(:job, 10, user: @user)
    list[2].reorder_up!
    assert_equal Job.rank(:order).second, list[2]
  end

  test "reorder down" do
    list = create_list(:job, 10, user: @user)
    list[2].reorder_down!
    assert_equal Job.rank(:order).fourth, list[2]
  end

  test "days since last note" do
    job = create(:job, user: @user)
    note = create(:note, job: job)
    time = Time.now - 7.days
    job.notes.update_all(created_at: time)
    assert_equal 7, job.days_since_last_note?
    assert job.exact_days_since_last_note? > 7
  end

  test "search" do
    job_1 = create(:job, user: @user, title: 'Wacky manager')
    job_2 = create(:job, user: @user, agency: 'Woozy Doozy Co')
    job_3 = create(:job, user: @user, primary_contact_name: 'Willx Wonky')

    assert_equal 3, Job.search(@user, 'w').count
    assert_equal job_1, Job.search(@user, 'wacky').first
    assert_equal job_2, Job.search(@user, 'doo').first
    assert_equal job_3, Job.search(@user, 'willx').first
  end

  test "last note status" do
    job = create(:job)
    create(:general_note, job: job)
    applied_note = create(:applied_note, job: job)
    create(:general_note, job: job)

    assert_equal applied_note, job.last_note_status
  end

  test "days since last status change" do
    job = create(:job)
    assert_equal 0, job.days_since_status_change

    first_note = job.notes.first
    first_note.update(created_at: Time.now - 3.days)
    assert_equal 3, job.days_since_status_change
  end

  test "days since last status change with deletes" do
    job = create(:job)
    first_note = job.notes.first
    first_note.update(created_at: Time.now - 5.days)
    applied_note = create(:applied_note, job: job)

    assert_equal 0, job.days_since_status_change
    applied_note.destroy
    assert_equal 5, job.days_since_status_change
  end
end
