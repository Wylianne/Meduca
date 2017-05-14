local composer =  require("composer") 
local widget = require( "widget" )


local cruzadasF1 = composer.newScene()


   
function cruzadasF1:create(event)
    SceneGroup = self.view
    
    local function onRowRender( event )
 
    -- Get reference to the row group
    local row = event.row
 
    -- Cache the row "contentWidth" and "contentHeight" because the row bounds can change as children objects are added
    local rowHeight = row.contentHeight
    local rowWidth = row.contentWidth
 
    local rowTitle = display.newText( row, "Row " .. row.index, 0, 0, nil, 14 )
    rowTitle:setFillColor( 0 )
 
    -- Align the label left and vertically centered
    rowTitle.anchorX = 0
    rowTitle.x = 0
    rowTitle.y = rowHeight * 0.5
end
    -- Create the widget
local tableView = widget.newTableView(
    {
        left = 0,
        top = 0,
        height = 330,
        width = 300,
        onRowRender = onRowRender,
        onRowTouch = onRowTouch,
    }
)
 
-- Insert 40 rows
for i = 1, 40 do
    -- Insert a row into the tableView
    tableView:insertRow{
      }
end

SceneGroup:insert(tableView)
    
end

cruzadasF1:addEventListener("create", cruzadasF1)

return cruzadasF1