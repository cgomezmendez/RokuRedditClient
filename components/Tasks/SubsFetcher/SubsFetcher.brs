sub init()
    m.top.functionName = "fetchSubs"
end sub

sub fetchSubs()
    listContent = CreateObject("RoSGNode", "SubsContent")
    request = CreateObject("roUrlTransfer")
    port = CreateObject("roMessagePort")
    request.SetMessagePort(port)
    request.SetCertificatesFile("common:/certs/ca-bundle.crt") ' or another appropriate certificate
    request.InitClientCertificates()
    request.SetUrl("https://www.reddit.com/subreddits/.json")
    response = request.GetToString()
    json = ParseJson(response)
    feed = CreateObject("roArray", 10, true)
    for each postData in json.data.children
        subReddit = {
            title: postData.data.title,
            description: postData.data.public_description,
            icon: postData.data.icon_img,
            url: postData.data.url
        }
        itemContent = listContent.createChild("SubsContent")
        itemContent.title = subReddit.title
        itemContent.description = subReddit.description
        itemContent.url = subReddit.url
        if (subReddit.icon <> invalid)
            itemContent.icon = subReddit.icon
        end if
    end for
    m.top.content = listContent
end sub