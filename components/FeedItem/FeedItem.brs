' ********** Copyright 2016 Roku Corp.  All Rights Reserved. **********

sub init()
    m.itemcursor = m.top.findNode("itemcursor")
    m.titleLabel = m.top.findNode("titleLabel")
    m.contentLabel = m.top.findNode("contentLabel")
    m.thumbnail = m.top.findNode("thumbnail")
    m.videoPlayer = m.top.findNode("videoPlayer")
    m.loadingIndicator = m.top.findNode("loadingIndicator")
    m.isYoutubeVideo = false
    m.thumbnail.observeField("loadStatus", "onImageStateChange")
    m.videoPlayer.observeField("state", "onVideoPlayerStateChange")
end sub

sub showContent():
    setupVideo()
    itemContent = m.top.itemContent
    m.titleLabel.text = itemContent.title
    m.contentLabel.text = itemContent.description
    if (m.thumbnail.uri = itemContent.SDPosterUrl)
        return
    end if
    if (itemContent.hasField("SDPosterUrl") and itemContent.SDPosterUrl <> invalid and itemContent.SDPosterUrl <> "" and (not itemContent.hasField("VideoUrl") or not m.top.itemContent.Streamformat = "hls"))
        print itemContent.SDPosterUrl
        ' m.loadingIndicator.opacity = 1
        m.thumbnail.uri = itemContent.SDPosterUrl
    else
        m.loadingIndicator.opacity = 0
    end if
    if (itemContent.hasField("VideoUrl"))
        setupVideo()
    end if
    updateLayout()
end sub

sub setupVideo():
    if (m.top.itemContent.Streamformat = "hls")
        videoContent = CreateObject("RoSGNode", "ContentNode")
        videoContent.url = m.top.itemContent.VideoUrl
        videoContent.streamformat = "hls"
        m.video = m.top.findNode("videoPlayer")
        m.video.content = videoContent
        '    m.video.control = "play"
    else
        m.isYoutubeVideo = true
    end if
end sub

sub showFocus():
    itemContent = m.top.itemContent
    print itemContent.videoUrl
    if (itemContent.hasField("VideoUrl") and itemContent.videoUrl <> "" and itemContent.streamFormat = "hls")
        if (m.top.focusPercent = 1)
            m.video.setFocus(true)
            m.video.control = "play"
        else
            m.video.control = "stop"
        end if
    end if
    '    m.top.setFocus(true)
    '    m.itemcursor.opacity = m.top.focusPercent
end sub

sub updateLayout():
    itemContent = m.top.itemContent
    if (itemContent.hasField("VideoUrl") and itemContent.videoUrl <> "" and itemContent.streamFormat = "hls")
        m.videoPlayer.opacity = 1
        m.thumbnail.opacity = 0
    else
        m.videoPlayer.opacity = 0
        m.thumbnail.opacity = 1
    end if
    textHeight = m.titleLabel.boundingRect().height + m.contentLabel.boundingRect().height
    ' if (not m.top.itemContent.hasField("SDPosterUrl"))
    '     contentLabelTranslation += m.thumbnail.boundingRect().height
    ' end if
    m.videoPlayer.height = 1040 - textHeight
    m.thumbnail.height = 1040 - textHeight
    ' m.contentLabel.translation = [0, contentLabelTranslation + 20]
    ' m.thumbnail.translation = [0, m.titleLabel.boundingRect().height + 20]
    ' m.videoPlayer.translation = [0, m.titleLabel.boundingRect().height + 20]
end sub

sub onImageStateChange(event as object)
    print "loadStatusChange" + event.getData()
    if (event.getData() = "ready")
        m.loadingIndicator.opacity = 0
    end if
    if (event.getData() = "loading")
        m.loadingIndicator.opacity = 0
    end if
end sub

sub onVideoPlayerStateChange(event as object)
    if (event.getData() = "buffering")
        m.loadingIndicator.opacity = 1
    else
        m.loadingIndicator.opacity = 0
    end if
end sub
