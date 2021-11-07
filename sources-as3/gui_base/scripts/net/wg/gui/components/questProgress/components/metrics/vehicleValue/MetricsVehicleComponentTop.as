package net.wg.gui.components.questProgress.components.metrics.vehicleValue
{
   import flash.text.TextField;
   import net.wg.gui.components.questProgress.data.metrics.QPMetricsVehicleVO;
   import scaleform.gfx.TextFieldEx;
   
   public class MetricsVehicleComponentTop extends MetricsVehicleComponentBase
   {
      
      private static const IMAGE_Y_POSITION:int = 40;
       
      
      public var valueTf:TextField = null;
      
      public function MetricsVehicleComponentTop()
      {
         super();
      }
      
      override protected function doPrepare() : void
      {
         imageYPosLine = IMAGE_Y_POSITION;
         TextFieldEx.setNoTranslate(this.valueTf,true);
         super.doPrepare();
      }
      
      override protected function doLayout() : void
      {
         var _loc1_:int = vehicles.length;
         var _loc2_:Number = -(_loc1_ * ICONS_WIDTH - ICONS_WIDTH) / 2;
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_)
         {
            vehicles[_loc3_].x = _loc2_ ^ 0;
            _loc2_ += ICONS_WIDTH;
            _loc3_++;
         }
         super.doLayout();
      }
      
      override protected function onDispose() : void
      {
         this.valueTf = null;
         super.onDispose();
      }
      
      override protected function doInit(param1:QPMetricsVehicleVO) : void
      {
         this.updateValue(param1.value);
         super.doInit(param1);
      }
      
      override protected function doUpdate(param1:QPMetricsVehicleVO) : void
      {
         this.updateValue(param1.value);
         super.doUpdate(param1);
      }
      
      protected function updateValue(param1:String) : void
      {
         this.valueTf.text = param1;
      }
   }
}
