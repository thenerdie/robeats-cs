local SPList = require(game.ReplicatedStorage.Shared.SPList)
local EnqueueFn = {}

function EnqueueFn:new()
  local self = {}
  local _enqueued = SPList:new()

  function self:enqueue_function(fn, delay)
    if delay == nil then
      delay = 0
    end
    _enqueued:push_back({
      Fn = fn;
      Delay = delay;
    })
  end

  function self:update(dt_scale)
    for i=_enqueued:count(),1,-1 do
      local itr = _enqueued:get(i)
      itr.Delay = itr.Delay - dt_scale
      if itr.Delay <= 0 then
        itr.Fn()
        _enqueued:remove_at(i)
      end
    end
  end

  return self
end

return EnqueueFn
