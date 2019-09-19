sub init()
    m.subsList = m.top.findNode("subsList")
    m.subsList.observeField("itemSelected", "onItemSelected")
    fetch()
end sub

sub fetch()
    m.downloadSubsTask = CreateObject("roSGNode", "SubsFetcher")
    m.downloadSubsTask.observeField("content", "setContent")
    m.downloadSubsTask.control = "RUN"
    m.top.setFocus(true)
end sub

sub setContent()
    m.subsList.content = m.downloadSubsTask.content
end sub

sub onItemSelected()
    selectedSub = m.subsList.content.getChild(m.subsList.itemSelected)
    mainGroup = m.top.getParent().findNode("mainGroup")
    mainGroup.removeChildIndex(0)
    m.Feed = mainGroup.createChild("Feed")
    m.Feed.subReddit = selectedSub.url
end sub