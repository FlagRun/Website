if defined? BetterErrors
  #BetterErrors.editor='rubymine://open?url=file://%{file}&line=%{line}'
  BetterErrors.editor = proc { |full_path, line|
    "x-mine://open?file=#{full_path}&line=#{line}"
  }
end