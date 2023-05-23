# Eject

Or you can use the `eject` option for create the controller with the implemented methods:

```bash
rails g rest_api_generator:resource car name:string color:string --eject true
```

```ruby

class CarsController < ApplicationController
  before_action :set_car, only: %i[show update destroy]

  def index
    @car = Car.all
    render json: @car, status: :ok
  end

  def show
    render json: @car, status: :ok
  end

  def create
    @car = Car.create!(car_params)
    render json: @car, status: :created
  end

  def update
    @car = Car.update!(car_params)
    render json: @car, status: :ok
  end

  def destroy
    @car.destroy!
  end

  private

  def set_car
    @car = Car.find(params[:id])
  end

  def car_params
    params.require(:car).permit(:name, :color)
  end
end
```
