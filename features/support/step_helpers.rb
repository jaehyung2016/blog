CAPTURE_A_NUMBER = Transform /^(-?\d+)$/ do |number|
  number.to_i
end

module StepHelpers
  ARTICLES = <<-STRING.split("\n")
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec tempus erat non turpis feugiat varius. Mauris ultrices, velit vitae luctus accumsan, odio urna efficitur massa, a vestibulum ex elit nec mauris. Morbi tincidunt aliquam felis id dapibus. In hac habitasse platea dictumst. Nunc quis convallis ipsum. Vivamus egestas vulputate lorem et pretium. Integer nibh justo, euismod at euismod eu, venenatis eget ligula. Proin auctor mauris eu turpis hendrerit venenatis. In feugiat lectus sed erat vestibulum congue. Sed tincidunt suscipit tempus. Aliquam pellentesque venenatis purus nec eleifend. Proin eu elementum odio, eget molestie lectus.
Praesent auctor est quis neque eleifend vehicula. Quisque orci tellus, cursus a felis vitae, laoreet elementum ex. Nunc ut orci non tellus auctor finibus. Mauris blandit, mauris vitae commodo porta, leo eros porttitor mi, facilisis euismod dui nibh ac libero. Donec fermentum magna non finibus fringilla. Phasellus venenatis vulputate massa, eget fringilla urna. Vestibulum et facilisis odio, eget aliquam tortor. Aenean eget lacinia erat. Aenean sodales, turpis eget molestie pellentesque, erat dolor tristique nunc, vel convallis neque mi nec dui. Cras elementum gravida eros, ac dictum augue porta vitae. Proin eu mattis felis. Curabitur sodales placerat justo, a posuere risus commodo vitae. Maecenas eget blandit sem, sit amet imperdiet mauris. Pellentesque eu volutpat odio, vitae hendrerit leo.
Sed et massa vitae ligula convallis condimentum sit amet quis tortor. Nunc at urna fringilla, dignissim quam et, elementum mauris. Pellentesque eget ornare orci. Aenean feugiat elit ut purus dapibus aliquet. Donec in interdum justo. Curabitur id lacus leo. Suspendisse ut convallis quam. Pellentesque eu justo sapien. Donec tristique quam eget mi maximus vestibulum. Interdum et malesuada fames ac ante ipsum primis in faucibus. Fusce pellentesque commodo nisi sit amet tincidunt. Etiam suscipit magna at mollis consequat. In tristique faucibus orci id laoreet.
Nulla quis enim quis felis vestibulum egestas eu sit amet leo. Duis a fermentum ex. Vestibulum nec sollicitudin mauris, non blandit nisl. Praesent sem odio, rhoncus ac venenatis quis, dictum in diam. Aenean pulvinar nunc quis laoreet faucibus. Mauris tincidunt metus molestie lectus eleifend, eget porttitor libero mattis. Nullam ut ornare ex.
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam ullamcorper elit sem, non elementum arcu hendrerit at. Proin pharetra quam augue, ac laoreet orci varius non. Praesent consectetur mattis sollicitudin. In eget placerat dui. Sed sed arcu justo. Duis tempor vitae diam non ultricies. Aliquam dolor lorem, molestie id ante et, mattis pharetra sem.
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin a lacinia orci, ut porttitor nunc. Nullam turpis augue, dignissim ac porttitor a, iaculis nec sem. Interdum et malesuada fames ac ante ipsum primis in faucibus. Aenean congue augue ligula, vel maximus velit porttitor vitae. Donec ultrices luctus tortor nec gravida. Sed id congue urna, sit amet sollicitudin urna. Praesent tincidunt gravida tincidunt. Sed vitae dignissim arcu. Ut at ultricies justo. Phasellus porta vulputate ipsum. Vivamus luctus lorem vitae ullamcorper lacinia. Mauris vitae nunc condimentum, molestie mauris a, porta ante. Donec scelerisque semper enim, ut feugiat diam gravida a.
  STRING

  def create_john
    User.create! email: "john.doe@example.net", password: "password", first_name: "John", last_name: "Doe", is_admin: false
  end

  def create_articles count
    return if count == 0

    john = create_john
    count.times do |i|
      john.posts.create! title: ARTICLES[i][1,10], content: ARTICLES[i]
    end
  end

  def have_blog_title
    have_selector "h1", text: "JAY'S BLOG"
  end

  def have_articles count
    have_selector "article", count: count
  end

end

World StepHelpers

