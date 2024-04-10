package net.wg.gui.battle.views.minimap
{
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import net.wg.gui.battle.views.minimap.events.MinimapEvent;
   import net.wg.infrastructure.base.meta.IMinimapMeta;
   import net.wg.infrastructure.base.meta.impl.MinimapMeta;
   
   public class BaseMinimap extends MinimapMeta implements IMinimapMeta
   {
       
      
      private var _messageCoordinateOffset:int = 0;
      
      public function BaseMinimap()
      {
         super();
      }
      
      public function get messageCoordinateOffset() : int
      {
         return this._messageCoordinateOffset;
      }
      
      public function set messageCoordinateOffset(param1:int) : void
      {
         this._messageCoordinateOffset = param1;
      }
      
      public function as_clearScenarioEvent(param1:String) : void
      {
      }
      
      public function as_disableHintPanel() : void
      {
      }
      
      public function as_enableHintPanelWithData(param1:Boolean, param2:Boolean) : void
      {
      }
      
      public function as_initPrebattleSize(param1:int) : void
      {
      }
      
      public function as_setAlpha(param1:Number) : void
      {
         this.alpha = param1;
      }
      
      public function as_setBackground(param1:String) : void
      {
      }
      
      public function as_setScenarioEvent(param1:String, param2:String, param3:String) : void
      {
      }
      
      public function as_setScenarioEventVisible(param1:String, param2:Boolean) : void
      {
      }
      
      public function as_setSize(param1:int) : void
      {
      }
      
      public function as_setVisible(param1:Boolean) : void
      {
         visible = param1;
         dispatchEvent(new MinimapEvent(MinimapEvent.VISIBILITY_CHANGED));
      }
      
      public function as_showVehiclesName(param1:Boolean) : void
      {
         if(param1)
         {
            MinimapEntryController.instance.showVehiclesName();
         }
         else
         {
            MinimapEntryController.instance.hideVehiclesName();
         }
      }
      
      public function as_updateHintPanelData(param1:Boolean, param2:Boolean) : void
      {
      }
      
      public function getMessageCoordinate() : Number
      {
         return this.currentHeight - this.currentTopLeftPoint.y + this._messageCoordinateOffset;
      }
      
      public function getMinimapRectBySizeIndex(param1:int) : Rectangle
      {
         return new Rectangle();
      }
      
      public function getMinimapTotalWidthByIndex(param1:uint) : int
      {
         return 0;
      }
      
      public function getMinmapHeightBySizeIndex(param1:int) : Number
      {
         return 0;
      }
      
      public function setAllowedSizeIndex(param1:Number) : void
      {
      }
      
      public function updateSizeIndex(param1:Boolean) : void
      {
      }
      
      public function get currentWidth() : int
      {
         return initedWidth;
      }
      
      public function get currentHeight() : int
      {
         return initedHeight;
      }
      
      public function get currentTopLeftPoint() : Point
      {
         return new Point(0,0);
      }
      
      public function get currentSizeIndex() : Number
      {
         return -1;
      }
   }
}
