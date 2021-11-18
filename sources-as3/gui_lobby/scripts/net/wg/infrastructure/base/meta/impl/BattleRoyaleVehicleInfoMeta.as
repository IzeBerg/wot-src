package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.battleRoyale.vehicleInfoView.data.TabbedViewDataVO;
   import net.wg.gui.lobby.battleRoyale.vehicleInfoView.data.VehicleInfoViewVO;
   import net.wg.infrastructure.base.AbstractView;
   import net.wg.infrastructure.exceptions.AbstractException;
   import scaleform.clik.data.DataProvider;
   
   public class BattleRoyaleVehicleInfoMeta extends AbstractView
   {
       
      
      public var onClose:Function;
      
      public var onShowIntro:Function;
      
      private var _vehicleInfoViewVO:VehicleInfoViewVO;
      
      private var _dataProviderTabbedViewDataVO:DataProvider;
      
      public function BattleRoyaleVehicleInfoMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:TabbedViewDataVO = null;
         if(this._vehicleInfoViewVO)
         {
            this._vehicleInfoViewVO.dispose();
            this._vehicleInfoViewVO = null;
         }
         if(this._dataProviderTabbedViewDataVO)
         {
            for each(_loc1_ in this._dataProviderTabbedViewDataVO)
            {
               _loc1_.dispose();
            }
            this._dataProviderTabbedViewDataVO.cleanUp();
            this._dataProviderTabbedViewDataVO = null;
         }
         super.onDispose();
      }
      
      public function onCloseS() : void
      {
         App.utils.asserter.assertNotNull(this.onClose,"onClose" + Errors.CANT_NULL);
         this.onClose();
      }
      
      public function onShowIntroS() : void
      {
         App.utils.asserter.assertNotNull(this.onShowIntro,"onShowIntro" + Errors.CANT_NULL);
         this.onShowIntro();
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:VehicleInfoViewVO = this._vehicleInfoViewVO;
         this._vehicleInfoViewVO = new VehicleInfoViewVO(param1);
         this.setData(this._vehicleInfoViewVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setTabsData(param1:Array) : void
      {
         var _loc5_:TabbedViewDataVO = null;
         var _loc2_:DataProvider = this._dataProviderTabbedViewDataVO;
         this._dataProviderTabbedViewDataVO = new DataProvider();
         var _loc3_:uint = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this._dataProviderTabbedViewDataVO[_loc4_] = new TabbedViewDataVO(param1[_loc4_]);
            _loc4_++;
         }
         this.setTabsData(this._dataProviderTabbedViewDataVO);
         if(_loc2_)
         {
            for each(_loc5_ in _loc2_)
            {
               _loc5_.dispose();
            }
            _loc2_.cleanUp();
         }
      }
      
      protected function setData(param1:VehicleInfoViewVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setTabsData(param1:DataProvider) : void
      {
         var _loc2_:String = "as_setTabsData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
