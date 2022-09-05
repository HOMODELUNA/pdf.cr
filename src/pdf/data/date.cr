require "../obj/renderable"
module PDF
  # PDF defines a standard date format, which closely follows that of the international 
  # standard ASN.1 (Abstract Syntax Notation One), defined in ISO/IEC 8824 (see the Bibliography). 
  # A date is a string of the form 
  #```plaintext
  # (D:YYYYMMDDHHmmSSOHH'mm')
  #```
  # where 
  #- `YYYY` is the year 
  #- `MM` is the month 
  #- `DD` is the day (01–31) 
  #- `HH` is the hour (00–23) 
  #- `mm` is the minute (00–59) 
  #- `SS` is the second (00–59) 
  #- `O` is the relationship of local time to Universal Time (UT), denoted by one of the characters +, −, or Z (see below) 
  #- `HH` followed by ' is the absolute value of the offset from UT in hours (00–23) 
  #- `mm` followed by ' is the absolute value of the offset from UT in minutes (00–59) 
  #
  # The quotation mark character (') after HH and mm is part of the syntax. All fields
  # after the year are optional. (The prefix D:, although also optional, is strongly recommended.) 
  #
  # The default values for MM and DD are both 01; all other numerical
  # fields default to zero values. 
  #
  #A plus sign (+) as the value of the O field signifies that
  # local time is later than UT, a minus sign (−) that local time is earlier than UT, and
  # the letter Z that local time is equal to UT. If no UT information is specified, the
  # relationship of the specified time to UT is considered to be unknown. Whether or
  # not the time zone is known, the rest of the date should be specified in local time. 
  #
  # For example, December 23, 1998, at 7:52 PM, U.S. Pacific Standard Time, is represented by the string 
  # `D:199812231952−08'00'`
  class Date
    @time : Time = Time.unix(0)
    #format a crystal `Time` to string
    def self.format(time : Time)
      check = ->(number : Int32,digits : Int32){
        if number >= 10**digits
          raise "date number #{number} overgoes the digits limit #{digits}"
        end
      }
      yyyy ,mm_month,dd=time.date

      hh = time.hour
      mm_minute = time.minute
      ss = time.second
      check.call(yyyy,4)
      [mm_month,dd,hh,mm_minute,ss].each do |num|
        check.call(num,2)
      end

      o,dh,dm = if z = time.zone
        off = z.offset
        sign = case off
        when off>0 then '+'
        when off <0 then '-'
        when off=0 then 'Z'
        end
        off = off.abs
        {sign,off.tdiv(3600),off.tdiv(60)}
      else
        {'Z',0,0}
      end

      return String.build do |str|
        str << "D:"
        str << yyyy.to_s(precision=4)
        str << mm_month.to_s(precision=2)
        str << dd.to_s(precision=2)
        str << hh.to_s(precision=2)
        str << mm_minute.to_s(presion=2)
        str << ss.to_s(precision=2)
        str << o <<'\''
        str << dh.to_s(precision=2)
        str << dm.to_s(precision=2)
        str << '\''
      end
    end
    def render_to_pdf(io : IO) : IO
      io << Date.render_to_pdf(@time)
    end
    include Renderable
  end
end