sub init()
    m.itemcursor = m.top.findNode("itemcursor")
    m.titleLabel = m.top.findNode("titleLabel")
    m.descriptionLabel = m.top.findNode("descriptionLabel")
end sub

sub showContent()
    m.itemContent = m.top.itemContent
    m.titleLabel.text = m.itemContent.title
    m.descriptionLabel.text = m.itemContent.description
end sub

sub showfocus()
    m.itemcursor.opacity = m.top.focusPercent
end sub