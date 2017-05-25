--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:71b05502ef4487c4fa26162048237002:1786410bb77554df50c591fc115a5714:383abfc4935b361f307dba9176e1ad8f$
--
-- local sheetInfo = require("mysheet")
-- local myImageSheet = graphics.newImageSheet( "mysheet.png", sheetInfo:getSheet() )
-- local sprite = display.newSprite( myImageSheet , {frames={sheetInfo:getFrameIndex("sprite")}} )
--

local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
    
        {
            -- background
            x=219,
            y=1,
            width=514,
            height=606,

        },
        {
            -- esfera-perde
            x=561,
            y=681,
            width=72,
            height=69,

        },
        {
            -- esfera
            x=634,
            y=609,
            width=72,
            height=69,

        },
        {
            -- fundo1
            x=1,
            y=1,
            width=216,
            height=750,

        },
        {
            -- osso1
            x=328,
            y=609,
            width=77,
            height=72,

        },
        {
            -- osso2
            x=328,
            y=683,
            width=77,
            height=50,

            sourceX = 0,
            sourceY = 12,
            sourceWidth = 77,
            sourceHeight = 72
        },
        {
            -- osso3
            x=407,
            y=609,
            width=77,
            height=72,

        },
        {
            -- reload
            x=219,
            y=609,
            width=107,
            height=91,

            sourceX = 1,
            sourceY = 0,
            sourceWidth = 113,
            sourceHeight = 93
        },
        {
            -- virus
            x=561,
            y=609,
            width=73,
            height=75,

            sourceX = 0,
            sourceY = 1,
            sourceWidth = 77,
            sourceHeight = 72
        },
        {
            -- vitamina
            x=486,
            y=609,
            width=75,
            height=75,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 77,
            sourceHeight = 72
        },
    },
    
    sheetContentWidth = 734,
    sheetContentHeight = 752
}

SheetInfo.frameIndex =
{

    ["background"] = 1,
    ["esfera-perde"] = 2,
    ["esfera"] = 3,
    ["fundo1"] = 4,
    ["osso1"] = 5,
    ["osso2"] = 6,
    ["osso3"] = 7,
    ["reload"] = 8,
    ["virus"] = 9,
    ["vitamina"] = 10,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
