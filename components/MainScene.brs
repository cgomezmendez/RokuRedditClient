sub init()
    m.global.addFields({ selectedSubReddit: "", selectedPost: -1 })
    ' m.global.addField("player", "node", false)
    ' m.global.player = createObject("RoSGNode", "Video")
    ' m.global.player.id = "player"
    ' m.global.player.loop = "true"
    m.mainGroup = m.top.findNode("mainGroup")
end sub

sub reset()
    print m.global
    if (m.global.selectedSubReddit <> "") then
        m.mainGroup.removeChildIndex(0)
        m.Feed = m.mainGroup.createChild("Feed")
        m.Feed.jumpToItem = m.global.selectedPost
        m.Feed.subReddit = m.global.selectedSubReddit
        m.global.selectedSubReddit = ""
        m.global.selectedPost = -1
    else
        m.mainGroup.removeChildIndex(0)
        m.mainGroup.createChild("SubsList")
    end if
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    handled = false
    if press then
        if (key = "back") then
            handled = true
            reset()
        end if
    end if
    return handled
end function
