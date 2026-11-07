-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Packages.ForgeVFX.pkg.Promise
-- Class: ModuleScript
-- bytes: 49123

local _ = function(arg1) --[[ isCallable ]] -- line: 34
    if type(arg1) == "function" then
        return true
    end

    if type(arg1) == "table" then
        local v1 = getmetatable(arg1)

        if v1 then
            if type((rawget(v1, "__call"))) == "function" then
                return true
            end
        end
    end

    return false
end

local function makeEnum(arg2, arg3) -- line: 52
    local t = {}

    for _, val in ipairs(arg3) do
        t[val] = val
    end

    local t_1 = { __index = nil, __newindex = nil }

    function t_1.__index(_, arg5) -- line: 60
        -- upvalues:
        --  [1] arg2 (copy)

        error(string.format("%s is not in %s!", arg5, arg2), 2)
    end

    function t_1.__newindex() -- line: 63
        -- upvalues:
        --  [1] arg2 (copy)

        error(string.format("Creating new members in %s is not allowed!", arg2), 2)
    end

    return (setmetatable(t, t_1))
end

local t_3 = { __mode = "k" }
local t_27 = {
    Kind = makeEnum(
        "Promise.Error.Kind",
        { "ExecutionError", "AlreadyCancelled", "NotResolvedInTime", "TimedOut" }
    )
}
t_27.__index = t_27

function t_27.new(arg6, arg7) -- line: 88
    -- upvalues:
    --  [1] t_27 (ref)

    arg6 = arg6 or {}

    return (setmetatable(
        {
            error = tostring(arg6.error) or "[This error has no error text.]",
            trace = arg6.trace,
            context = arg6.context,
            kind = arg6.kind,
            parent = arg7,
            createdTick = os.clock(),
            createdTrace = debug.traceback()
        },
        t_27
    ))
end

function t_27.is(arg8) -- line: 101
    if type(arg8) == "table" then
        local v6 = getmetatable(arg8)

        if type(v6) == "table" then
            local v7 = false

            if rawget(arg8, "error") ~= nil then
                v7 = if type((rawget(v6, "extend"))) ~= "function" then false else true
            end

            return v7
        end
    end

    return false
end

function t_27.isKind(arg9, arg10) -- line: 113
    -- upvalues:
    --  [1] t_27 (ref)

    assert(arg10 ~= nil, "Argument #2 to Promise.Error.isKind must not be nil")
    local v10 = t_27.is(arg9)

    if v10 then
        v10 = arg9.kind == arg10
    end

    return v10
end

function t_27.extend(arg11, arg12) -- line: 119
    -- upvalues:
    --  [1] t_27 (ref)

    local v11 = arg12 or {}
    arg12 = v11
    v11 = arg12.kind or arg11.kind
    arg12.kind = v11

    return t_27.new(arg12, arg11)
end

