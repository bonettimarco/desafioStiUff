class DocumentosController < ApplicationController
    require 'csv'  
  before_action :set_documento, only: [:show, :edit, :update, :destroy]

  # GET /documentos
  # GET /documentos.json
  def index
    @documentos = Documento.all
  end

  # GET /documentos/1
  # GET /documentos/1.json
  def show
  end

  # GET /documentos/new
  def new
    @documento = Documento.new
  end

  # GET /documentos/1/edit
  def edit
  end

  # POST /documentos
  # POST /documentos.json
  def create
    @documento = Documento.new(documento_params)

    respond_to do |format|
      if @documento.save
        importa_dados
        format.html { redirect_to dados_path, notice: 'Documento foi importado com sucesso.' }
        format.json { render :show, status: :created, location: @documento }
      else
        format.html { render :new }
        format.json { render json: @documento.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /documentos/1
  # PATCH/PUT /documentos/1.json
  def update
    respond_to do |format|
      if @documento.update(documento_params)
        format.html { redirect_to @documento, notice: 'Documento was successfully updated.' }
        format.json { render :show, status: :ok, location: @documento }
      else
        format.html { render :edit }
        format.json { render json: @documento.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documentos/1
  # DELETE /documentos/1.json
  def destroy
    @documento.destroy
    respond_to do |format|
      format.html { redirect_to documentos_url, notice: 'Documento was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  #método que trata o arquivo CSV para importar para o BD
  def importa_dados
        csv_text = File.read(@documento.file.path) #leitura do arquivo
        csv = CSV.parse(csv_text, :headers => false, :col_sep => ",") #normalização do tab
        linhas = csv[1..csv.count] #eliminação do cabeçalho
        linhas.each do |row| #processo de gravação de dados no BD
        if checa = Dado.find_by(matricula: row[1])
        else
          store = Dado.new(nome: row[0],matricula:row[1],telefone:row[2],email:row[3],uffmail:row[4],status:row[5]) 
          store.save
        end
        end
  end

    # Use callbacks to share common setup or constraints between actions.
    def set_documento
      @documento = Documento.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def documento_params
      params.require(:documento).permit(:file)
    end
end
