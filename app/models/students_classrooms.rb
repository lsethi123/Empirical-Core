class StudentsClassrooms < ActiveRecord::Base
  include CheckboxCallback
  belongs_to :student, class_name: "User"
  belongs_to :classroom, class_name: "Classroom"
  validates :student, uniqueness: {scope: :classroom}
  after_save :after_save_callback

  default_scope { where(visible: true)}

  def archived_classrooms_manager
    {joinDate: self.created_at.strftime("%m/%d/%Y"), className: self.classroom.name, teacherName: self.classroom.teacher.name, id: self.id}
  end

  private

  def after_save_callback
    if self.classroom
      find_or_create_checkbox('Add Students', self.classroom.teacher)
    end
  end

end
