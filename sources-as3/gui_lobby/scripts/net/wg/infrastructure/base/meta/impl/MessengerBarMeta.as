package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.messengerBar.MessegerBarInitVO;
   import net.wg.gui.lobby.vehicleCompare.data.VehicleCompareAnimVO;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class MessengerBarMeta extends BaseDAAPIComponent
   {
       
      
      public var channelButtonClick:Function;
      
      public var referralButtonClick:Function;
      
      public var sessionStatsButtonClick:Function;
      
      private var _messegerBarInitVO:MessegerBarInitVO;
      
      private var _vehicleCompareAnimVO:VehicleCompareAnimVO;
      
      public function MessengerBarMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._messegerBarInitVO)
         {
            this._messegerBarInitVO.dispose();
            this._messegerBarInitVO = null;
         }
         if(this._vehicleCompareAnimVO)
         {
            this._vehicleCompareAnimVO.dispose();
            this._vehicleCompareAnimVO = null;
         }
         super.onDispose();
      }
      
      public function channelButtonClickS() : void
      {
         App.utils.asserter.assertNotNull(this.channelButtonClick,"channelButtonClick" + Errors.CANT_NULL);
         this.channelButtonClick();
      }
      
      public function referralButtonClickS() : void
      {
         App.utils.asserter.assertNotNull(this.referralButtonClick,"referralButtonClick" + Errors.CANT_NULL);
         this.referralButtonClick();
      }
      
      public function sessionStatsButtonClickS() : void
      {
         App.utils.asserter.assertNotNull(this.sessionStatsButtonClick,"sessionStatsButtonClick" + Errors.CANT_NULL);
         this.sessionStatsButtonClick();
      }
      
      public final function as_setInitData(param1:Object) : void
      {
         var _loc2_:MessegerBarInitVO = this._messegerBarInitVO;
         this._messegerBarInitVO = new MessegerBarInitVO(param1);
         this.setInitData(this._messegerBarInitVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_showAddVehicleCompareAnim(param1:Object) : void
      {
         var _loc2_:VehicleCompareAnimVO = this._vehicleCompareAnimVO;
         this._vehicleCompareAnimVO = new VehicleCompareAnimVO(param1);
         this.showAddVehicleCompareAnim(this._vehicleCompareAnimVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setInitData(param1:MessegerBarInitVO) : void
      {
         var _loc2_:String = "as_setInitData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function showAddVehicleCompareAnim(param1:VehicleCompareAnimVO) : void
      {
         var _loc2_:String = "as_showAddVehicleCompareAnim" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
