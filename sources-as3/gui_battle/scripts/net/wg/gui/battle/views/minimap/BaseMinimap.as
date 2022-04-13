package net.wg.gui.battle.views.minimap
{
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import net.wg.gui.battle.views.minimap.events.MinimapEvent;
   import net.wg.infrastructure.base.meta.IMinimapMeta;
   import net.wg.infrastructure.base.meta.impl.MinimapMeta;
   
   public class BaseMinimap extends MinimapMeta implements IMinimapMeta
   {
       
      
      public function BaseMinimap()
      {
         super();
         mouseEnabled = false;
      }
      
      public static function getParentMinimap(param1:Object) : BaseMinimap
      {
         var _loc2_:BaseMinimap = null;
         var _loc3_:Object = param1;
         while(_loc3_.parent != null)
         {
            _loc3_ = _loc3_.parent;
            if(_loc3_ is BaseMinimap)
            {
               _loc2_ = BaseMinimap(_loc3_);
               break;
            }
         }
         if(_loc2_ == null)
         {
         }
         return _loc2_;
      }
      
      public function as_setVisible(param1:Boolean) : void
      {
         visible = param1;
         dispatchEvent(new MinimapEvent(MinimapEvent.VISIBILITY_CHANGED));
      }
      
      public function as_setAlpha(param1:Number) : void
      {
         this.alpha = param1;
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
      
      public function as_setBackground(param1:String) : void
      {
      }
      
      public function as_setSize(param1:int) : void
      {
      }
      
      public function as_enableHintPanelWithData(param1:Boolean, param2:Boolean) : void
      {
      }
      
      public function as_disableHintPanel() : void
      {
      }
      
      public function as_updateHintPanelData(param1:Boolean, param2:Boolean) : void
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
      
      public function getMinimapRectBySizeIndex(param1:int) : Rectangle
      {
         return new Rectangle();
      }
      
      public function getMessageCoordinate() : Number
      {
         return this.currentHeight - this.currentTopLeftPoint.y;
      }
      
      public function onEntryMouseClickEvent(param1:MouseEvent, param2:Number, param3:Number) : void
      {
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
   }
}
