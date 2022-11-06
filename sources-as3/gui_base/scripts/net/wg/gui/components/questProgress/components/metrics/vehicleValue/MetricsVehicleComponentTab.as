package net.wg.gui.components.questProgress.components.metrics.vehicleValue
{
   import flash.text.TextField;
   import net.wg.gui.components.questProgress.data.metrics.QPMetricsVehicleVO;
   import net.wg.utils.ICommons;
   
   public class MetricsVehicleComponentTab extends MetricsVehicleComponentBase
   {
      
      private static const TITLE_GAP:int = 10;
      
      private static const IMAGE_Y_POSITION:int = 12;
       
      
      public var titleTf:TextField = null;
      
      private var _commons:ICommons;
      
      public function MetricsVehicleComponentTab()
      {
         this._commons = App.utils.commons;
         super();
      }
      
      override protected function doPrepare() : void
      {
         imageYPosLine = IMAGE_Y_POSITION;
         super.doPrepare();
      }
      
      override protected function onDispose() : void
      {
         this._commons = null;
         this.titleTf = null;
         super.onDispose();
      }
      
      override protected function doInit(param1:QPMetricsVehicleVO) : void
      {
         super.doInit(param1);
         this.titleTf.text = param1.title;
         this._commons.updateTextFieldSize(this.titleTf,true,false);
      }
      
      override protected function doLayout() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(vehicles)
         {
            _loc1_ = this.titleTf.x + this.titleTf.width + TITLE_GAP;
            _loc2_ = vehicles.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               vehicles[_loc3_].x = _loc1_;
               _loc1_ += ICONS_WIDTH;
               _loc3_++;
            }
            componentWidth = _loc2_ > 0 ? int(_loc1_ - ICONS_WIDTH) : int(_loc1_);
         }
         else
         {
            componentWidth = 0;
         }
         super.doLayout();
      }
   }
}
