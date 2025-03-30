require_relative 'result'

class PlanService
  Result = ::Result

  class << self
    def list_plans
      Result.success(Plan.all)
    end

    def find_plan(name)
      plan = Plan.find_by(name: name)
      plan ? Result.success(plan) : Result.error(['Plan not found'])
    end

    def create_plan(params)
      plan = Plan.new(params)
      if plan.save
        Result.success(plan)
      else
        Result.error(plan.errors.full_messages)
      end
    end

    def update_plan(plan, params)
      if plan.update(params)
        Result.success(plan)
      else
        Result.error(plan.errors.full_messages)
      end
    end

    def delete_plan(plan)
      if plan.destroy
        Result.success(nil)
      else
        Result.error(plan.errors.full_messages)
      end
    end
  end
end 