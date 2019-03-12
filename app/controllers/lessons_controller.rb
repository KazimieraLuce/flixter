class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_current_lesson

  def show
  end

  private

  helper_method :current_lesson
  helper_method :current_course #didn't help, consider deleting

  def require_authorized_for_current_lesson
    # course = current_lesson.section.course(:course_id)
    if current_user.enrolled_in?(current_lesson.section.course) == false
      #doesn't work with just course, current_course or @course as enrolled_in? argument
    #tried if current_user != current_user.enrolled_in? and as expected, did not work
      redirect_to course_path, alert: "You must enroll in the course to view this page"
      #tried course_path(course) and course_path(@course) and course_path(current_course)
    end
  end

  def current_lesson
    current_lesson ||= Lesson.find(params[:id])
  end
  def current_course #didn't help, consider deleting   
    current_course ||= Course.find(params[:course_id])
  end
  def lesson_params #consider deleting, as I don't think it changed anything
    params.require(:lesson).permit(:title, :subtitle, :video)
  end
end
