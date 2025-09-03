class DocsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_owner

  def index
    @docs = Doc.order(:title)
  end

  def new
    @doc = Doc.new
  end

  def create
    @doc = Doc.new(doc_params)
    if @doc.save
      @doc.file.attach(params.require(:doc).require(:file))
      redirect_to @doc, notice: "Uploaded"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @doc = Doc.find_by!(slug: params[:id])
  end

  private
  def doc_params
    params.require(:doc).permit(:slug, :title)
  end
end
