package net.wg.gui.lobby.vehicleCompare.controls.view
{
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import net.wg.data.constants.Cursors;
   import net.wg.data.constants.DragType;
   import net.wg.gui.lobby.components.data.VehParamVO;
   import net.wg.gui.lobby.vehicleCompare.interfaces.ITableGridLine;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.helpers.interfaces.IDragDelegate;
   import net.wg.infrastructure.interfaces.entity.IDragDropHitArea;
   
   public class VehCompareTableGrid extends UIComponentEx implements IDragDelegate, IDragDropHitArea
   {
      
      private static const GRID_RENDERER:String = "VehCompareGridLineUI";
      
      private static const GRID_RENDERER_BOTTOM:String = "VehCompareGridLineBottomUI";
      
      private static const GRID_RENDERER_HIGHLIGHT:String = "VehCompareGridLineSelectionUI";
      
      private static const GRID_RENDERER_SELECTED:String = "VehCompareGridLineSeletedUI";
      
      private static const INV_UPDATE_SELECTED_ROWS:String = "InvUpdateSelectedRows";
      
      private static const INV_SELECT_STAGE_Y:String = "InvSelectStageY";
      
      private static const LEFT_LINE_PADDING:int = 70;
      
      private static const RIGHT_LINE_PADDING:int = 18;
      
      private static const CLICK_MOUSE_RADIUS:int = 3;
       
      
      private var _renderers:Vector.<ITableGridLine>;
      
      private var _selectedRenderers:Vector.<ITableGridLine>;
      
      private var _bottomRenderer:ITableGridLine = null;
      
      private var _highlightedRenderer:ITableGridLine = null;
      
      private var _rowsSelected:Dictionary;
      
      private var _lineHeight:int = 0;
      
      private var _data:VehParamsListDataProvider;
      
      private var _mouseDownPos:Point;
      
      private var _nextStageYToSelect:Number;
      
      public function VehCompareTableGrid()
      {
         this._renderers = new Vector.<ITableGridLine>(0);
         this._selectedRenderers = new Vector.<ITableGridLine>(0);
         this._rowsSelected = new Dictionary();
         super();
         App.cursor.registerDragging(this,Cursors.MOVE);
         this._bottomRenderer = App.utils.classFactory.getComponent(GRID_RENDERER_BOTTOM,ITableGridLine);
         this._bottomRenderer.setRightLinePadding(RIGHT_LINE_PADDING);
         addChild(DisplayObject(this._bottomRenderer));
         this._highlightedRenderer = App.utils.classFactory.getComponent(GRID_RENDERER_HIGHLIGHT,ITableGridLine);
         this._highlightedRenderer.setRightLinePadding(RIGHT_LINE_PADDING);
         addChild(DisplayObject(this._highlightedRenderer));
         this._highlightedRenderer.visible = false;
         addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDownHandler);
         addEventListener(MouseEvent.MOUSE_UP,this.onMouseUpHandler);
      }
      
      override protected function onDispose() : void
      {
         App.cursor.unRegisterDragging(this);
         removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDownHandler);
         removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUpHandler);
         this.clearRenderers(this._renderers);
         this._renderers = null;
         this.clearRenderers(this._selectedRenderers);
         this._selectedRenderers = null;
         App.utils.data.cleanupDynamicObject(this._rowsSelected);
         this._rowsSelected = null;
         this._bottomRenderer.dispose();
         this._bottomRenderer = null;
         this._highlightedRenderer.dispose();
         this._highlightedRenderer = null;
         this._data = null;
         this._mouseDownPos = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:ITableGridLine = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:VehParamVO = null;
         var _loc5_:Point = null;
         var _loc6_:int = 0;
         super.draw();
         if(this._data && isInvalid(INV_UPDATE_SELECTED_ROWS))
         {
            for each(_loc1_ in this._selectedRenderers)
            {
               if(_loc1_.parent)
               {
                  removeChild(DisplayObject(_loc1_));
               }
            }
            App.utils.data.cleanupDynamicObject(this._rowsSelected);
            _loc2_ = this._data.length;
            _loc3_ = 0;
            while(_loc3_ != _loc2_)
            {
               _loc4_ = this._data[_loc3_];
               if(_loc4_.isSelected)
               {
                  this.selectRowAtIndex(_loc3_);
               }
               _loc3_++;
            }
         }
         if(!isNaN(this._nextStageYToSelect) && isInvalid(INV_SELECT_STAGE_Y))
         {
            _loc5_ = globalToLocal(new Point(0,this._nextStageYToSelect));
            if(_loc5_.y >= 0 && _loc5_.y < this._bottomRenderer.y)
            {
               _loc6_ = int(_loc5_.y / this._lineHeight);
               if(this.isRowSelected(_loc6_))
               {
                  this.deselectRowAtIndex(_loc6_);
               }
               else
               {
                  this.selectRowAtIndex(_loc6_);
                  this._highlightedRenderer.visible = false;
               }
            }
         }
      }
      
      public function getDragType() : String
      {
         return DragType.SOFT;
      }
      
      public function getHitArea() : InteractiveObject
      {
         return this;
      }
      
      public function highlightItemAt(param1:Point) : void
      {
         var _loc2_:int = this.rowFromPoint(param1);
         var _loc3_:int = _loc2_ * this._lineHeight;
         this._highlightedRenderer.y = _loc3_;
         this._highlightedRenderer.visible = _loc3_ >= 0 && _loc3_ < this._bottomRenderer.y;
      }
      
      public function onDragging(param1:Number, param2:Number) : void
      {
      }
      
      public function onEndDrag() : void
      {
      }
      
      public function onStartDrag() : void
      {
      }
      
      public function selectRowAt(param1:Number) : void
      {
         this._nextStageYToSelect = param1;
         invalidate(INV_SELECT_STAGE_Y);
      }
      
      public function setDataProvider(param1:VehParamsListDataProvider) : void
      {
         this._data = param1;
         invalidate(INV_UPDATE_SELECTED_ROWS);
      }
      
      public function setLineHeight(param1:int) : void
      {
         this._lineHeight = param1;
      }
      
      public function setRenderersCount(param1:int) : void
      {
         var _loc5_:int = 0;
         var _loc6_:ITableGridLine = null;
         var _loc2_:int = this._renderers.length;
         var _loc3_:int = param1 >> 1;
         if(_loc2_ < _loc3_)
         {
            _loc5_ = _loc2_;
            while(_loc5_ != _loc3_)
            {
               _loc6_ = App.utils.classFactory.getComponent(GRID_RENDERER,ITableGridLine);
               _loc6_.width = _width;
               _loc6_.x = 0;
               _loc6_.y = this._lineHeight * ((_loc5_ << 1) + 1);
               _loc6_.setLeftLinePadding(LEFT_LINE_PADDING);
               _loc6_.setRightLinePadding(RIGHT_LINE_PADDING);
               this._renderers.push(_loc6_);
               addChild(DisplayObject(_loc6_));
               _loc5_++;
            }
         }
         this._highlightedRenderer.width = _width;
         this._bottomRenderer.width = _width;
         this._bottomRenderer.y = this._lineHeight * param1;
         _loc2_ = this._renderers.length;
         var _loc4_:int = 0;
         while(_loc4_ != _loc2_)
         {
            this._renderers[_loc4_].visible = _loc4_ < _loc3_;
            _loc4_++;
         }
      }
      
      public function updateSelectedRows() : void
      {
         invalidate(INV_UPDATE_SELECTED_ROWS);
         validateNow();
      }
      
      private function clearRenderers(param1:Vector.<ITableGridLine>) : void
      {
         var _loc2_:ITableGridLine = null;
         for each(_loc2_ in param1)
         {
            _loc2_.dispose();
         }
         param1.splice(0,param1.length);
      }
      
      private function rowFromPoint(param1:Point) : int
      {
         var _loc2_:Point = this.globalToLocal(param1);
         return int(_loc2_.y / this._lineHeight);
      }
      
      private function isRowSelected(param1:int) : Boolean
      {
         return this._rowsSelected[param1];
      }
      
      private function deselectRowAtIndex(param1:int) : void
      {
         var _loc2_:ITableGridLine = this._rowsSelected[param1];
         if(_loc2_)
         {
            removeChild(DisplayObject(_loc2_));
            delete this._rowsSelected[param1];
            VehParamVO(this._data[param1]).isSelected = false;
         }
      }
      
      private function selectRowAtIndex(param1:int) : void
      {
         var _loc2_:ITableGridLine = this.pullSelectedRenderer();
         var _loc3_:int = param1 * this._lineHeight;
         _loc2_.y = _loc3_;
         addChild(DisplayObject(_loc2_));
         this._rowsSelected[param1] = _loc2_;
         VehParamVO(this._data[param1]).isSelected = true;
      }
      
      private function pullSelectedRenderer() : ITableGridLine
      {
         var _loc1_:ITableGridLine = null;
         for each(_loc1_ in this._selectedRenderers)
         {
            if(_loc1_.parent == null)
            {
               return _loc1_;
            }
         }
         _loc1_ = App.utils.classFactory.getComponent(GRID_RENDERER_SELECTED,ITableGridLine);
         _loc1_.width = _width;
         _loc1_.setRightLinePadding(RIGHT_LINE_PADDING);
         this._selectedRenderers.push(_loc1_);
         return _loc1_;
      }
      
      private function updateSize() : void
      {
         var _loc1_:Sprite = null;
         for each(_loc1_ in this._renderers)
         {
            _loc1_.width = _width;
         }
         for each(_loc1_ in this._selectedRenderers)
         {
            _loc1_.width = _width;
         }
         this._bottomRenderer.width = _width;
         this._highlightedRenderer.width = _width;
      }
      
      override public function set width(param1:Number) : void
      {
         _width = param1;
         this.updateSize();
      }
      
      private function onMouseUpHandler(param1:MouseEvent) : void
      {
         if(this._mouseDownPos && Math.abs(this._mouseDownPos.x - param1.stageX) <= CLICK_MOUSE_RADIUS && Math.abs(this._mouseDownPos.y - param1.stageY) <= CLICK_MOUSE_RADIUS)
         {
            this.selectRowAt(param1.stageY);
         }
      }
      
      private function onMouseDownHandler(param1:MouseEvent) : void
      {
         this._mouseDownPos = new Point(param1.stageX,param1.stageY);
      }
   }
}
