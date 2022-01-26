package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.vehiclePreview.data.VPWotPlusPanelData;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class VehiclePreviewWotPlusPanelMeta extends BaseDAAPIComponent
   {
       
      
      public var onRentClick:Function;
      
      private var _vPWotPlusPanelData:VPWotPlusPanelData;
      
      public function VehiclePreviewWotPlusPanelMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._vPWotPlusPanelData)
         {
            this._vPWotPlusPanelData.dispose();
            this._vPWotPlusPanelData = null;
         }
         super.onDispose();
      }
      
      public function onRentClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onRentClick,"onRentClick" + Errors.CANT_NULL);
         this.onRentClick();
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:VPWotPlusPanelData = this._vPWotPlusPanelData;
         this._vPWotPlusPanelData = new VPWotPlusPanelData(param1);
         this.setData(this._vPWotPlusPanelData);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setData(param1:VPWotPlusPanelData) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
