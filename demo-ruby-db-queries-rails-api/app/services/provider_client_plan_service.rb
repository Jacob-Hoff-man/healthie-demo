require_relative 'result'

class ProviderClientPlanService
  Result = ::Result
  
  class << self
    def create_provider_client_plan(params)
      provider_client_plan = ProviderClientPlan.new(params)
      
      if provider_client_plan.save
        Result.success(provider_client_plan)
      else
        Result.error(provider_client_plan.errors.full_messages)
      end
    end

    def delete_provider_client_plan(provider_id, client_id, plan_name)
      provider_client_plan = ProviderClientPlan.find_by(
        provider_id: provider_id,
        client_id: client_id,
        plan_name: plan_name
      )

      if provider_client_plan.nil?
        Result.error(['Provider-client-plan relationship not found'])
      elsif provider_client_plan.destroy
        Result.success(nil)
      else
        Result.error(provider_client_plan.errors.full_messages)
      end
    end

    def list_provider_clients(provider_id)
      provider_client_plans = ProviderClientPlan.includes(:client, :plan)
                                              .where(provider_id: provider_id)
      Result.success(provider_client_plans)
    end

    def list_client_providers(client_id)
      provider_client_plans = ProviderClientPlan.includes(:provider, :plan)
                                              .where(client_id: client_id)
      Result.success(provider_client_plans)
    end

    def list_plan_provider_client_plans(plan_name)
      provider_client_plans = ProviderClientPlan.where(plan_name: plan_name)
      Result.success(provider_client_plans)
    end
  end
end 