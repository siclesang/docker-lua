local _M={}
----------------------------------------------------------
--
--
--
--dependent on lua-curl
--
--
--
----------------------------------------------------------

_M.host="127.0.0.1"
_M.port="2375"


-----------------------------------------------------------
-- a new dockerd node
-- function new ; parameter: host , port  default 127.0.0.1 2375
function _M.new(host,port)
	_M.host=host
	_M.port=port
end

-----------------------------------------------------------
--get images list . 
--function imagesList ; parameter:null
function _M.imagesList()
	local domain=_M.host..":".._M.port
	local method="GET"
	local interface="/images/json"

	return _M.run(domain..interface,method)
end


-----------------------------------------------------------
--inspect a image info. 
--function imageInspect ; parameter:imagename
function _M.imageInspect(imgname)
	local domain=_M.host..":".._M.port
	local method="GET"
	local interface="/images/"..imgname.."/json"

	return _M.run(domain..interface,method)
end


----------------------------------------------------------
--inspect  history info of a image.
--function imageHistoryInfo ; parameter:imagename
function _M.imageHistoryInfo(imgname)
	local domain=_M.host..":".._M.port
	local method="GET"
	local interface="/images/"..imgname.."/history"

	return _M.run(domain..interface,method)
end


----------------------------------------------------------
--create a image
--function imageCreate  ; parameter: imagename,tar file(contain a Dockerfile being in the . dir path of  tar file)
function _M.imageCreate(imgname,tar)
        local domain=_M.host..":".._M.port
        local method="POST"
        local interface="/build?t="..imgname
	local header={"Content-type:application/tar;charset=UTF-8"}
        local f=io.open(tar,"rb")
        local data= f:read("*a")
        io.close(f)
        return _M.run(domain..interface,method,data,header)

end

----------------------------------------------------------
--start a container
--function containerStart ; parameter: containerid
function _M.containerStart(cid)
        local domain=_M.host..":".._M.port
        local method="POST" 
        local interface="/containers/"..cid.."/start"

        return _M.run(domain..interface,method)
end 


----------------------------------------------------------
--stop a container
--function containerStop ; parameter: containerid
function _M.containerStop(cid)
        local domain=_M.host..":".._M.port
        local method="POST" 
        local interface="/containers/"..cid.."/stop"

        return _M.run(domain..interface,method)
end 


----------------------------------------------------------
--delete a container
--function containerDelete ; parameter: containerid
function _M.containerDel(cid)
        local domain=_M.host..":".._M.port
        local method="DELETE" 
        local interface="/containers/"..cid

        return _M.run(domain..interface,method)
end 


----------------------------------------------------------
--network list
--function networkList  ; parameter: null
function _M.networkList()
        local domain=_M.host..":".._M.port
        local method="GET"
        local interface="/networks"

        return _M.run(domain..interface,method)

end


----------------------------------------------------------
--get a network info  
--function networkInfo  ; parameter: networkname
function _M.networkInfo(nname)
        local domain=_M.host..":".._M.port
        local method="GET"
        local interface="/networks/"..nname

        return _M.run(domain..interface,method)

end



----------------------------------------------------------
--delete a network
--function networkDel ;parameter: networkname
function _M.networkDel(nname)
        local domain=_M.host..":".._M.port
        local method="DELETE"
        local interface="/networks/"..nname

        return _M.run(domain..interface,method)

end


function _M.run(url,method,data,header)
	local curl = require "lcurl"
        local result=nil

	if header == nil then
		header={"Content-type:application/json;charset=UTF-8"}
	end
        local c=curl.easy()
        c:setopt{
                -- xxx = curl.OPT_XXX
                [curl.OPT_URL] =url,
		[curl.OPT_CUSTOMREQUEST] =method,
                httpheader = header,
                writefunction = function(str) result=(result or '')..str end,
		readfunction = function () return data or nil  end,
                connecttimeout = 3,
                ssl_verifyhost=0,
                ssl_verifypeer=0,
                --verbose = true
         }
        if data then
                c:setopt_postfields (data)
        end
        c:perform()
        c:close()
	--print(result)
        return result
end

return _M
