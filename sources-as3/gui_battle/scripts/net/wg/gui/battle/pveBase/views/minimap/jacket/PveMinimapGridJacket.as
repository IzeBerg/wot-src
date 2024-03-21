package net.wg.gui.battle.pveBase.views.minimap.jacket
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.pveBase.views.minimap.PveMinimapConst;
   import net.wg.gui.battle.pveBase.views.minimap.PveMinimapEntriesContainer;
   import net.wg.gui.battle.pveBase.views.minimap.jacket.grid.PveMinimapCoordinates;
   import net.wg.gui.battle.views.minimap.constants.MinimapSizeConst;
   
   public class PveMinimapGridJacket extends PveMinimapBaseJacket
   {
      
      private static const INVALID_GRID:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 1;
      
      public static const THICK:int = 15;
      
      public static const THIN:int = 4;
       
      
      public var horizontalCoordinates:PveMinimapCoordinates;
      
      public var verticalCoordinates:PveMinimapCoordinates;
      
      public var border1:DisplayObject;
      
      public var border2:DisplayObject;
      
      public var border3:DisplayObject;
      
      public var border4:DisplayObject;
      
      public var border5:DisplayObject;
      
      public var border6:DisplayObject;
      
      private var _rectangle:Rectangle;
      
      private var _entriesContainer:PveMinimapEntriesContainer;
      
      private var _rows:int;
      
      private var _columns:int;
      
      private var _isActive:Boolean;
      
      private var _zoom:Number = 1;
      
      private var _currentBorder:DisplayObject;
      
      private var _borders:Vector.<DisplayObject>;
      
      public function PveMinimapGridJacket()
      {
         var _loc1_:DisplayObject = null;
         this._rectangle = new Rectangle();
         super();
         this._borders = new <DisplayObject>[this.border1,this.border2,this.border3,this.border4,this.border5,this.border6];
         for each(_loc1_ in this._borders)
         {
            _loc1_.visible = false;
         }
      }
      
      override public function get leftGap() : int
      {
         return THICK;
      }
      
      override public function get rightGap() : int
      {
         return THIN;
      }
      
      override public function get topGap() : int
      {
         return THICK;
      }
      
      override public function get bottomGap() : int
      {
         return THIN;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.setActive(visible);
      }
      
      override protected function onDispose() : void
      {
         this.setActive(false);
         this._entriesContainer = null;
         this.horizontalCoordinates.dispose();
         this.horizontalCoordinates = null;
         this.verticalCoordinates.dispose();
         this.verticalCoordinates = null;
         this.border1 = null;
         this.border2 = null;
         this.border3 = null;
         this.border4 = null;
         this.border5 = null;
         this.border6 = null;
         this._borders.length = 0;
         this._borders = null;
         this._currentBorder = null;
         super.onDispose();
      }
      
      public function setEntriesContainer(param1:PveMinimapEntriesContainer) : void
      {
         if(this._entriesContainer == param1)
         {
            return;
         }
         this._entriesContainer = param1;
         if(param1 != null)
         {
            param1.grid.visible = visible;
         }
         invalidate(INVALID_GRID);
      }
      
      public function setGrid(param1:int, param2:int) : void
      {
         this._rows = param1;
         this._columns = param2;
         invalidate(INVALID_GRID);
      }
      
      override public function set visible(param1:Boolean) : void
      {
         super.visible = param1;
         this.setActive(param1);
         if(this._entriesContainer != null)
         {
            this._entriesContainer.grid.visible = param1;
         }
      }
      
      private function setActive(param1:Boolean) : void
      {
         if(this._isActive == param1)
         {
            return;
         }
         this._isActive = param1;
         if(param1)
         {
            addEventListener(Event.ENTER_FRAME,this.enterFrameHandler);
         }
         else
         {
            removeEventListener(Event.ENTER_FRAME,this.enterFrameHandler);
         }
      }
      
      private function enterFrameHandler(param1:Event) : void
      {
         invalidate();
      }
      
      override protected function onSizeChanged() : void
      {
         invalidate(INVALID_GRID);
         if(this._currentBorder != null)
         {
            this._currentBorder.visible = false;
         }
         this._currentBorder = this._borders[_currentSizeIndex];
         this._currentBorder.visible = true;
      }
      
      override protected function draw() : void
      {
         var _loc2_:Rectangle = null;
         if(this._entriesContainer == null)
         {
            return;
         }
         if(_currentSizeIndex == PveMinimapConst.INVALID_SIZE_INDEX)
         {
            return;
         }
         var _loc1_:Number = this._entriesContainer.getZoom();
         if(this._zoom != _loc1_)
         {
            this._zoom = _loc1_;
            invalidate(INVALID_GRID);
         }
         if(isInvalid(INVALID_GRID))
         {
            _loc2_ = MinimapSizeConst.MAP_SIZE[_currentSizeIndex];
            this._rectangle.width = _loc2_.width;
            this._rectangle.height = _loc2_.height;
            this.horizontalCoordinates.redraw(_loc2_.width * this._zoom,this._columns);
            this.verticalCoordinates.redraw(_loc2_.height * this._zoom,this._rows);
         }
         this._rectangle.x = this._entriesContainer.scrollingX;
         this._rectangle.y = this._entriesContainer.scrollingY;
         this.horizontalCoordinates.applyRectangle(this._rectangle);
         this.verticalCoordinates.applyRectangle(this._rectangle);
      }
   }
}
