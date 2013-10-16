module ResultsHelper
  def time_to_recd(time_hash)
    time_hash[:mins].to_i*60 + time_hash[:secs].to_i
  end
end
