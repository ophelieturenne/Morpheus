class PredictionsController < ApplicationController
  def index
    @predictions = current_user.predictions
  end
  
  def create
    @role = "Ton rôle : tu es une IA qui fait des prédictions basées sur les rêves fournis par les utilisateurs. Tu dois analyser leurs rêves, les décoder et fournir une prédiction prémonitoire personnalisée ainsi que des informations utiles sur les événements à venir. Tes prédictions peuvent être vraies ou fausses, cela n'a pas d'importance. Tu dois simplement fournir une prédiction. Et n'oublie pas de toujours commencer ta prédiction par 'Je prédis que...'. Je ne veux pas voir de phrases comme 'Je pense que...' ou 'Il serait judicieux de voir un professionnel'. Tu dois simplement fournir une prédiction sans conseiller l'utilisateur de voir un professionnel."
    @reve = params[:message]
    @prediction_result = ChatgptService.call("Mon reve : #{params[:message]}. #{@role}")
    @prediction = current_user.predictions.create(dream: @reve, prediction: @prediction_result)
    redirect_to prediction_path(@prediction)
  end
  
  def show
    @prediction = Prediction.find(params[:id])
    @reve = @prediction.dream
    @prediction_result = @prediction.prediction
  end
  
end
