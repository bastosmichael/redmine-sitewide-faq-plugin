#This class provides FAQ functionality that was not present in redmine by default.
#Only Admins can create/update/delete FAQ's.  The public can view.
class FaqController < ApplicationController
  unloadable
  helper :sort
  include SortHelper

  # prevents login action to be filtered by check_if_login_required application scope filter
  skip_before_filter :check_if_login_required
  before_filter :require_admin, :only => [ :create, :new, :edit, :update, :destroy]

  #Show a list of all FAQ's in the faqs table.
  def index
    sort_init 'question', 'asc'
    sort_update 'question' => "#{Faq.table_name}.question",
                'answer' => "#{Faq.table_name}.answer",
                'creator' => "#{Faq.table_name}.creator"
              
    case params[:format]
    when 'xml', 'json'
      @offset, @limit = api_offset_and_limit
    else
      @limit = per_page_option
    end

    @faq_count = Faq.count(:all)
    @faq_pages = Paginator.new self, @faq_count, @limit, params['page']
    @offset ||= @faq_pages.current.offset
    @faqs =  Faq.find :all,
                        :order => sort_clause,
                        :limit  =>  @limit,
                        :offset =>  @offset

    render :layout => !request.xhr?
  end

  def new
    @faq = Faq.new
  end

  #Create method that creates a new FAQ and sets the attributes.
  def create
    @faq = Faq.new(params[:faq])
    @faq.creator = User.current.name
    if (@faq.save)
      flash[:notice] = "FAQ created successfully..."
      redirect_to :action => 'index'
    else
      flash[:error] = "All values are required..."
      render :action => 'new'
    end
      
  end

  def show
    @faq = Faq.find(params[:id])
  end

  def edit
    @faq = Faq.find(params[:id])
  end

  #Update faq.
  def update
    faq_to_edit = Faq.find(params[:id])
    question_answer = params[:faq].to_a
    faq_to_edit.question = question_answer.first.last
    faq_to_edit.answer = question_answer.last.last
    faq_to_edit.creator = User.current.name
    if (faq_to_edit.save)
      flash[:notice] = "FAQ updated successfully..."
      redirect_to :action => 'index'
    else
      flash[:error] = "All values are required..."
      render :action => 'edit'
    end
  end

  def destroy
    faq_to_delete = Faq.find(params[:id])
    Faq.delete(faq_to_delete)
    redirect_to :back
  rescue ::ActionController::RedirectBackError
    redirect_to :controller => 'faq', :action => 'index'
  end
  
end
