class DadosController < ApplicationController
  before_action :set_dado, only: [:show, :edit, :update, :destroy]

  # GET /dados
  # GET /dados.json
  def index
    @dados = Dado.all
  end
  
  # GET /selecionadado/
  def selecionadado
    @dado = Dado.new
  end
  
  # PATCH /selecionadado/matricula
  def dadoselecionado
    if @dado = Dado.find_by(matricula: params[:dados][:matricula])
      @opcoes = nomesEmails
    else
      respond_to do |format|
          format.html { redirect_to selecionadado_path, notice: "Matrícula não foi encontrada. Favor verificar número ou procurar atendimento ao aluno." }
      end
    end
  end
  

  # GET /dados/1
  # GET /dados/1.json
  def show
  end

  # GET /dados/new
  def new
    @dado = Dado.new
  end

  # GET /dados/1/edit
  def edit
    @dado.uffmail = params[:uffmail]
    @dado.send_email
          respond_to do |format|
        if @dado.save
          format.html { redirect_to root_path, notice: "Mail criado com sucesso. Você irá receber a confirmação em #{@dado.email}.A criação de seu e-mail (#{@dado.uffmail}) será feita nos próximos minutos.
Um SMS foi enviado para #{@dado.telefone} com a sua senha de acesso." }
        else
            format.html { redirect_to selecionadado_path, notice: "Ocorreu um erro na criação do uffmail, tente novamente por favor." }
        end
      end
  end

  # POST /dados
  # POST /dados.json
  def create
    @dado = Dado.new(dado_params)

    respond_to do |format|
      if @dado.save
        format.html { redirect_to @dado, notice: 'Dado was successfully created.' }
        format.json { render :show, status: :created, location: @dado }
      else
        format.html { render :new }
        format.json { render json: @dado.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dados/1
  # PATCH/PUT /dados/1.json
  def update
    respond_to do |format|
      if @dado.update(dado_params)
        format.html { redirect_to @dado, notice: 'Dado was successfully updated.' }
        format.json { render :show, status: :ok, location: @dado }
      else
        format.html { render :edit }
        format.json { render json: @dado.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dados/1
  # DELETE /dados/1.json
  def destroy
    @dado.destroy
    respond_to do |format|
      format.html { redirect_to dados_url, notice: 'Dado was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Método que atribui cinco possíveis cabeçalhos para email institucional
    def nomesEmails
      opcoes=[""]
      i = 0
      nome =@dado.nome.split(' ')
      n = nome.length
      nomes = Dado.all
      opcao = nome[0]
      numero = 1
      posfixo = ""
      while i < 1
        if checa = nomes.find_by(uffmail: opcao+posfixo+"@id.uff.br")
          posfixo = ""+numero.to_s
          numero = numero + 1
        else
          opcoes[i] = opcao+posfixo
          i = i+1
        end
      end
      opcao = opcao + nome[1][0]
      posfixo = ""
      numero = 1
      while i < 2
        if checa = nomes.find_by(uffmail: opcao+posfixo+"@id.uff.br")
          posfixo = ""+numero.to_s
          numero = numero + 1
        else
          opcoes[i] = opcao+posfixo
          i = i+1
        end
      end
      opcao = opcao + nome[n-1]
      posfixo = ""
      numero = 1
      while i < 3
        if checa = nomes.find_by(uffmail: opcao+posfixo+"@id.uff.br")
          posfixo = ""+numero.to_s
          numero = numero + 1
          else
          opcoes[i] = opcao+posfixo
          i = i+1
        end
      end
      opcoes[3]=""+nome[0].to_s+"_"+nome[n-1].to_s
      opcoes[4]=""+nome[0].to_s+"_"+nome[1].to_s+"_"+nome[n-1].to_s
      return opcoes
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_dado
      @dado = Dado.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dado_params
      params.require(:dado).permit(:nome, :matricula, :telefone, :email, :uffmail, :status)
    end
end
