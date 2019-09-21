sub init()
    m.imageView = m.top.findNode("imageView")
end sub

sub render()
    post = m.top.post
    m.imageView.uri = "https://api.qrserver.com/v1/create-qr-code/?size=1920x1080&data=" + post.url
    ' m.downloadWebTask = CreateObject("roSGNode", "WebFetcher")
    ' m.downloadWebTask.url = post.url
    ' m.downloadWebTask.observeField("content", "setContent")
    ' m.downloadWebTask.control = "RUN"
    ' m.textLabel.content = "http://api.screenshotlayer.com/api/capture?access_key=3b4d756c47a7a1ed14f655fbe1f7f023&url=" + post.url + "&viewport=1920x1080&width=1080"
end sub

sub setContent()
    ' ? m.downloadWebTask.content
    ' m.textLabel.text = m.downloadWebTask.content.text
    ' m.textLabel.setFocus(true)
end sub