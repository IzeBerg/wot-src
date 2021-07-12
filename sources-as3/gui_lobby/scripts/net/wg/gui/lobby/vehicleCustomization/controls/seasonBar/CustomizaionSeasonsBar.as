package net.wg.gui.lobby.vehicleCustomization.controls.seasonBar
{
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.ui.Keyboard;
   import net.wg.gui.components.advanced.ButtonBarEx;
   import net.wg.gui.lobby.vehicleCustomization.controls.magneticTool.IMagneticClickHandler;
   import net.wg.gui.lobby.vehicleCustomization.controls.magneticTool.MagneticToolController;
   import scaleform.clik.events.InputEvent;
   
   public class CustomizaionSeasonsBar extends ButtonBarEx implements IMagneticClickHandler
   {
      
      private static const ITEM_RENDERER_NAME:String = "CustomizationSeasonRendererUI";
      
      private static const DIRECTION:String = "vertical";
       
      
      public function CustomizaionSeasonsBar()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         itemRendererName = ITEM_RENDERER_NAME;
         direction = DIRECTION;
      }
      
      public function setNotificationCounters(param1:Array) : void
      {
         var _loc2_:CustomizationSeasonRenderer = null;
         var _loc3_:uint = _renderers.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = _renderers[_loc4_];
            _loc2_.setCount(param1[_loc4_]);
            _loc4_++;
         }
      }
      
      override public function handleInput(param1:InputEvent) : void
      {
         super.handleInput(param1);
         var _loc2_:Number = param1.details.code;
         if(_loc2_ != Keyboard.ESCAPE && _loc2_ != Keyboard.LEFT && _loc2_ != Keyboard.RIGHT)
         {
            param1.handled = true;
         }
      }
      
      public function handleLeftClick(param1:MouseEvent) : Boolean
      {
         return DisplayObject(param1.target) is CustomizationSeasonRenderer && MagneticToolController.isAllSeasonSelected();
      }
   }
}
