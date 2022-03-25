package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.battlequeue.BattleQueueBase;
   import net.wg.gui.lobby.battlequeue.RTSBattleQueueItemVO;
   import net.wg.gui.lobby.battlequeue.RTSChangeVehicleWidgetVO;
   import net.wg.infrastructure.exceptions.AbstractException;
   import scaleform.clik.data.DataProvider;
   
   public class RTSBattleQueueMeta extends BattleQueueBase
   {
       
      
      public var onSwitchVehicleClick:Function;
      
      private var _rTSChangeVehicleWidgetVO:RTSChangeVehicleWidgetVO;
      
      private var _dataProviderRTSBattleQueueItemVO:DataProvider;
      
      public function RTSBattleQueueMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:RTSBattleQueueItemVO = null;
         if(this._rTSChangeVehicleWidgetVO)
         {
            this._rTSChangeVehicleWidgetVO.dispose();
            this._rTSChangeVehicleWidgetVO = null;
         }
         if(this._dataProviderRTSBattleQueueItemVO)
         {
            for each(_loc1_ in this._dataProviderRTSBattleQueueItemVO)
            {
               _loc1_.dispose();
            }
            this._dataProviderRTSBattleQueueItemVO.cleanUp();
            this._dataProviderRTSBattleQueueItemVO = null;
         }
         super.onDispose();
      }
      
      public function onSwitchVehicleClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onSwitchVehicleClick,"onSwitchVehicleClick" + Errors.CANT_NULL);
         this.onSwitchVehicleClick();
      }
      
      public final function as_showSwitchVehicle(param1:Object) : void
      {
         var _loc2_:RTSChangeVehicleWidgetVO = this._rTSChangeVehicleWidgetVO;
         this._rTSChangeVehicleWidgetVO = new RTSChangeVehicleWidgetVO(param1);
         this.showSwitchVehicle(this._rTSChangeVehicleWidgetVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setRTSDP(param1:Array) : void
      {
         var _loc5_:RTSBattleQueueItemVO = null;
         var _loc2_:DataProvider = this._dataProviderRTSBattleQueueItemVO;
         this._dataProviderRTSBattleQueueItemVO = new DataProvider();
         var _loc3_:uint = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this._dataProviderRTSBattleQueueItemVO[_loc4_] = new RTSBattleQueueItemVO(param1[_loc4_]);
            _loc4_++;
         }
         this.setRTSDP(this._dataProviderRTSBattleQueueItemVO);
         if(_loc2_)
         {
            for each(_loc5_ in _loc2_)
            {
               _loc5_.dispose();
            }
            _loc2_.cleanUp();
         }
      }
      
      protected function showSwitchVehicle(param1:RTSChangeVehicleWidgetVO) : void
      {
         var _loc2_:String = "as_showSwitchVehicle" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setRTSDP(param1:DataProvider) : void
      {
         var _loc2_:String = "as_setRTSDP" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
