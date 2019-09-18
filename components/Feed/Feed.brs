' ********** Copyright 2016 Roku Corp.  All Rights Reserved. ********** 

sub init()
    m.feedList = m.top.findNode("feedList")
'    print m.feedLisr.content[0]
    m.loadingIndicator = m.top.findNode("loadingIndicator")

    m.feedList.observeField("itemSelected", "onItemSelected")
    m.loadingIndicator.opacity = 1.0
    fetch()
end sub

sub fetch()
    m.downloadFeedTask = CreateObject("roSGNode", "FeedDownloader")
    m.downloadFeedTask.observeField("content", "setContent")
    m.downloadFeedTask.control = "RUN"
    m.top.setFocus(true)
end sub

sub setContent()
    m.feedList.content = m.downloadFeedTask.content
    m.loadingIndicator.opacity = 0.0
end sub

sub onItemSelected()
    item = m.downloadFeedTask.content.getChild(m.feedList.itemSelected)
    openYoutube(item)
'    ? "onKeyEvent"
'    handled = false

'    if (press)
'        if (key = "play")
'            handled = true
'            m.videoPlayer.control = "play"
'        end if
'        if (key = "pause")
'            handled = true
'            m.videoPlayer.control = "pause"
'        end if
'        if (key = "OK")
'            handled = true
'            openYoutube(item)
'        end if
'    end if
'    return handled
end sub

sub openYoutube(video)
    ? video
    if (video.hasField("VideoUrl") and video.StreamFormat = "youtube")
        videoid = video.VideoUrl.Replace("https://youtu.be/", "").Replace("https://www.youtube.com/watch?v=", "")
        print "videoId" + videoId
        m.YoutubeLinkOpenerTask = CreateObject("roSGNode", "YoutubeLinkOpener")
        m.YoutubeLinkOpenerTask.setField("videoId", videoId)
        m.YoutubeLinkOpenerTask.observeField("content", "setContent")
        m.YoutubeLinkOpenerTask.control = "RUN"
    end if
end sub
