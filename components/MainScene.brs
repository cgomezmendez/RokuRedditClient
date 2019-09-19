sub init()
    m.mainGroup = m.top.findNode("mainGroup")
end sub

sub reset()
    m.mainGroup.removeChildIndex(0)
    m.mainGroup.createChild("SubsList")
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
