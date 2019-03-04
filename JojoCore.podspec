
Pod::Spec.new do |s|
          #1.
          s.name               = "JojoCore"
          #2.
          s.version            = "1.0.0"
          #3.  
          s.summary         = "'JojoCore' framework"
          #4.
          s.homepage        = "http://www.jojocore.com"
          #5.
          s.license              = "MIT"
          #6.
          s.author               = "Moses Ayankoya"
          #7.
          s.platform            = :ios, "10.0"
          #8.
          s.source              = { :git => "https://github.com/i-am-deoye/JojoCore.git", :tag => "1.0.0" }
          #9.
          s.source_files     = "JojoCore", "JojoCore/**/*.{h,m,swift}"
    end
