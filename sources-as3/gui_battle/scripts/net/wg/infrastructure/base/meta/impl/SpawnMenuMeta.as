package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.commander.views.spawnMenu.VO.RosterSupplyVO;
   import net.wg.gui.battle.commander.views.spawnMenu.VO.RosterVehicleVO;
   import net.wg.gui.battle.commander.views.spawnMenu.VO.SpawnMenuVO;
   import net.wg.gui.battle.commander.views.spawnMenu.map.VO.MapVO;
   import net.wg.gui.battle.commander.views.spawnMenu.map.VO.PlacePointEntryVO;
   import net.wg.gui.battle.commander.views.spawnMenu.map.VO.VehicleEntryVO;
   import net.wg.gui.battle.components.BattleDisplayable;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class SpawnMenuMeta extends BattleDisplayable
   {
       
      
      public var onBGClick:Function;
      
      public var onAutoSetBtnClick:Function;
      
      public var onResetBtnClick:Function;
      
      public var onBattleBtnClick:Function;
      
      public var onSupplySelect:Function;
      
      public var onVehicleSelect:Function;
      
      public var onPointClick:Function;
      
      private var _spawnMenuVO:SpawnMenuVO;
      
      private var _mapVO:MapVO;
      
      private var _vectorRosterVehicleVO:Vector.<RosterVehicleVO>;
      
      private var _vectorRosterSupplyVO:Vector.<RosterSupplyVO>;
      
      private var _vectorPlacePointEntryVO:Vector.<PlacePointEntryVO>;
      
      private var _vectorVehicleEntryVO:Vector.<VehicleEntryVO>;
      
      private var _vectorVehicleEntryVO1:Vector.<VehicleEntryVO>;
      
      public function SpawnMenuMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:RosterVehicleVO = null;
         var _loc2_:RosterSupplyVO = null;
         var _loc3_:PlacePointEntryVO = null;
         var _loc4_:VehicleEntryVO = null;
         var _loc5_:VehicleEntryVO = null;
         if(this._spawnMenuVO)
         {
            this._spawnMenuVO.dispose();
            this._spawnMenuVO = null;
         }
         if(this._mapVO)
         {
            this._mapVO.dispose();
            this._mapVO = null;
         }
         if(this._vectorRosterVehicleVO)
         {
            for each(_loc1_ in this._vectorRosterVehicleVO)
            {
               _loc1_.dispose();
            }
            this._vectorRosterVehicleVO.splice(0,this._vectorRosterVehicleVO.length);
            this._vectorRosterVehicleVO = null;
         }
         if(this._vectorRosterSupplyVO)
         {
            for each(_loc2_ in this._vectorRosterSupplyVO)
            {
               _loc2_.dispose();
            }
            this._vectorRosterSupplyVO.splice(0,this._vectorRosterSupplyVO.length);
            this._vectorRosterSupplyVO = null;
         }
         if(this._vectorPlacePointEntryVO)
         {
            for each(_loc3_ in this._vectorPlacePointEntryVO)
            {
               _loc3_.dispose();
            }
            this._vectorPlacePointEntryVO.splice(0,this._vectorPlacePointEntryVO.length);
            this._vectorPlacePointEntryVO = null;
         }
         if(this._vectorVehicleEntryVO)
         {
            for each(_loc4_ in this._vectorVehicleEntryVO)
            {
               _loc4_.dispose();
            }
            this._vectorVehicleEntryVO.splice(0,this._vectorVehicleEntryVO.length);
            this._vectorVehicleEntryVO = null;
         }
         if(this._vectorVehicleEntryVO1)
         {
            for each(_loc5_ in this._vectorVehicleEntryVO1)
            {
               _loc5_.dispose();
            }
            this._vectorVehicleEntryVO1.splice(0,this._vectorVehicleEntryVO1.length);
            this._vectorVehicleEntryVO1 = null;
         }
         super.onDispose();
      }
      
      public function onBGClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onBGClick,"onBGClick" + Errors.CANT_NULL);
         this.onBGClick();
      }
      
      public function onAutoSetBtnClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onAutoSetBtnClick,"onAutoSetBtnClick" + Errors.CANT_NULL);
         this.onAutoSetBtnClick();
      }
      
      public function onResetBtnClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onResetBtnClick,"onResetBtnClick" + Errors.CANT_NULL);
         this.onResetBtnClick();
      }
      
      public function onBattleBtnClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onBattleBtnClick,"onBattleBtnClick" + Errors.CANT_NULL);
         this.onBattleBtnClick();
      }
      
      public function onSupplySelectS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.onSupplySelect,"onSupplySelect" + Errors.CANT_NULL);
         this.onSupplySelect(param1);
      }
      
      public function onVehicleSelectS(param1:Number) : void
      {
         App.utils.asserter.assertNotNull(this.onVehicleSelect,"onVehicleSelect" + Errors.CANT_NULL);
         this.onVehicleSelect(param1);
      }
      
      public function onPointClickS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.onPointClick,"onPointClick" + Errors.CANT_NULL);
         this.onPointClick(param1);
      }
      
      public final function as_setData(param1:Object, param2:Object) : void
      {
         var _loc3_:SpawnMenuVO = this._spawnMenuVO;
         this._spawnMenuVO = new SpawnMenuVO(param1);
         var _loc4_:MapVO = this._mapVO;
         this._mapVO = new MapVO(param2);
         this.setData(this._spawnMenuVO,this._mapVO);
         if(_loc3_)
         {
            _loc3_.dispose();
         }
         if(_loc4_)
         {
            _loc4_.dispose();
         }
      }
      
      public final function as_setItemsData(param1:Array, param2:Array) : void
      {
         var _loc9_:RosterVehicleVO = null;
         var _loc10_:RosterSupplyVO = null;
         var _loc3_:Vector.<RosterVehicleVO> = this._vectorRosterVehicleVO;
         this._vectorRosterVehicleVO = new Vector.<RosterVehicleVO>(0);
         var _loc4_:uint = param1.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            this._vectorRosterVehicleVO[_loc5_] = new RosterVehicleVO(param1[_loc5_]);
            _loc5_++;
         }
         var _loc6_:Vector.<RosterSupplyVO> = this._vectorRosterSupplyVO;
         this._vectorRosterSupplyVO = new Vector.<RosterSupplyVO>(0);
         var _loc7_:uint = param2.length;
         var _loc8_:int = 0;
         while(_loc8_ < _loc7_)
         {
            this._vectorRosterSupplyVO[_loc8_] = new RosterSupplyVO(param2[_loc8_]);
            _loc8_++;
         }
         this.setItemsData(this._vectorRosterVehicleVO,this._vectorRosterSupplyVO);
         if(_loc3_)
         {
            for each(_loc9_ in _loc3_)
            {
               _loc9_.dispose();
            }
            _loc3_.splice(0,_loc3_.length);
         }
         if(_loc6_)
         {
            for each(_loc10_ in _loc6_)
            {
               _loc10_.dispose();
            }
            _loc6_.splice(0,_loc6_.length);
         }
      }
      
      public final function as_updateEntriesData(param1:Array, param2:Array, param3:Array) : void
      {
         var _loc13_:PlacePointEntryVO = null;
         var _loc14_:VehicleEntryVO = null;
         var _loc15_:VehicleEntryVO = null;
         var _loc4_:Vector.<PlacePointEntryVO> = this._vectorPlacePointEntryVO;
         this._vectorPlacePointEntryVO = new Vector.<PlacePointEntryVO>(0);
         var _loc5_:uint = param1.length;
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_)
         {
            this._vectorPlacePointEntryVO[_loc6_] = new PlacePointEntryVO(param1[_loc6_]);
            _loc6_++;
         }
         var _loc7_:Vector.<VehicleEntryVO> = this._vectorVehicleEntryVO;
         this._vectorVehicleEntryVO = new Vector.<VehicleEntryVO>(0);
         var _loc8_:uint = param2.length;
         var _loc9_:int = 0;
         while(_loc9_ < _loc8_)
         {
            this._vectorVehicleEntryVO[_loc9_] = new VehicleEntryVO(param2[_loc9_]);
            _loc9_++;
         }
         var _loc10_:Vector.<VehicleEntryVO> = this._vectorVehicleEntryVO1;
         this._vectorVehicleEntryVO1 = new Vector.<VehicleEntryVO>(0);
         var _loc11_:uint = param3.length;
         var _loc12_:int = 0;
         while(_loc12_ < _loc11_)
         {
            this._vectorVehicleEntryVO1[_loc12_] = new VehicleEntryVO(param3[_loc12_]);
            _loc12_++;
         }
         this.updateEntriesData(this._vectorPlacePointEntryVO,this._vectorVehicleEntryVO,this._vectorVehicleEntryVO1);
         if(_loc4_)
         {
            for each(_loc13_ in _loc4_)
            {
               _loc13_.dispose();
            }
            _loc4_.splice(0,_loc4_.length);
         }
         if(_loc7_)
         {
            for each(_loc14_ in _loc7_)
            {
               _loc14_.dispose();
            }
            _loc7_.splice(0,_loc7_.length);
         }
         if(_loc10_)
         {
            for each(_loc15_ in _loc10_)
            {
               _loc15_.dispose();
            }
            _loc10_.splice(0,_loc10_.length);
         }
      }
      
      protected function setData(param1:SpawnMenuVO, param2:MapVO) : void
      {
         var _loc3_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc3_);
         throw new AbstractException(_loc3_);
      }
      
      protected function setItemsData(param1:Vector.<RosterVehicleVO>, param2:Vector.<RosterSupplyVO>) : void
      {
         var _loc3_:String = "as_setItemsData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc3_);
         throw new AbstractException(_loc3_);
      }
      
      protected function updateEntriesData(param1:Vector.<PlacePointEntryVO>, param2:Vector.<VehicleEntryVO>, param3:Vector.<VehicleEntryVO>) : void
      {
         var _loc4_:String = "as_updateEntriesData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc4_);
         throw new AbstractException(_loc4_);
      }
   }
}
