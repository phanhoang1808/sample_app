class DemoPartialsController < ApplicationController
  def new
    @zone = t("demo_partials_c.new.zone")
    @date = Time.zone.today
  end

  def edit
    @zone = t("demo_partials_c.edit.zone")
    @date = Time.zone.today - 4
  end
end
