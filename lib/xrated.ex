defmodule Xrated do
  use Application


  @config Application.get_all_env(:xrated)
  @k_factor (@config[:k_factor] || 40)


  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    opts = [strategy: :one_for_one, name: Xrated.Supervisor]
    Supervisor.start_link([], opts)
  end


  def expected_score(rating_a, rating_b) do
    power = (rating_b - rating_a) / 400.0
    denominator = 1.0 + :math.pow(10, power)
    1.0 / denominator
  end

  def calculate_rating_delta(player_a, player_b, :win),
  do: calculate_rating_delta(player_a, player_b, 1.0)

  def calculate_rating_delta(player_a, player_b, :tie),
  do: calculate_rating_delta(player_a, player_b, 0.5)


  def calculate_rating_delta(player_a, player_b, score_a) do
    @k_factor * (score_a - expected_score(player_a, player_b))
  end
end
