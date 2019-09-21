sub init()
    m.imageView = m.top.findNode("imageView")
end sub

sub render()
    post = m.top.post
    m.imageView.uri = post.url
end sub