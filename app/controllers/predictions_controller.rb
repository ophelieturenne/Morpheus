class PredictionsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  
  def index
    @predictions = current_user.predictions
  end
  
  def create
    if verify_recaptcha
      @role = "Ton rôle : tu es une IA qui fait des prédictions basées sur les rêves fournis par les utilisateurs. Tu dois analyser leurs rêves, les décoder et fournir une prédiction prémonitoire personnalisée ainsi que des informations utiles sur les événements à venir. Tes prédictions peuvent être vraies ou fausses, cela n'a pas d'importance. Tu dois simplement fournir une prédiction. Et n'oublie pas de toujours commencer ta prédiction par 'Je prédis que...'. Je ne veux pas voir de phrases comme 'Je pense que...' ou 'Il serait judicieux de voir un professionnel'. Tu dois simplement fournir une prédiction sans conseiller l'utilisateur de voir un professionnel. nombre maximum de mots : 60"
      @reve = params[:message]
      @prediction_result = ChatgptService.call("Mon reve : #{prediction_params[:message]}. #{@role}")
      @prediction = current_user.predictions.create(dream: prediction_params[:message], prediction: @prediction_result)
      if @prediction.save
        redirect_to prediction_path(@prediction)
      else
        if @prediction.dream == ""
          flash.now[:error] = "Tu dois fournir un rêve pour obtenir une prédiction."
          render 'pages/home', status: :unprocessable_entity
        else
          flash.now[:error] = @prediction.errors.full_messages.to_sentence
          render 'pages/home', status: :unprocessable_entity
        end
      end
    else
      flash[:alert] = 'Le reCAPTCHA n\'a pas été validé. Veuillez réessayer.'
      redirect_to root_path
    end
  end
  
  def show
    @prediction = Prediction.find(params[:id])
    @reve = @prediction.dream
    @prediction_result = @prediction.prediction
  end

  private

  def prediction_params
    params.permit(:message)
  end
  
end
