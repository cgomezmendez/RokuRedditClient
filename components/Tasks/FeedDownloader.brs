sub init()
    m.top.functionName = "fetch"
end sub

sub fetch()
    listContent = CreateObject("RoSGNode", "FeedContent")
    request = CreateObject("roUrlTransfer")
    port = CreateObject("roMessagePort")
    request.SetMessagePort(port)
    request.SetCertificatesFile("common:/certs/ca-bundle.crt") ' or another appropriate certificate
    request.InitClientCertificates()
    request.SetUrl("https://www.reddit.com" + m.top.subReddit + "/.json")
    response = request.GetToString()
    json = ParseJson(response)
    feed = CreateObject("roArray", 26, true)
    for each postDataContainer in json.data.children
        postData = postDataContainer.data
        post = {
            title: postData.title,
            selfText: postData.selfText,
            thumbnail: postData.thumbnail,
            isVideo: postData.is_video,
            url: postData.url,
            isSelf: postData.isSelf
        }
        itemContent = listContent.createChild("FeedContent")
        itemContent.isSelf = post.isSelf
        itemContent.setField("title", post.title)
        itemContent.setField("description", post.selfText)
        if (post.thumbnail <> "self" and post.thumbnail <> "default" and post.thumbnail <> "image")
            itemContent.SDPosterUrl = post.thumbnail
        end if
        if (post.isVideo)
            itemContent.videoUrl = postData.secure_media.reddit_video.hls_url
            itemContent.streamformat = "hls"
        end if
        if (postData.media <> invalid and postData.media.type = "youtube.com")
            itemContent.videoUrl = postData.url
            itemContent.streamFormat = "youtube"
        end if
        extension = right(postData.url, 4)
        if (extension = ".png" or extension = ".jpg")
            itemContent.SDPosterUrl = postData.url
        end if
        if (postData.media <> invalid and postData.media.reddit_video <> invalid)
            itemContent.isRedditVideo = true
        else
            itemContent.isRedditVideo = false
        end if
        itemContent.url = post.url
    end for
    m.top.content = listContent
end sub