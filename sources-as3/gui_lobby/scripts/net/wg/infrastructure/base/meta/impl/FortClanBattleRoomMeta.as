package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.controls.NormalSortingBtnVO;
   import net.wg.gui.lobby.components.data.ButtonFiltersVO;
   import net.wg.gui.lobby.components.data.DeviceSlotVO;
   import net.wg.gui.lobby.fortifications.data.battleRoom.clanBattle.ClanBattleTimerVO;
   import net.wg.gui.lobby.fortifications.data.battleRoom.clanBattle.FortClanBattleRoomVO;
   import net.wg.gui.rally.views.room.BaseRallyRoomViewWithWaiting;
   import net.wg.gui.rally.vo.ActionButtonVO;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class FortClanBattleRoomMeta extends BaseRallyRoomViewWithWaiting
   {
       
      
      public var onTimerAlert:Function;
      
      public var openConfigureWindow:Function;
      
      public var toggleRoomStatus:Function;
      
      public var onFiltersChange:Function;
      
      public var resetFilters:Function;
      
      public var onUnfrozenVehicleSlotClick:Function;
      
      private var _fortClanBattleRoomVO:FortClanBattleRoomVO;
      
      private var _actionButtonVO:ActionButtonVO;
      
      private var _clanBattleTimerVO:ClanBattleTimerVO;
      
      private var _array:Array;
      
      private var _vectorDeviceSlotVO:Vector.<DeviceSlotVO>;
      
      private var _vectorNormalSortingBtnVO:Vector.<NormalSortingBtnVO>;
      
      private var _buttonFiltersVO:ButtonFiltersVO;
      
      public function FortClanBattleRoomMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:DeviceSlotVO = null;
         var _loc2_:NormalSortingBtnVO = null;
         if(this._fortClanBattleRoomVO)
         {
            this._fortClanBattleRoomVO.dispose();
            this._fortClanBattleRoomVO = null;
         }
         if(this._actionButtonVO)
         {
            this._actionButtonVO.dispose();
            this._actionButtonVO = null;
         }
         if(this._clanBattleTimerVO)
         {
            this._clanBattleTimerVO.dispose();
            this._clanBattleTimerVO = null;
         }
         if(this._array)
         {
            this._array.splice(0,this._array.length);
            this._array = null;
         }
         if(this._vectorDeviceSlotVO)
         {
            for each(_loc1_ in this._vectorDeviceSlotVO)
            {
               _loc1_.dispose();
            }
            this._vectorDeviceSlotVO.splice(0,this._vectorDeviceSlotVO.length);
            this._vectorDeviceSlotVO = null;
         }
         if(this._vectorNormalSortingBtnVO)
         {
            for each(_loc2_ in this._vectorNormalSortingBtnVO)
            {
               _loc2_.dispose();
            }
            this._vectorNormalSortingBtnVO.splice(0,this._vectorNormalSortingBtnVO.length);
            this._vectorNormalSortingBtnVO = null;
         }
         if(this._buttonFiltersVO)
         {
            this._buttonFiltersVO.dispose();
            this._buttonFiltersVO = null;
         }
         super.onDispose();
      }
      
      public function onTimerAlertS() : void
      {
         App.utils.asserter.assertNotNull(this.onTimerAlert,"onTimerAlert" + Errors.CANT_NULL);
         this.onTimerAlert();
      }
      
      public function openConfigureWindowS() : void
      {
         App.utils.asserter.assertNotNull(this.openConfigureWindow,"openConfigureWindow" + Errors.CANT_NULL);
         this.openConfigureWindow();
      }
      
      public function toggleRoomStatusS() : void
      {
         App.utils.asserter.assertNotNull(this.toggleRoomStatus,"toggleRoomStatus" + Errors.CANT_NULL);
         this.toggleRoomStatus();
      }
      
      public function onFiltersChangeS(param1:int, param2:int) : void
      {
         App.utils.asserter.assertNotNull(this.onFiltersChange,"onFiltersChange" + Errors.CANT_NULL);
         this.onFiltersChange(param1,param2);
      }
      
      public function resetFiltersS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.resetFilters,"resetFilters" + Errors.CANT_NULL);
         this.resetFilters(param1);
      }
      
      public function onUnfrozenVehicleSlotClickS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.onUnfrozenVehicleSlotClick,"onUnfrozenVehicleSlotClick" + Errors.CANT_NULL);
         this.onUnfrozenVehicleSlotClick(param1);
      }
      
      public final function as_setBattleRoomData(param1:Object) : void
      {
         var _loc2_:FortClanBattleRoomVO = this._fortClanBattleRoomVO;
         this._fortClanBattleRoomVO = new FortClanBattleRoomVO(param1);
         this.setBattleRoomData(this._fortClanBattleRoomVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setConfigureButtonState(param1:Object) : void
      {
         var _loc2_:ActionButtonVO = this._actionButtonVO;
         this._actionButtonVO = new ActionButtonVO(param1);
         this.setConfigureButtonState(this._actionButtonVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setTimerDelta(param1:Object) : void
      {
         var _loc2_:ClanBattleTimerVO = this._clanBattleTimerVO;
         this._clanBattleTimerVO = new ClanBattleTimerVO(param1);
         this.setTimerDelta(this._clanBattleTimerVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setReservesEnabled(param1:Array) : void
      {
         var _loc2_:Array = this._array;
         this._array = param1;
         this.setReservesEnabled(this._array);
         if(_loc2_)
         {
            _loc2_.splice(0,_loc2_.length);
         }
      }
      
      public final function as_setReservesData(param1:Array) : void
      {
         var _loc5_:DeviceSlotVO = null;
         var _loc2_:Vector.<DeviceSlotVO> = this._vectorDeviceSlotVO;
         this._vectorDeviceSlotVO = new Vector.<DeviceSlotVO>(0);
         var _loc3_:uint = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this._vectorDeviceSlotVO[_loc4_] = new DeviceSlotVO(param1[_loc4_]);
            _loc4_++;
         }
         this.setReservesData(this._vectorDeviceSlotVO);
         if(_loc2_)
         {
            for each(_loc5_ in _loc2_)
            {
               _loc5_.dispose();
            }
            _loc2_.splice(0,_loc2_.length);
         }
      }
      
      public final function as_setTableHeader(param1:Array) : void
      {
         var _loc5_:NormalSortingBtnVO = null;
         var _loc2_:Vector.<NormalSortingBtnVO> = this._vectorNormalSortingBtnVO;
         this._vectorNormalSortingBtnVO = new Vector.<NormalSortingBtnVO>(0);
         var _loc3_:uint = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this._vectorNormalSortingBtnVO[_loc4_] = new NormalSortingBtnVO(param1[_loc4_]);
            _loc4_++;
         }
         this.setTableHeader(this._vectorNormalSortingBtnVO);
         if(_loc2_)
         {
            for each(_loc5_ in _loc2_)
            {
               _loc5_.dispose();
            }
            _loc2_.splice(0,_loc2_.length);
         }
      }
      
      public final function as_setFiltersData(param1:Object) : void
      {
         var _loc2_:ButtonFiltersVO = this._buttonFiltersVO;
         this._buttonFiltersVO = new ButtonFiltersVO(param1);
         this.setFiltersData(this._buttonFiltersVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setBattleRoomData(param1:FortClanBattleRoomVO) : void
      {
         var _loc2_:String = "as_setBattleRoomData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setConfigureButtonState(param1:ActionButtonVO) : void
      {
         var _loc2_:String = "as_setConfigureButtonState" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setTimerDelta(param1:ClanBattleTimerVO) : void
      {
         var _loc2_:String = "as_setTimerDelta" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setReservesEnabled(param1:Array) : void
      {
         var _loc2_:String = "as_setReservesEnabled" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setReservesData(param1:Vector.<DeviceSlotVO>) : void
      {
         var _loc2_:String = "as_setReservesData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setTableHeader(param1:Vector.<NormalSortingBtnVO>) : void
      {
         var _loc2_:String = "as_setTableHeader" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setFiltersData(param1:ButtonFiltersVO) : void
      {
         var _loc2_:String = "as_setFiltersData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
