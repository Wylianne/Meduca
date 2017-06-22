--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:234d7765268924a28faf0a3aa3107a14:9c5201a054649aad81d4c74fbf4fadad:ce59e0ef6b4af9fefc088af809f682f1$
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
            x=1,
            y=1,
            width=514,
            height=606,

        },
        {
            -- esfera
            x=159,
            y=609,
            width=72,
            height=69,

        },
        {
            -- fundo1
            x=517,
            y=1,
            width=216,
            height=750,

        },
        {
            -- osso1
            x=1,
            y=609,
            width=77,
            height=72,

        },
        {
            -- osso2
            x=159,
            y=680,
            width=77,
            height=50,

            sourceX = 0,
            sourceY = 12,
            sourceWidth = 77,
            sourceHeight = 72
        },
        {
            -- osso3
            x=80,
            y=609,
            width=77,
            height=72,

        },
    },
    
    sheetContentWidth = 734,
    sheetContentHeight = 752
}

SheetInfo.frameIndex =
{

    ["background"] = 1,
    ["esfera"] = 2,
    ["fundo1"] = 3,
    ["osso1"] = 4,
    ["osso2"] = 5,
    ["osso3"] = 6,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
