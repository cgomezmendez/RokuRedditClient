sub init()
    m.videoView = m.top.findNode("videoView")
    m.top.setFocus(true)
end sub

sub render()
    post = m.top.post
    extension = Right(post.url, 4)
    videoContent = createObject("RoSGNode", "ContentNode")
    if (Left(post.url, Len("https://media.giphy.com/")) = "https://media.giphy.com/") then
        videoId = Mid(post.url, Instr(0, post.url, "media/") + Len("media/"), Instr(0, post.url, "media/") + 7)
        videoContent.url = Substitute("https://i.giphy.com/media/{0}/giphy.mp4", videoId)
    else if (extension = "gifv") then
        videoContent.url = Mid(post.url, 0, Len(post.url) - 5) + ".mp4"
    else if (extension = ".gif")
        videoContent.url = "https://res.cloudinary.com/dn48virqp/image/fetch/f_mp4/" + post.url
    else
        videoContent.url = post.url
    end if
    ? videoContent.url
    videoContent.title = post.title
    videoContent.streamformat = "mp4"

    m.videoView.content = videoContent
    m.videoView.control = "play"
end sub