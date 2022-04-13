package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.commander.VO.daapi.DAAPICommanderDataVO;
   import net.wg.gui.battle.commander.VO.daapi.DAAPICommanderInfoVO;
   import net.wg.gui.battle.commander.VO.daapi.DAAPISuppliesDataVO;
   import net.wg.infrastructure.exceptions.AbstractException;
   import net.wg.infrastructure.helpers.statisticsDataController.BattleStatisticDataController;
   
   public class RTSBattleStatisticDataControllerMeta extends BattleStatisticDataController
   {
       
      
      private var _dAAPICommanderInfoVO:DAAPICommanderInfoVO;
      
      private var _dAAPICommanderDataVO:DAAPICommanderDataVO;
      
      private var _dAAPISuppliesDataVO:DAAPISuppliesDataVO;
      
      private var _vectorint:Vector.<int>;
      
      private var _vectorint1:Vector.<int>;
      
      public function RTSBattleStatisticDataControllerMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._dAAPICommanderInfoVO)
         {
            this._dAAPICommanderInfoVO.dispose();
            this._dAAPICommanderInfoVO = null;
         }
         if(this._dAAPICommanderDataVO)
         {
            this._dAAPICommanderDataVO.dispose();
            this._dAAPICommanderDataVO = null;
         }
         if(this._dAAPISuppliesDataVO)
         {
            this._dAAPISuppliesDataVO.dispose();
            this._dAAPISuppliesDataVO = null;
         }
         if(this._vectorint)
         {
            this._vectorint.splice(0,this._vectorint.length);
            this._vectorint = null;
         }
         if(this._vectorint1)
         {
            this._vectorint1.splice(0,this._vectorint1.length);
            this._vectorint1 = null;
         }
         super.onDispose();
      }
      
      public final function as_setRTSCommanderInfo(param1:Object) : void
      {
         var _loc2_:DAAPICommanderInfoVO = this._dAAPICommanderInfoVO;
         this._dAAPICommanderInfoVO = new DAAPICommanderInfoVO(param1);
         this.setRTSCommanderInfo(this._dAAPICommanderInfoVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setRTSCommanderData(param1:Object) : void
      {
         var _loc2_:DAAPICommanderDataVO = this._dAAPICommanderDataVO;
         this._dAAPICommanderDataVO = new DAAPICommanderDataVO(param1);
         this.setRTSCommanderData(this._dAAPICommanderDataVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setRTSSupplyData(param1:Object) : void
      {
         var _loc2_:DAAPISuppliesDataVO = this._dAAPISuppliesDataVO;
         this._dAAPISuppliesDataVO = new DAAPISuppliesDataVO(param1);
         this.setRTSSupplyData(this._dAAPISuppliesDataVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setRTSSelectedVehicles(param1:Array) : void
      {
         var _loc2_:Vector.<int> = this._vectorint;
         this._vectorint = new Vector.<int>(0);
         var _loc3_:uint = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this._vectorint[_loc4_] = param1[_loc4_];
            _loc4_++;
         }
         this.setRTSSelectedVehicles(this._vectorint);
         if(_loc2_)
         {
            _loc2_.splice(0,_loc2_.length);
         }
      }
      
      public final function as_setRTSVehiclesInFocus(param1:Array, param2:Boolean) : void
      {
         var _loc3_:Vector.<int> = this._vectorint1;
         this._vectorint1 = new Vector.<int>(0);
         var _loc4_:uint = param1.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            this._vectorint1[_loc5_] = param1[_loc5_];
            _loc5_++;
         }
         this.setRTSVehiclesInFocus(this._vectorint1,param2);
         if(_loc3_)
         {
            _loc3_.splice(0,_loc3_.length);
         }
      }
      
      protected function setRTSCommanderInfo(param1:DAAPICommanderInfoVO) : void
      {
         var _loc2_:String = "as_setRTSCommanderInfo" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setRTSCommanderData(param1:DAAPICommanderDataVO) : void
      {
         var _loc2_:String = "as_setRTSCommanderData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setRTSSupplyData(param1:DAAPISuppliesDataVO) : void
      {
         var _loc2_:String = "as_setRTSSupplyData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setRTSSelectedVehicles(param1:Vector.<int>) : void
      {
         var _loc2_:String = "as_setRTSSelectedVehicles" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setRTSVehiclesInFocus(param1:Vector.<int>, param2:Boolean) : void
      {
         var _loc3_:String = "as_setRTSVehiclesInFocus" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc3_);
         throw new AbstractException(_loc3_);
      }
   }
}
