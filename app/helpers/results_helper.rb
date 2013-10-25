module ResultsHelper
  def time_to_recd(time_hash)
    time_hash[:mins].to_i*60 + time_hash[:secs].to_i
  end

  def rds_to_recd(rds_hash, baserep)
    rds_hash[:rds].to_i*baserep + rds_hash[:reps].to_i
  end
end
