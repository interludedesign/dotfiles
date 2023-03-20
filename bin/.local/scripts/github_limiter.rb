class GithubLimiter
  attr_reader :remaining, :reset

  def initialize(response)
    @remaining = parse(response)[:remaining]
    @reset = parse(response)[:reset]
  end

  def limit_reached?
    remaining.zero?
  end

  def human_readable
    "Rate limit reached, try again at #{reset}." if limit_reached?
  end

  private

  def parse(response)
    @parse ||= begin
      remaining = response['x-ratelimit-remaining'].to_i
      reset = Time.at(response['x-ratelimit-reset'].to_i).strftime('%H:%M:%S')

      {remaining:, reset:}
    end
  end
end
