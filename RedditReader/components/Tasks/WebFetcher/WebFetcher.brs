sub init()
    m.top.functionName = "fetch"
end sub

sub fetch()
    listContent = CreateObject("RoSGNode", "WebPostContent")
    request = CreateObject("roUrlTransfer")
    port = CreateObject("roMessagePort")
    request.SetMessagePort(port)
    request.SetCertificatesFile("common:/certs/ca-bundle.crt") ' or another appropriate certificate
    request.InitClientCertificates()
    request.SetUrl("https://www.textise.net/showText.aspx?strURL=" + m.top.url)
    response = request.GetToString()
    regex = createObject("roRegex", "<[^<]+?>", "i")
    response = Mid(response, Instr(1, response, "<body>"))
    response = Left(response, Instr(response, "</body>"))
    response = Mid(response, Instr(1, response, "<div>"))
    listContent.text = response
    m.top.content = listContent
end sub