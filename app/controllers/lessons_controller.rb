class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_current_lesson

  def show
  end

  private

  helper_method :current_lesson


  def require_authorized_for_current_lesson
    if current_user.enrolled_in?(current_lesson.section.course) == false
      redirect_to course_path(current_lesson.section.course), alert: "You must enroll in the course to view this page"
    end
  end

  def current_lesson
    current_lesson ||= Lesson.find(params[:id])
  end

  def lesson_params #added during troubleshooting Flixter 28
    params.require(:lesson).permit(:title, :subtitle, :video)
  end
end
