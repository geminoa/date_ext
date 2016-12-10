# date_mod.rb - extention for DateTime#new method.
#
# Author: Y.Ogawa 2009
#
# == Overview
# DateTime#new_mod method enables developers to create the 
# DateTime oject from invalid parameters of range.
# 
# == Examples of use
# >> DateTime.mnew(2009,18,55, 30,100,5000).to_s
# => "2010-07-26T09:03:20+00:00"
# >> DateTime.mnew(2009,18,55, 30,100,5000,"+8").to_s
# => "2010-07-26T09:03:20+08:00"
# >> DateTime.mnew(2009,18,55, 30,100,5000,"+08:00").to_s
# => "2010-07-26T09:03:20+08:00"

require 'date'

class DateTime
  def DateTime.new_mod(year=nil, month=nil, day=nil, hour=nil, min=nil, sec=nil, offset=nil)
    params = {
      :year => year, :month => month, :day => day, 
      :hour => hour, :min => min, :sec => sec, :offset => offset
    }
    params.each do |k,v|
      if v == nil
        params[k] = 0
      else
        if k != :offset
          params[k] = v.to_i
        else
          params[k] = "+" + v.to_i.to_s
        end
      end
    end

    # Correct sec.
    if params[:sec] > 59
      params[:min] += (params[:sec] / 60)
      params[:sec] = params[:sec] % 60
    end

    # Correct params[:min].
    if params[:min] > 59
      params[:hour] += (params[:min] / 60)
      params[:min] = params[:min] % 60
    end

    # Correct params[:params[:hour]].
    if params[:hour] > 23
      params[:day] += (params[:hour]/24)
      params[:hour] = params[:hour] % 24
    end

    while !(Date.valid_date?(params[:year], params[:month], params[:day]))
      if params[:month] > 12
        params[:year] += (params[:month]/12)
        params[:month] = params[:month] % 12
      end
      break if Date.valid_date?(params[:year], params[:month], params[:day])

      # Calculate the params[:day] at the end of the params[:month].
      tmp_dt = Date.new(params[:year], params[:month]+1, 1)
      tmp_dt = tmp_dt - 1
      params[:day] -= tmp_dt.day
      params[:month] += 1
    end

    return DateTime.new(
      params[:year], params[:month], params[:day], 
      params[:hour], params[:min], params[:sec], params[:offset]
    )
  end

  def DateTime.mnew(year=nil, month=nil, day=nil, hour=nil, min=nil, sec=nil, offset=nil)
    new_mod(year, month, day, hour, min, sec, offset)
  end
end
