package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.vehicleTradeWnds.sell.vo.SellDialogVO;
   import net.wg.infrastructure.base.AbstractWindowView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class VehicleSellDialogMeta extends AbstractWindowView
   {
       
      
      public var setDialogSettings:Function;
      
      public var sell:Function;
      
      public var setUserInput:Function;
      
      public var setCrewDismissal:Function;
      
      public var onSelectionChanged:Function;
      
      private var _sellDialogVO:SellDialogVO;
      
      public function VehicleSellDialogMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._sellDialogVO)
         {
            this._sellDialogVO.dispose();
            this._sellDialogVO = null;
         }
         super.onDispose();
      }
      
      public function setDialogSettingsS(param1:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.setDialogSettings,"setDialogSettings" + Errors.CANT_NULL);
         this.setDialogSettings(param1);
      }
      
      public function sellS() : void
      {
         App.utils.asserter.assertNotNull(this.sell,"sell" + Errors.CANT_NULL);
         this.sell();
      }
      
      public function setUserInputS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.setUserInput,"setUserInput" + Errors.CANT_NULL);
         this.setUserInput(param1);
      }
      
      public function setCrewDismissalS(param1:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.setCrewDismissal,"setCrewDismissal" + Errors.CANT_NULL);
         this.setCrewDismissal(param1);
      }
      
      public function onSelectionChangedS(param1:int, param2:Boolean, param3:String) : void
      {
         App.utils.asserter.assertNotNull(this.onSelectionChanged,"onSelectionChanged" + Errors.CANT_NULL);
         this.onSelectionChanged(param1,param2,param3);
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:SellDialogVO = this._sellDialogVO;
         this._sellDialogVO = new SellDialogVO(param1);
         this.setData(this._sellDialogVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setData(param1:SellDialogVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