function t_27.getErrorChain(arg13) -- line: 127
    local t_5 = { arg13 }

    while true do
        if not t_5[#t_5].parent then
            break
        end

        table.insert(t_5, t_5[#t_5].parent)
    end

    return t_5
end

function t_27.__tostring(arg14) -- line: 137
    local t_6 = { string.format("-- Promise.Error(%s) --", arg14.kind or "?") }

    for _, val_1 in ipairs(arg14:getErrorChain()) do
        local v13 = val_1.trace or val_1.error
        table.insert(t_6, table.concat({ v13, val_1.context }, "\n"))
    end

    return table.concat(t_6, "\n")
end

local function pack(...) -- line: 161
    return select("#", ...), { ... }
end

local function packResult(arg15, ...) -- line: 168
    return arg15, select("#", ...), { ... }
end

local _ = function(arg16) --[[ makeErrorHandler ]] -- line: 172
    -- upvalues:
    --  [1] t_27 (ref)

    assert(arg16 ~= nil, "traceback is nil")

    return function(arg17) -- line: 175
        -- upvalues:
        --  [1] t_27 (ref)
        --  [2] arg16 (copy)

        if type(arg17) == "table" then
            return arg17
        end

        local t_7 = { error = arg17, kind = t_27.Kind.ExecutionError, trace = nil, context = nil }
        local New = t_27.new
        t_7.trace = debug.traceback(tostring(arg17), 2)
        t_7.context = "Promise created at:\n\n" .. arg16

        return New(t_7)
    end
end

local function runExecutor(arg18, arg19, ...) -- line: 195
    -- upvalues:
    --  [1] packResult (copy)
    --  [2] t_27 (ref)

    local v17 = packResult
    assert(if arg18 == nil then false else true, "traceback is nil")

    return v17(xpcall(arg19, function(arg20) -- line: 175
        -- upvalues:
        --  [1] t_27 (ref)
        --  [2] arg18 (copy)

        if type(arg20) == "table" then
            return arg20
        end

        local t_8 = { error = arg20, kind = t_27.Kind.ExecutionError, trace = nil, context = nil }
        local New_1 = t_27.new
        t_8.trace = debug.traceback(tostring(arg20), 2)
        t_8.context = "Promise created at:\n\n" .. arg18

        return New_1(t_8)
    end, ...))
end

local _ = function(arg21, arg22, arg23, arg24) --[[ createAdvancer ]] -- line: 203
    -- upvalues:
    --  [1] runExecutor (copy)

    return function(...) -- line: 204
        -- upvalues:
        --  [1] runExecutor (ref)
        --  [2] arg21 (copy)
        --  [3] arg22 (copy)
        --  [4] arg23 (copy)
        --  [5] arg24 (copy)

        local v19, v20, v21 = runExecutor(arg21, arg22, ...)

        if v19 then
            arg23(unpack(v21, 1, v20))

            return
        end

        arg24(v21[1])
    end
end

local _ = function(arg25) --[[ isEmpty ]] -- line: 215
    return next(arg25) == nil
end

local t_9 = {
    Error = t_27,
    Status = makeEnum("Promise.Status", { "Started", "Resolved", "Rejected", "Cancelled" }),
    _getTime = os.clock,
    _timeEvent = game:GetService("RunService").Heartbeat,
    _unhandledRejectionCallbacks = {},
    prototype = {}
}
t_9.__index = t_9.prototype

function t_9._new(arg26, arg27, arg28) -- line: 254
    -- upvalues:
    --  [1] t_9 (copy)
    --  [2] t_3 (copy)
    --  [3] runExecutor (copy)

    if arg28 ~= nil and not t_9.is(arg28) then
        error("Argument #2 to Promise.new must be a promise or nil", 2)
    end

    local t_10 = {
        _thread = nil,
        _source = arg26,
        _status = t_9.Status.Started,
        _values = nil,
        _valuesLength = -1,
        _unhandledRejection = true,
        _queuedResolve = {},
        _queuedReject = {},
        _queuedFinally = {},
        _cancellationHook = nil,
        _parent = arg28,
        _consumers = setmetatable({}, t_3)
    }

    if arg28 and arg28._status == t_9.Status.Started then
        arg28._consumers[t_10] = true
    end

    setmetatable(t_10, t_9)

    local function resolve(...) -- line: 302
        -- upvalues:
        --  [1] t_10 (copy)

        t_10:_resolve(...)
    end

    local function reject(...) -- line: 306
        -- upvalues:
        --  [1] t_10 (copy)

        t_10:_reject(...)
    end

    local function onCancel(arg29) -- line: 310
        -- upvalues:
        --  [1] t_10 (copy)
        --  [2] t_9 (ref)

        if arg29 then
            if t_10._status == t_9.Status.Cancelled then
                arg29()
            else
                t_10._cancellationHook = arg29
            end
        end

        return t_10._status == t_9.Status.Cancelled
    end

    t_10._thread = coroutine.create(function() -- line: 322
        -- upvalues:
        --  [1] runExecutor (ref)
        --  [2] t_10 (copy)
        --  [3] arg27 (copy)
        --  [4] resolve (copy)
        --  [5] reject (copy)
        --  [6] onCancel (copy)

        local v25, _, v27 = runExecutor(
            t_10._source,
            arg27,
            resolve,
            reject,
            onCancel
        )

        if not v25 then
            reject(v27[1])
        end
    end)
    task.spawn(t_10._thread)

    return t_10
end

function t_9.new(arg30) -- line: 373
    -- upvalues:
    --  [1] t_9 (copy)

    return t_9._new(debug.traceback(nil, 2), arg30)
end

function t_9.__tostring(arg31) -- line: 377
    return string.format("Promise(%s)", arg31._status)
end

function t_9.defer(arg32) -- line: 399
    -- upvalues:
    --  [1] t_9 (copy)
    --  [2] runExecutor (copy)

    local v28 = debug.traceback(nil, 2)

    return (t_9._new(v28, function(arg33, arg34, arg35) -- line: 402
        -- upvalues:
        --  [1] runExecutor (ref)
        --  [2] v28 (copy)
        --  [3] arg32 (copy)

        task.defer(function() -- line: 403
            -- upvalues:
            --  [1] runExecutor (ref)
            --  [2] v28 (ref)
            --  [3] arg32 (ref)
            --  [4] arg33 (copy)
            --  [5] arg34 (copy)
            --  [6] arg35 (copy)

            local v29, _, v31 = runExecutor(
                v28,
                arg32,
                arg33,
                arg34,
                arg35
            )

            if not v29 then
                arg34(v31[1])
            end
        end)
    end))
end

t_9.async = t_9.defer

function t_9.resolve(...) -- line: 440
    -- upvalues:
    --  [1] pack (copy)
    --  [2] t_9 (copy)

    local v32, v33 = pack(...)

    return t_9._new(debug.traceback(nil, 2), function(arg36) -- line: 442
        -- upvalues:
        --  [1] v33 (copy)
        --  [2] v32 (copy)

        arg36(unpack(v33, 1, v32))
    end)
end

function t_9.reject(...) -- line: 457
    -- upvalues:
    --  [1] pack (copy)
    --  [2] t_9 (copy)

    local v35, v36 = pack(...)

    return t_9._new(debug.traceback(nil, 2), function(_, arg38) -- line: 459
        -- upvalues:
        --  [1] v36 (copy)
        --  [2] v35 (copy)

        arg38(unpack(v36, 1, v35))
    end)
end

function t_9._try(arg39, arg40, ...) -- line: 468
    -- upvalues:
    --  [1] pack (copy)
    --  [2] t_9 (copy)

    local v38, v39 = pack(...)

    return t_9._new(arg39, function(arg41) -- line: 471
        -- upvalues:
        --  [1] arg40 (copy)
        --  [2] v39 (copy)
        --  [3] v38 (copy)

        arg41(arg40(unpack(v39, 1, v38)))
    end)
end

function t_9.try(arg42, ...) -- line: 499
    -- upvalues:
    --  [1] t_9 (copy)

    return t_9._try(debug.traceback(nil, 2), arg42, ...)
end

function t_9._all(arg43, arg44, arg45) -- line: 508
    -- upvalues:
    --  [1] t_9 (copy)

    if type(arg44) ~= "table" then
        error(string.format("Please pass a list of promises to %s", "Promise.all"), 3)
    end

    for key_2, val_2 in pairs(arg44) do
        if not t_9.is(val_2) then
            error(
                string.format(
                    "Non-promise value passed into %s at index %s",
                    "Promise.all",
                    (tostring(key_2))
                ),
                3
            )
        end
    end

    if #arg44 == 0 or arg45 == 0 then
        return t_9.resolve({})
    end

    return t_9._new(arg43, function(arg46, arg47, arg48) -- line: 526
        -- upvalues:
        --  [1] arg45 (copy)
        --  [2] arg44 (copy)

        local t_11 = {}
        local v42 = 0
        local v43 = 0
        local v44 = false

        local function cancel() -- line: 537
            -- upvalues:
            --  [1] t_11 (copy)

            for _, val_3 in ipairs(t_11) do
                val_3:cancel()
            end
        end

        local t_12 = {}

        local function resolveOne(arg49, ...) -- line: 544
            -- upvalues:
            --  [1] v44 (ref)
            --  [2] v42 (ref)
            --  [3] arg45 (ref)
            --  [4] t_12 (copy)
            --  [5] arg44 (ref)
            --  [6] arg46 (copy)
            --  [7] t_11 (copy)

            if v44 then
                return
            end

            v42 += 1

            if arg45 == nil then
                t_12[arg49] = ...
            else
                t_12[v42] = ...
            end

            if v42 >= (arg45 or #arg44) then
                v44 = true
                arg46(t_12)

                for _, val_4 in ipairs(t_11) do
                    val_4:cancel()
                end
            end
        end

        arg48(cancel)

        for key_5, val_5 in ipairs(arg44) do
            local function v47(...) -- line: 569
                -- upvalues:
                --  [1] resolveOne (copy)
                --  [2] key_5 (copy)

                resolveOne(key_5, ...)
            end

            t_11[key_5] = val_5:andThen(v47, function(...) -- line: 571
                -- upvalues:
                --  [1] v43 (ref)
                --  [2] arg45 (ref)
                --  [3] arg44 (ref)
                --  [4] t_11 (copy)
                --  [5] v44 (ref)
                --  [6] arg47 (copy)

                v43 += 1

                if arg45 == nil or #arg44 - v43 < arg45 then
                    for _, val_6 in ipairs(t_11) do
                        val_6:cancel()
                    end

                    v44 = true
                    arg47(...)
                end
            end)
        end

        if v44 then
            for _, val_7 in ipairs(t_11) do
                val_7:cancel()
            end
        end
    end)
end

function t_9.all(arg50) -- line: 613
    -- upvalues:
    --  [1] t_9 (copy)

    return t_9._all(debug.traceback(nil, 2), arg50)
end

function t_9.fold(arg51, arg52, arg53) -- line: 642
    -- upvalues:
    --  [1] t_9 (copy)

    local v49 = if type(arg51) ~= "table" then false else true
    assert(v49, "Bad argument #1 to Promise.fold: must be a table")

    if type(arg52) == "function" then
        v49 = true
    elseif type(arg52) == "table" then
        local v50 = getmetatable(arg52)

        if v50 then
            v49 = type((rawget(v50, "__call"))) == "function"
        else
            v49 = false
        end
    else
        v49 = false
    end

    assert(v49, "Bad argument #2 to Promise.fold: must be a function")
    local v52 = t_9.resolve(arg53)

    return t_9.each(arg51, function(arg54, arg55) -- line: 647
        -- upvalues:
        --  [1] v52 (ref)
        --  [2] arg52 (copy)

        v52 = v52:andThen(function(arg56) -- line: 648
            -- upvalues:
            --  [1] arg52 (ref)
            --  [2] arg54 (copy)
            --  [3] arg55 (copy)

            return arg52(arg56, arg54, arg55)
        end)
    end):andThen(function() -- line: 651
        -- upvalues:
        --  [1] v52 (ref)

        return v52
    end)
end

function t_9.some(arg57, arg58) -- line: 675
    -- upvalues:
    --  [1] t_9 (copy)

    assert(
        if type(arg58) ~= "number" then false else true,
        "Bad argument #2 to Promise.some: must be a number"
    )

    return t_9._all(debug.traceback(nil, 2), arg57, arg58)
end

function t_9.any(arg59) -- line: 699
    -- upvalues:
    --  [1] t_9 (copy)

    return t_9._all(debug.traceback(nil, 2), arg59, 1):andThen(function(arg60) -- line: 700
        return arg60[1]
    end)
end

function t_9.allSettled(arg61) -- line: 721
    -- upvalues:
    --  [1] t_9 (copy)

    if type(arg61) ~= "table" then
        error(string.format("Please pass a list of promises to %s", "Promise.allSettled"), 2)
    end

    for key_8, val_8 in pairs(arg61) do
        if not t_9.is(val_8) then
            error(
                string.format(
                    "Non-promise value passed into %s at index %s",
                    "Promise.allSettled",
                    (tostring(key_8))
                ),
                2
            )
        end
    end

    if #arg61 == 0 then
        return t_9.resolve({})
    end

    return t_9._new(debug.traceback(nil, 2), function(arg62, _, arg64) -- line: 739
        -- upvalues:
        --  [1] arg61 (copy)

        local t_13 = {}
        local v57 = 0
        local t_14 = {}

        local function resolveOne_1(arg65, ...) --[[ resolveOne ]] -- line: 749
            -- upvalues:
            --  [1] v57 (ref)
            --  [2] t_14 (copy)
            --  [3] arg61 (ref)
            --  [4] arg62 (copy)

            v57 += 1
            t_14[arg65] = ...

            if v57 >= #arg61 then
                arg62(t_14)
            end
        end

        arg64(function() -- line: 759
            -- upvalues:
            --  [1] t_13 (copy)

            for _, val_9 in ipairs(t_13) do
                val_9:cancel()
            end
        end)

        for key_10, val_10 in ipairs(arg61) do
            t_13[key_10] = val_10:finally(function(...) -- line: 768
                -- upvalues:
                --  [1] resolveOne_1 (copy)
                --  [2] key_10 (copy)

                resolveOne_1(key_10, ...)
            end)
        end
    end)
end

function t_9.race(arg66) -- line: 799
    -- upvalues:
    --  [1] t_9 (copy)

    assert(
        if type(arg66) ~= "table" then false else true,
        string.format("Please pass a list of promises to %s", "Promise.race")
    )
    local _ = string.format("Please pass a list of promises to %s", "Promise.race")

    for key_11, val_11 in pairs(arg66) do
        assert(
            t_9.is(val_11),
            string.format(
                "Non-promise value passed into %s at index %s",
                "Promise.race",
                (tostring(key_11))
            )
        )
    end

    return t_9._new(debug.traceback(nil, 2), function(arg67, arg68, arg69) -- line: 806
        -- upvalues:
        --  [1] arg66 (copy)

        local t_15 = {}
        local v62 = false

        local _ = function() --[[ cancel ]] -- line: 810
            -- upvalues:
            --  [1] t_15 (copy)

            for _, val_12 in ipairs(t_15) do
                val_12:cancel()
            end
        end

        local _ = function(arg70) --[[ finalize ]] -- line: 816
            -- upvalues:
            --  [1] t_15 (copy)
            --  [2] v62 (ref)

            return function(...) -- line: 817
                -- upvalues:
                --  [1] t_15 (ref)
                --  [2] v62 (ref)
                --  [3] arg70 (copy)

                for _, val_13 in ipairs(t_15) do
                    val_13:cancel()
                end

                v62 = true

                return arg70(...)
            end
        end

        if arg69(function(...) -- line: 817
            -- upvalues:
            --  [1] t_15 (copy)
            --  [2] v62 (ref)
            --  [3] arg68 (copy)

            for _, val_14 in ipairs(t_15) do
                val_14:cancel()
            end

            v62 = true

            return arg68(...)
        end) then
            return
        end

        for key_15, val_15 in ipairs(arg66) do
            local function v65(...) -- line: 817
                -- upvalues:
                --  [1] t_15 (copy)
                --  [2] v62 (ref)
                --  [3] arg67 (copy)

                for _, val_16 in ipairs(t_15) do
                    val_16:cancel()
                end

                v62 = true

                return arg67(...)
            end

            t_15[key_15] = val_15:andThen(v65, function(...) -- line: 817
                -- upvalues:
                --  [1] t_15 (copy)
                --  [2] v62 (ref)
                --  [3] arg68 (copy)

                for _, val_17 in ipairs(t_15) do
                    val_17:cancel()
                end

                v62 = true

                return arg68(...)
            end)
        end

        if v62 then
            for _, val_18 in ipairs(t_15) do
                val_18:cancel()
            end
        end
    end)
end

function t_9.each(arg71, arg72) -- line: 894
    -- upvalues:
    --  [1] t_9 (copy)
    --  [2] t_27 (ref)

    local v67 = if type(arg71) ~= "table" then false else true
    assert(v67, string.format("Please pass a list of promises to %s", "Promise.each"))

    if type(arg72) == "function" then
        v67 = true
    elseif type(arg72) == "table" then
        local v68 = getmetatable(arg72)

        if v68 then
            v67 = type((rawget(v68, "__call"))) == "function"
        else
            v67 = false
        end
    else
        v67 = false
    end

    assert(v67, string.format("Please pass a handler function to %s!", "Promise.each"))

    return t_9._new(debug.traceback(nil, 2), function(arg73, arg74, arg75) -- line: 898
        -- upvalues:
        --  [1] arg71 (copy)
        --  [2] t_9 (ref)
        --  [3] t_27 (ref)
        --  [4] arg72 (copy)

        local t_16 = {}
        local t_17 = {}
        local v70 = false

        local _ = function() --[[ cancel ]] -- line: 904
            -- upvalues:
            --  [1] t_17 (copy)

            for _, val_19 in ipairs(t_17) do
                val_19:cancel()
            end
        end

        arg75(function() -- line: 910
            -- upvalues:
            --  [1] v70 (ref)
            --  [2] t_17 (copy)

            v70 = true

            for _, val_20 in ipairs(t_17) do
                val_20:cancel()
            end
        end)
        local t_18 = {}

        for key_21, val_21 in ipairs(arg71) do
            if t_9.is(val_21) then
                if val_21:getStatus() == t_9.Status.Cancelled then
                    for _, val_22 in ipairs(t_17) do
                        val_22:cancel()
                    end

                    local t_19 = {
                        error = "Promise is cancelled",
                        kind = t_27.Kind.AlreadyCancelled,
                        context = string.format(
                            "The Promise that was part of the array at index %d passed into Promise.each was already cancelled when Promise.each began.\n\nThat Promise was created at:\n\n%s",
                            key_21,
                            val_21._source
                        )
                    }

                    return arg74(t_27.new(t_19))
                end

                if val_21:getStatus() == t_9.Status.Rejected then
                    for _, val_23 in ipairs(t_17) do
                        val_23:cancel()
                    end

                    return arg74(select(2, val_21:await()))
                end

                local v76 = val_21:andThen(function(...) -- line: 943
                    return ...
                end)
                table.insert(t_17, v76)
                t_18[key_21] = v76
            else
                t_18[key_21] = val_21
            end
        end

        local v83

        for key_24, val_24 in ipairs(t_18) do
            if t_9.is(val_24) then
                local v82 = val_24:await()
                v83 = nil

                if not v82 then
                    for _, val_25 in ipairs(t_17) do
                        val_25:cancel()
                    end

                    return arg74(v83)
                end
            end

            if v70 then
                return
            end

            local v84 = t_9.resolve(arg72(v83, key_24))
            table.insert(t_17, v84)
            local v86, v87 = v84:await()

            if not v86 then
                for _, val_26 in ipairs(t_17) do
                    val_26:cancel()
                end

                return arg74(v87)
            end

            t_16[key_24] = v87
        end

        arg73(t_16)
    end)
end

function t_9.is(arg76) -- line: 993
    -- upvalues:
    --  [1] t_9 (copy)

    if type(arg76) ~= "table" then
        return false
    end

    local v88 = getmetatable(arg76)

    if v88 == t_9 then
        return true
    end

    if v88 == nil then
        local AndThen = arg76.andThen

        if type(AndThen) == "function" then
            return true
        end

        if type(AndThen) == "table" then
            local v89 = getmetatable(AndThen)

            if v89 then
                if type((rawget(v89, "__call"))) == "function" then
                    return true
                end
            end
        end

        return false
    else
        if type(v88) == "table" then
            if type((rawget(v88, "__index"))) == "table" then
                local v93 = rawget(rawget(v88, "__index"), "andThen")
                local v94

                if type(v93) == "function" then
                    v94 = true
                elseif type(v93) == "table" then
                    local v95 = getmetatable(v93)

                    if v95 then
                        v94 = type((rawget(v95, "__call"))) == "function"
                    else
                        v94 = false
                    end
                else
                    v94 = false
                end

                if v94 then
                    return true
                end
            end
        end

        return false
    end
end

function t_9.promisify(arg77) -- line: 1042
    -- upvalues:
    --  [1] t_9 (copy)

    return function(...) -- line: 1043
        -- upvalues:
        --  [1] t_9 (ref)
        --  [2] arg77 (copy)

        return t_9._try(debug.traceback(nil, 2), arg77, ...)
    end
end

function t_9.delay(arg78) -- line: 1066
    -- upvalues:
    --  [1] t_9 (copy)

    assert(
        if type(arg78) ~= "number" then false else true,
        "Bad argument #1 to Promise.delay, must be a number."
    )
    local v99 = t_9._getTime()

    return t_9._new(debug.traceback(nil, 2), function(arg79) -- line: 1069
        -- upvalues:
        --  [1] arg78 (copy)
        --  [2] t_9 (ref)
        --  [3] v99 (copy)

        task.delay(arg78, function() -- line: 1070
            -- upvalues:
            --  [1] arg79 (copy)
            --  [2] t_9 (ref)
            --  [3] v99 (ref)

            arg79(t_9._getTime() - v99)
        end)
    end)
end

function t_9.prototype.timeout(arg80, arg81, arg82) -- line: 1114
    -- upvalues:
    --  [1] t_9 (copy)
    --  [2] t_27 (ref)

    local v102 = debug.traceback(nil, 2)
    local _ = {}

    return t_9.race({
        t_9.delay(arg81):andThen(function() -- line: 1118
            -- upvalues:
            --  [1] t_9 (ref)
            --  [2] arg82 (copy)
            --  [3] t_27 (ref)
            --  [4] arg81 (copy)
            --  [5] v102 (copy)

            local Reject = t_9.reject
            local v104

            if arg82 == nil then
                local t_21 = {
                    kind = t_27.Kind.TimedOut,
                    error = "Timed out",
                    context = string.format(
                        "Timeout of %d seconds exceeded.\n:timeout() called at:\n\n%s",
                        arg81,
                        v102
                    )
                }
                v104 = t_27.new(t_21) or arg82
            else
                v104 = arg82
            end

            return Reject(v104)
        end),
        arg80
    })
end

function t_9.prototype.getStatus(arg83) -- line: 1134
    return arg83._status
end

function t_9.prototype._andThen(arg84, arg85, arg86, arg87) -- line: 1143
    -- upvalues:
    --  [1] t_9 (copy)
    --  [2] runExecutor (copy)

    arg84._unhandledRejection = false

    if arg84._status == t_9.Status.Cancelled then
        local v105 = t_9.new(function() -- line: 1148
        end)
        v105:cancel()

        return v105
    end

    return t_9._new(arg85, function(arg88, arg89, arg90) -- line: 1155
        -- upvalues:
        --  [1] arg86 (copy)
        --  [2] arg85 (copy)
        --  [3] runExecutor (ref)
        --  [4] arg87 (copy)
        --  [5] arg84 (copy)
        --  [6] t_9 (ref)

        local v106 = arg88

        if arg86 then
            local v107 = arg85
            local v108 = arg86

            function v106(...) -- line: 204
                -- upvalues:
                --  [1] runExecutor (ref)
                --  [2] v107 (copy)
                --  [3] v108 (copy)
                --  [4] arg88 (copy)
                --  [5] arg89 (copy)

                local v109, v110, v111 = runExecutor(v107, v108, ...)

                if v109 then
                    arg88(unpack(v111, 1, v110))

                    return
                end

                arg89(v111[1])
            end
        end

        local v113 = arg89

        if arg87 then
            local v114 = arg85
            local v115 = arg87

            function v113(...) -- line: 204
                -- upvalues:
                --  [1] runExecutor (ref)
                --  [2] v114 (copy)
                --  [3] v115 (copy)
                --  [4] arg88 (copy)
                --  [5] arg89 (copy)

                local v116, v117, v118 = runExecutor(v114, v115, ...)

                if v116 then
                    arg88(unpack(v118, 1, v117))

                    return
                end

                arg89(v118[1])
            end
        end

        if arg84._status == t_9.Status.Started then
            table.insert(arg84._queuedResolve, v106)
            table.insert(arg84._queuedReject, v113)
            arg90(function() -- line: 1174
                -- upvalues:
                --  [1] arg84 (ref)
                --  [2] t_9 (ref)
                --  [3] v106 (ref)
                --  [4] v113 (ref)

                if arg84._status == t_9.Status.Started then
                    table.remove(arg84._queuedResolve, table.find(arg84._queuedResolve, v106))
                    table.remove(arg84._queuedReject, table.find(arg84._queuedReject, v113))
                end
            end)
        elseif arg84._status == t_9.Status.Resolved then
            v106(unpack(arg84._values, 1, arg84._valuesLength))
        elseif arg84._status == t_9.Status.Rejected then
            v113(unpack(arg84._values, 1, arg84._valuesLength))
        end
    end, arg84)
end

function t_9.prototype.andThen(arg91, arg92, arg93) -- line: 1213
    local v120 = true

    if arg92 ~= nil then
        if type(arg92) == "function" then
            v120 = true
        elseif type(arg92) == "table" then
            local v121 = getmetatable(arg92)

            if v121 then
                v120 = type((rawget(v121, "__call"))) == "function"
            else
                v120 = false
            end
        else
            v120 = false
        end
    end

    assert(v120, string.format("Please pass a handler function to %s!", "Promise:andThen"))
    v120 = true

    if arg93 ~= nil then
        if type(arg93) == "function" then
            v120 = true
        elseif type(arg93) == "table" then
            local v123 = getmetatable(arg93)

            if v123 then
                v120 = type((rawget(v123, "__call"))) == "function"
            else
                v120 = false
            end
        else
            v120 = false
        end
    end

    assert(v120, string.format("Please pass a handler function to %s!", "Promise:andThen"))

    return arg91:_andThen(debug.traceback(nil, 2), arg92, arg93)
end

function t_9.prototype.catch(arg94, arg95) -- line: 1240
    local v126 = true

    if arg95 ~= nil then
        if type(arg95) == "function" then
            v126 = true
        elseif type(arg95) == "table" then
            local v127 = getmetatable(arg95)

            if v127 then
                v126 = type((rawget(v127, "__call"))) == "function"
            else
                v126 = false
            end
        else
            v126 = false
        end
    end

    assert(v126, string.format("Please pass a handler function to %s!", "Promise:catch"))

    return arg94:_andThen(debug.traceback(nil, 2), nil, arg95)
end

function t_9.prototype.tap(arg96, arg97) -- line: 1261
    -- upvalues:
    --  [1] t_9 (copy)
    --  [2] pack (copy)

    local v130

    if type(arg97) == "function" then
        v130 = true
    elseif type(arg97) == "table" then
        local v131 = getmetatable(arg97)

        if v131 then
            v130 = type((rawget(v131, "__call"))) == "function"
        else
            v130 = false
        end
    else
        v130 = false
    end

    assert(v130, string.format("Please pass a handler function to %s!", "Promise:tap"))

    return arg96:_andThen(debug.traceback(nil, 2), function(...) -- line: 1263
        -- upvalues:
        --  [1] arg97 (copy)
        --  [2] t_9 (ref)
        --  [3] pack (ref)

        local v134 = arg97(...)

        if t_9.is(v134) then
            local v135, v136 = pack(...)

            return v134:andThen(function() -- line: 1268
                -- upvalues:
                --  [1] v136 (copy)
                --  [2] v135 (copy)

                return unpack(v136, 1, v135)
            end)
        end

        return ...
    end)
end

function t_9.prototype.andThenCall(arg98, arg99, ...) -- line: 1296
    -- upvalues:
    --  [1] pack (copy)

    local v137

    if type(arg99) == "function" then
        v137 = true
    elseif type(arg99) == "table" then
        local v138 = getmetatable(arg99)

        if v138 then
            v137 = type((rawget(v138, "__call"))) == "function"
        else
            v137 = false
        end
    else
        v137 = false
    end

    assert(v137, string.format("Please pass a handler function to %s!", "Promise:andThenCall"))
    local v140, v141 = pack(...)

    return arg98:_andThen(debug.traceback(nil, 2), function() -- line: 1299
        -- upvalues:
        --  [1] arg99 (copy)
        --  [2] v141 (copy)
        --  [3] v140 (copy)

        return arg99(unpack(v141, 1, v140))
    end)
end

function t_9.prototype.andThenReturn(arg100, ...) -- line: 1326
    -- upvalues:
    --  [1] pack (copy)

    local v144, v145 = pack(...)

    return arg100:_andThen(debug.traceback(nil, 2), function() -- line: 1328
        -- upvalues:
        --  [1] v145 (copy)
        --  [2] v144 (copy)

        return unpack(v145, 1, v144)
    end)
end

function t_9.prototype.cancel(arg101) -- line: 1344
    -- upvalues:
    --  [1] t_9 (copy)

    if arg101._status ~= t_9.Status.Started then
        return
    end

    arg101._status = t_9.Status.Cancelled

    if arg101._cancellationHook then
        arg101._cancellationHook()
    end

    coroutine.close(arg101._thread)

    if arg101._parent then
        arg101._parent:_consumerCancelled(arg101)
    end

    for key_27, _ in pairs(arg101._consumers) do
        key_27:cancel()
    end

    arg101:_finalize()
end

function t_9.prototype._consumerCancelled(arg102, arg103) -- line: 1372
    -- upvalues:
    --  [1] t_9 (copy)

    if arg102._status ~= t_9.Status.Started then
        return
    end

    arg102._consumers[arg103] = nil

    if next(arg102._consumers) == nil then
        arg102:cancel()
    end
end

function t_9.prototype._finally(arg104, arg105, arg106) -- line: 1388
    -- upvalues:
    --  [1] t_9 (copy)
    --  [2] runExecutor (copy)

    arg104._unhandledRejection = false

    return (t_9._new(arg105, function(arg107, arg108, arg109) -- line: 1391
        -- upvalues:
        --  [1] arg104 (copy)
        --  [2] arg106 (copy)
        --  [3] runExecutor (ref)
        --  [4] arg105 (copy)
        --  [5] t_9 (ref)

        local v147 = nil
        arg109(function() -- line: 1394
            -- upvalues:
            --  [1] arg104 (ref)
            --  [2] v147 (ref)

            arg104:_consumerCancelled(arg104)

            if v147 then
                v147:cancel()
            end
        end)
        local v148 = if arg106 then function(...) -- line: 1407
            -- upvalues:
            --  [1] runExecutor (ref)
            --  [2] arg105 (ref)
            --  [3] arg106 (ref)
            --  [4] arg108 (copy)
            --  [5] t_9 (ref)
            --  [6] v147 (ref)
            --  [7] arg107 (copy)
            --  [8] arg104 (ref)

            local v149, _, v151 = runExecutor(arg105, arg106, ...)
            local v152 = v151[1]

            if not v149 then
                return arg108(v152)
            end

            if t_9.is(v152) then
                v147 = v152
                v152:finally(function(arg110) -- line: 1418
                    -- upvalues:
                    --  [1] t_9 (ref)
                    --  [2] arg107 (ref)
                    --  [3] arg104 (ref)

                    if arg110 ~= t_9.Status.Rejected then
                        arg107(arg104)
                    end
                end):catch(function(...) -- line: 1423
                    -- upvalues:
                    --  [1] arg108 (ref)

                    arg108(...)
                end)

                return
            end

            arg107(arg104)
        end else arg107

        if arg104._status == t_9.Status.Started then
            table.insert(arg104._queuedFinally, v148)
        else
            v148(arg104._status)
        end
    end))
end

function t_9.prototype.finally(arg111, arg112) -- line: 1493
    local v154 = true

    if arg112 ~= nil then
        if type(arg112) == "function" then
            v154 = true
        elseif type(arg112) == "table" then
            local v155 = getmetatable(arg112)

            if v155 then
                v154 = type((rawget(v155, "__call"))) == "function"
            else
                v154 = false
            end
        else
            v154 = false
        end
    end

    assert(v154, string.format("Please pass a handler function to %s!", "Promise:finally"))

    return arg111:_finally(debug.traceback(nil, 2), arg112)
end

function t_9.prototype.finallyCall(arg113, arg114, ...) -- line: 1507
    -- upvalues:
    --  [1] pack (copy)

    local v158

    if type(arg114) == "function" then
        v158 = true
    elseif type(arg114) == "table" then
        local v159 = getmetatable(arg114)

        if v159 then
            v158 = type((rawget(v159, "__call"))) == "function"
        else
            v158 = false
        end
    else
        v158 = false
    end

    assert(v158, string.format("Please pass a handler function to %s!", "Promise:finallyCall"))
    local v161, v162 = pack(...)

    return arg113:_finally(debug.traceback(nil, 2), function() -- line: 1510
        -- upvalues:
        --  [1] arg114 (copy)
        --  [2] v162 (copy)
        --  [3] v161 (copy)

        return arg114(unpack(v162, 1, v161))
    end)
end

function t_9.prototype.finallyReturn(arg115, ...) -- line: 1533
    -- upvalues:
    --  [1] pack (copy)

    local v165, v166 = pack(...)

    return arg115:_finally(debug.traceback(nil, 2), function() -- line: 1535
        -- upvalues:
        --  [1] v166 (copy)
        --  [2] v165 (copy)

        return unpack(v166, 1, v165)
    end)
end

function t_9.prototype.awaitStatus(arg116) -- line: 1547
    -- upvalues:
    --  [1] t_9 (copy)

    arg116._unhandledRejection = false

    if arg116._status == t_9.Status.Started then
        local thread = coroutine.running()
        arg116:finally(function() -- line: 1554
            -- upvalues:
            --  [1] thread (copy)

            task.spawn(thread)
        end):catch(function() -- line: 1560
        end)
        coroutine.yield()
    end

    if arg116._status == t_9.Status.Resolved then
        return arg116._status, unpack(arg116._values, 1, arg116._valuesLength)
    end

    if arg116._status == t_9.Status.Rejected then
        return arg116._status, unpack(arg116._values, 1, arg116._valuesLength)
    end

    return arg116._status
end

local function awaitHelper(arg117, ...) -- line: 1575
    -- upvalues:
    --  [1] t_9 (copy)

    return if arg117 ~= t_9.Status.Resolved then false else true, ...
end

function t_9.prototype.await(arg118) -- line: 1600
    -- upvalues:
    --  [1] awaitHelper (copy)

    return awaitHelper(arg118:awaitStatus())
end

local function expectHelper(arg119, ...) -- line: 1604
    -- upvalues:
    --  [1] t_9 (copy)

    if arg119 ~= t_9.Status.Resolved then
        error(if ... == nil then "Expected Promise rejected with no value." else ..., 3)
    end

    return ...
end

function t_9.prototype.expect(arg120) -- line: 1637
    -- upvalues:
    --  [1] expectHelper (copy)

    return expectHelper(arg120:awaitStatus())
end

t_9.prototype.awaitValue = t_9.prototype.expect

function t_9.prototype._unwrap(arg121) -- line: 1651
    -- upvalues:
    --  [1] t_9 (copy)

    if arg121._status == t_9.Status.Started then
        error("Promise has not resolved or rejected.", 2)
    end

    return arg121._status == t_9.Status.Resolved, unpack(arg121._values, 1, arg121._valuesLength)
end

function t_9.prototype._resolve(arg122, ...) -- line: 1661
    -- upvalues:
    --  [1] t_9 (copy)
    --  [2] t_27 (ref)
    --  [3] pack (copy)

    if arg122._status ~= t_9.Status.Started then
        if t_9.is((...)) then
            (...):_consumerCancelled(arg122)
        end

        return
    end

    if t_9.is((...)) then
        if select("#", ...) > 1 then
            warn(
                (string.format(
                    "When returning a Promise from andThen, extra arguments are discarded! See:\n\n%s",
                    arg122._source
                ))
            )
        end

        local v175 = ...
        local v178 = v175:andThen(function(...) -- line: 1682
            -- upvalues:
            --  [1] arg122 (copy)

            arg122:_resolve(...)
        end, function(...) -- line: 1684
            -- upvalues:
            --  [1] v175 (copy)
            --  [2] t_27 (ref)
            --  [3] arg122 (copy)

            local v176 = if v175._error then t_27.new(
                {
                    error = v175._error,
                    kind = t_27.Kind.ExecutionError,
                    context = "[No stack trace available as this Promise originated from an older version of the Promise library (< v2)]"
                }
            ) else v175._values[1]

            if t_27.isKind(v176, t_27.Kind.ExecutionError) then
                return arg122:_reject(
                    v176:extend(
                        {
                            error = "This Promise was chained to a Promise that errored.",
                            trace = "",
                            context = string.format(
                                "The Promise at:\n\n%s\n...Rejected because it was chained to the following Promise, which encountered an error:\n",
                                arg122._source
                            )
                        }
                    )
                )
            end

            arg122:_reject(...)
        end)

        if v178._status == t_9.Status.Cancelled then
            arg122:cancel()

            return
        end

        if v178._status == t_9.Status.Started then
            arg122._parent = v178
            v178._consumers[arg122] = true
        end

        return
    else
        arg122._status = t_9.Status.Resolved
        arg122._valuesLength, arg122._values = pack(...)

        for _, val_28 in ipairs(arg122._queuedResolve) do
            coroutine.wrap(val_28)(...)
        end

        arg122:_finalize()

        return
    end
end

function t_9.prototype._reject(arg123, ...) -- line: 1732
    -- upvalues:
    --  [1] t_9 (copy)
    --  [2] pack (copy)

    if arg123._status ~= t_9.Status.Started then
        return
    end

    arg123._status = t_9.Status.Rejected
    arg123._valuesLength, arg123._values = pack(...)

    if not (if next(arg123._queuedReject) ~= nil then false else true) then
        local _ = next(arg123._queuedReject)

        for _, val_29 in ipairs(arg123._queuedReject) do
            coroutine.wrap(val_29)(...)
        end
    else
        local str = tostring((...))
        coroutine.wrap(function() -- line: 1754
            -- upvalues:
            --  [1] t_9 (ref)
            --  [2] arg123 (copy)
            --  [3] str (copy)

            t_9._timeEvent:Wait()

            if not arg123._unhandledRejection then
                return
            end

            local v181 = string.format(
                "Unhandled Promise rejection:\n\n%s\n\n%s",
                str,
                arg123._source
            )

            for _, val_30 in ipairs(t_9._unhandledRejectionCallbacks) do
                task.spawn(val_30, arg123, unpack(arg123._values, 1, arg123._valuesLength))
            end

            if t_9.TEST then
                return
            end

            warn(v181)
        end)()
    end

    arg123:_finalize()
end

function t_9.prototype._finalize(arg124) -- line: 1786
    -- upvalues:
    --  [1] t_9 (copy)

    for _, val_31 in ipairs(arg124._queuedFinally) do
        coroutine.wrap(val_31)(arg124._status)
    end

    arg124._queuedFinally = nil
    arg124._queuedReject = nil
    arg124._queuedResolve = nil

    if not t_9.TEST then
        arg124._parent = nil
        arg124._consumers = nil
    end

    task.defer(coroutine.close, arg124._thread)
end

function t_9.prototype.now(arg125, arg126) -- line: 1823
    -- upvalues:
    --  [1] t_9 (copy)
    --  [2] t_27 (ref)

    local v183 = debug.traceback(nil, 2)

    if arg125._status == t_9.Status.Resolved then
        return arg125:_andThen(v183, function(...) -- line: 1826
            return ...
        end)
    end

    return t_9.reject(
        arg126 == nil and t_27.new(
            {
                kind = t_27.Kind.NotResolvedInTime,
                error = "This Promise was not resolved in time for :now()",
                context = ":now() was called at:\n\n" .. v183
            }
        ) or arg126
    )
end

function t_9.retry(arg127, arg128, ...) -- line: 1868
    -- upvalues:
    --  [1] t_9 (copy)

    local v185

    if type(arg127) == "function" then
        v185 = true
    elseif type(arg127) == "table" then
        local v186 = getmetatable(arg127)

        if v186 then
            v185 = type((rawget(v186, "__call"))) == "function"
        else
            v185 = false
        end
    else
        v185 = false
    end

    assert(v185, "Parameter #1 to Promise.retry must be a function")
    local v185 = if type(arg128) ~= "number" then false else true
    assert(v185, "Parameter #2 to Promise.retry must be a number")
    local t_25 = { ... }
    v185 = select("#", ...)

    return t_9.resolve(arg127(...)):catch(function(...) -- line: 1874
        -- upvalues:
        --  [1] arg128 (copy)
        --  [2] t_9 (ref)
        --  [3] arg127 (copy)
        --  [4] t_25 (copy)
        --  [5] v185 (copy)

        if arg128 > 0 then
            return t_9.retry(arg127, arg128 - 1, unpack(t_25, 1, v185))
        end

        return t_9.reject(...)
    end)
end

function t_9.retryWithDelay(arg129, arg130, arg131, ...) -- line: 1896
    -- upvalues:
    --  [1] t_9 (copy)

    local v191

    if type(arg129) == "function" then
        v191 = true
    elseif type(arg129) == "table" then
        local v192 = getmetatable(arg129)

        if v192 then
            v191 = type((rawget(v192, "__call"))) == "function"
        else
            v191 = false
        end
    else
        v191 = false
    end

    assert(v191, "Parameter #1 to Promise.retry must be a function")
    local v191 = if type(arg130) ~= "number" then false else true
    assert(v191, "Parameter #2 (times) to Promise.retry must be a number")
    assert(
        if type(arg131) ~= "number" then false else true,
        "Parameter #3 (seconds) to Promise.retry must be a number"
    )
    local t_26 = { ... }
    v191 = select("#", ...)

    return t_9.resolve(arg129(...)):catch(function(...) -- line: 1903
        -- upvalues:
        --  [1] arg130 (copy)
        --  [2] t_9 (ref)
        --  [3] arg131 (copy)
        --  [4] arg129 (copy)
        --  [5] t_26 (copy)
        --  [6] v191 (copy)

        if arg130 > 0 then
            t_9.delay(arg131):await()

            return t_9.retryWithDelay(arg129, arg130 - 1, arg131, unpack(t_26, 1, v191))
        end

        return t_9.reject(...)
    end)
end

function t_9.fromEvent(arg132, arg133) -- line: 1938
    -- upvalues:
    --  [1] t_9 (copy)

    arg133 = arg133 or function() -- line: 1939
        return true
    end

    return t_9._new(debug.traceback(nil, 2), function(arg134, _, arg136) -- line: 1943
        -- upvalues:
        --  [1] arg132 (copy)
        --  [2] arg133 (ref)

        local v200 = nil
        local v201 = false

        local function disconnect() -- line: 1947
            -- upvalues:
            --  [1] v200 (ref)

            v200:Disconnect()
            v200 = nil
        end

        v200 = arg132:Connect(function(...) -- line: 1956
            -- upvalues:
            --  [1] arg133 (ref)
            --  [2] arg134 (copy)
            --  [3] v200 (ref)
            --  [4] v201 (ref)

            local v202 = arg133(...)

            if v202 == true then
                arg134(...)

                if v200 then
                    v200:Disconnect()
                    v200 = nil

                    return
                end

                v201 = true

                return
            else
                if type(v202) ~= "boolean" then
                    error("Promise.fromEvent predicate should always return a boolean")
                end

                return
            end
        end)

        if v201 and v200 then
            return disconnect()
        end

        arg136(disconnect)
    end)
end

function t_9.onUnhandledRejection(arg137) -- line: 1990
    -- upvalues:
    --  [1] t_9 (copy)

    table.insert(t_9._unhandledRejectionCallbacks, arg137)

    return function() -- line: 1993
        -- upvalues:
        --  [1] t_9 (ref)
        --  [2] arg137 (copy)

        local v203 = table.find(t_9._unhandledRejectionCallbacks, arg137)

        if v203 then
            table.remove(t_9._unhandledRejectionCallbacks, v203)
        end
    end
end

return t_9
