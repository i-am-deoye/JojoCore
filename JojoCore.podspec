
Pod::Spec.new do |s|
          #1.
          s.name               = "JojoCore"
          #2.
          s.version            = "0.1.8"
          #3.  
          s.summary         = "'JojoCore' framework"
          #4.
          s.homepage        = "https://github.com/i-am-deoye/JojoCore"
          #5.
          s.license              = "MIT"
          #6.
          s.author               = "Moses Ayankoya"
          #7.
          s.platform            = :ios, "10.0"
          #8.
          s.source              = { :git => "https://github.com/i-am-deoye/JojoCore.git", :tag => "0.1.8" }
          #9.
          s.source_files     = "JojoCore", "JojoCore/**/*.{h,m,swift}"
          s.swift_version = '5'
    end
