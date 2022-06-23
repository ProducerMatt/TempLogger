local function WriteForm(url)
   Write([[<!doctype html>
     <title>temperature sensor tracker</title>
     <style>
       body { padding: 1em; }
       h1 a { color: inherit; text-decoration: none; }
       h1 img { border: none; vertical-align: middle; }
       input { margin: 1em; padding: .5em; }
       pre { margin-left: 2em; }
       p { word-break: break-word; max-width: 650px; }
       dt { font-weight: bold; }
       dd { margin-top: 1em; margin-bottom: 1em; }
       .hdr { text-indent: -1em; padding-left: 1em; }
     </style>
     <h1>
       <a href="/"><img src="/redbean.png"></a>
       <a href="index.lua">temperature sensor tracker</a>
     </h1>
     <form action="index.lua" method="post"
         autocomplete="off">
       <input type="text" id="url" name="url" size="70"
              value="%s" placeholder="uri" autofocus>
       <input type="submit" value="fetch">
       <input type="hidden" name="fetchclicked" value="true">
     </form>
     <form action="index.lua" method="post"
         autocomplete="off">
       <input type="submit" value="append">
       <input type="hidden" name="appendclicked" value="true">
     </form>
   ]] % {EscapeHtml(url)})
end

local function main()
   local DefaultTarget = "tempdump.lua"
   if IsPublicIp(GetClientAddr()) then
      ServeError(403)
   elseif GetMethod() == 'GET' or GetMethod() == 'HEAD' then
      WriteForm(DefaultTarget)
   elseif GetMethod() == 'POST' then
      if GetParam('appendclicked') then
         WriteForm(DefaultTarget)
         Write('<dl>\r\n')
         Write('<dt>DEBUG\r\n')
         Write(tostring(EncodeJson(GetParams())))
      elseif GetParam('fetchclicked') then
         status, headers, payload = Fetch(GetParam('url'))
         WriteForm(GetParam('url'))
         Write('<dl>\r\n')
         Write('<dt>Status\r\n')
         Write('<dd><p>%d %s\r\n' % {status, GetHttpReason(status)})
         Write('<dt>Headers\r\n')
         Write('<dd>\r\n')
         for k,v in pairs(headers) do
            Write('<div class="hdr"><strong>')
            Write(EscapeHtml(k))
            Write('</strong>: ')
            Write(EscapeHtml(v))
            Write('</div>\r\n')
         end
         Write('<dt>Payload\r\n')
         Write('<dd><pre>')
         Write(EscapeHtml(VisualizeControlCodes(payload)))
         Write('</pre>\r\n')
         Write('</dl>\r\n')
      end
   else
      ServeError(405)
      SetHeader('Allow', 'GET, HEAD, POST')
   end
end

main()
