' ********** Copyright 2016 Roku Corp.  All Rights Reserved. **********

sub init()

    m.feedList = m.top.findNode("feedList")
    m.feedList.setFocus(true)
    m.loadingIndicator = m.top.findNode("loadingIndicator")

    m.feedList.observeField("itemSelected", "onItemSelected")
    m.top.observeField("subReddit", "fetch")
    m.loadingIndicator.opacity = 1.0

    fetch()
end sub

sub fetch()
    if (m.top.subReddit <> "")
        m.downloadFeedTask = CreateObject("roSGNode", "FeedDownloader")
        m.downloadFeedTask.subReddit = m.top.subReddit
        m.downloadFeedTask.observeField("content", "setContent")
        m.downloadFeedTask.control = "RUN"
    end if
end sub

sub setContent()
    m.feedList.content = m.downloadFeedTask.content
    m.loadingIndicator.opacity = 0.0
    m.feedList.jumpToItem = m.top.jumpToItem
end sub

sub onItemSelected()
    print m.top.subReddit
    ' m.global = screen.getGlobalNode()

    ' print m.downloadFeedTask.content.getChild(m.feedList.itemSelected).title
    selectedPost = m.downloadFeedTask.content.getChild(m.feedList.itemSelected)
    m.global.selectedSubReddit = m.top.subReddit
    m.global.SelectedPost = m.feedList.itemSelected
    ' m.global.addFields([selectedSubReddit: m.top.subReddit,
    ' selectedPost: m.feedList.selectedSubReddit])
    mainGroup = m.top.getParent().findNode("mainGroup")
    mainGroup.removeChildIndex(0)
    if (Right(selectedPost.url, 4) = ".jpg") then
        m.ImagePost = mainGroup.createChild("ImagePost")
        m.ImagePost.post = selectedPost
    else
        m.TextPost = mainGroup.createChild("TextPost")
        m.TextPost.post = selectedPost
    end if
    mainGroup.setFocus(true)

    ' item = m.feedList.focusedChild
    ' item.m.videoPlayer.control = "play"
    ' item = m.downloadFeedTask.content.getChild(m.feedList.itemSelected)
    ' openYoutube(item)
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
