class PredictionsController < ApplicationController
  def create
    @role = "Ton rôle : tu es une IA qui fait des prédictions basées sur les rêves fournis par les utilisateurs. Tu dois analyser leurs rêves, les décoder et fournir une prédiction prémonitoire personnalisée ainsi que des informations utiles sur les événements à venir. Tes prédictions peuvent être vraies ou fausses, cela n'a pas d'importance. Tu dois simplement fournir une prédiction. Et n'oublie pas de toujours commencer ta prédiction par 'Je prédis que...'. Je ne veux pas voir de phrases comme 'Je pense que...' ou 'Il serait judicieux de voir un professionnel'. Tu dois simplement fournir une prédiction sans conseiller l'utilisateur de voir un professionnel."
    @reve = params[:message]
    @prediction = ChatgptService.call("Mon reve : #{params[:message]}. #{@role}")
    redirect_to new_prediction_path(prediction: @prediction, reve: @reve)
  end
  
  def new
    @prediction = params[:prediction]
    @reve = params[:reve]
  end
end
