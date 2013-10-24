require 'debugger'

module WodsHelper
  def desc_layout(wod)
    sanitize(wod.description.gsub(/\n/,'<br>'), :tags => %w(br) )
  end

  def result_avg(wod, rx=nil)
    case rx
    when true
      total_recd = wod.results.rxd.pluck(:recd).inject('+')
      return '' if total_recd == nil
      avg_recd = total_recd.to_f/wod.results.rxd.count
    when false
      total_recd = wod.results.sxd.pluck(:recd).inject('+')
      return '' if total_recd == nil
      avg_recd = total_recd.to_f/wod.results.sxd.count
    else
      total_recd = wod.results.pluck(:recd).inject('+')
      return '' if total_recd == nil
      avg_recd = total_recd.to_f/wod.results.count
    end
    
    if wod.wod_type == "Time"
      Time.local(1999,1,1,0, (avg_recd/wod.baserep).to_i, (avg_recd%wod.baserep).to_i).strftime "%M:%S"
    else
    #   formatted = "#{(avg_recd/wod.baserep).to_i}"
    #   if avg_recd % wod.baserep > 0
    #     +
    #    formatted += "+ #{avg_recd % wod.baserep}"
    #   end
    #   formatted
    end
  end
end
