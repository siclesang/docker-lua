

dependent on lua-curl



-----------------------------------------------------------
-- a new dockerd node
-- function new ; parameter: host , port  default 127.0.0.1 2375
-----------------------------------------------------------
--get images list . 
--function imagesList ; parameter:null
-----------------------------------------------------------
--inspect a image info. 
--function imageInspect ; parameter:imagename
----------------------------------------------------------
--inspect  history info of a image.
--function imageHistoryInfo ; parameter:imagename
----------------------------------------------------------
--start a container
--function containerStart ; parameter: containerid
----------------------------------------------------------
--stop a container
--function containerStop ; parameter: containerid
----------------------------------------------------------
--delete a container
--function containerDelete ; parameter: containerid
----------------------------------------------------------
--network list
--function networkList  ; parameter: null
----------------------------------------------------------
--get a network info  
--function networkInfo  ; parameter: networkname
----------------------------------------------------------
--delete a network
--function networkDel ;parameter: networkname
