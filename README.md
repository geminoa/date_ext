What is this?
=============

date_ext.rb - extention for DateTime#new method.


Overview
========

DateTime#new_ext method enables developers to create the 
DateTime oject from invalid parameters of range.

How to use
==========

```ruby
>> DateTime.mnew(2009,18,55, 30,100,5000).to_s
=> "2010-07-26T09:03:20+00:00"
>> DateTime.mnew(2009,18,55, 30,100,5000,"+8").to_s
=> "2010-07-26T09:03:20+08:00"
>> DateTime.mnew(2009,18,55, 30,100,5000,"+08:00").to_s
=> "2010-07-26T09:03:20+08:00"
```
