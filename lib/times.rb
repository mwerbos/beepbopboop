module Times
  def in(time,range)
    time>range[:start] and time<range[:end]
  end
  def intersect(timesa,timesb)
    times=[]
    timesa.each do |range|
      times<<{time: range[:start],type: :starta}
      times<<{time: range[:end],type: :enda}
    end
    timesb.each do |range|
      times<<{time: range[:start],type: :startb}
      times<<{time: range[:end],type: :endb}
    end
    times.sort_by!{|t| t[:time]}
    starta=nil
    startb=nil
    out=[]
    times.each do |t|
      if t[:type]==:starta
        starta=t[:time]
      elsif t[:type]==:startb
        startb=t[:time]
      elsif t[:type]==:enda
        if starta and startb
          out<<{start: [starta,startb].max,end: t[:time]}
        end
        starta=nil
      elsif t[:type]==:endb
        if starta and startb
          puts starta
          puts startb
          out<<{start: [starta,startb].max,end: t[:time]}
        end
        startb=nil
      end
    end
    out
  end
=begin
  def intersect(rangea,rangeb)
    #This is just for two time ranges
    out={start: max(rangea[:start],rangeb[:start]),
      end: min(rangea[:end],rangeb[:end])}
    if out[:start]<out[:end]
      return out
    else
      return nil
    end
  end
=end
end

