package net.wg.gui.battle.commander.views.supplyPanel
{
   import flash.display.MovieClip;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.battle.commander.VO.daapi.DAAPICommanderDataVO;
   import net.wg.gui.battle.commander.VO.daapi.DAAPICommanderInfoVO;
   import net.wg.gui.battle.commander.VO.daapi.DAAPISuppliesDataVO;
   import net.wg.gui.battle.commander.VO.daapi.DAAPISupplyInfoVO;
   import net.wg.gui.battle.components.BattleDisplayable;
   import net.wg.infrastructure.helpers.statisticsDataController.intarfaces.IRTSBattleStatisticDataController;
   import net.wg.utils.IClassFactory;
   
   public class SupplyPanel extends BattleDisplayable implements IRTSBattleStatisticDataController
   {
      
      public static const SUPPLY_PANEL_LEFT_OFFSET:int = 184;
      
      private static const _BG_PADDING:int = 13;
      
      private static const _ITEMS_OFFSET:int = 16;
      
      private static const INVALID_SUPPLIES:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 1;
       
      
      public var allySupplyMC:MovieClip = null;
      
      public var allyBackground:MovieClip = null;
      
      private var _allySupplies:Object;
      
      private var _allySuppliesCount:uint = 0;
      
      public var enemySupplyMC:MovieClip = null;
      
      public var enemyBackground:MovieClip = null;
      
      private var _enemySupplies:Object;
      
      private var _enemySuppliesCount:uint = 0;
      
      private var _isCommander:Boolean = false;
      
      private var _enemyHasSupplies:Boolean = false;
      
      private var _stageWidth:int = 0;
      
      private var _stageHeight:int = 0;
      
      private var _classFactory:IClassFactory;
      
      private var _allySupplyDistFromScreenCenter:int = 0;
      
      private var _enemySupplyDistFromScreenCenter:int = 0;
      
      public function SupplyPanel()
      {
         this._allySupplies = {};
         this._enemySupplies = {};
         this._classFactory = App.utils.classFactory;
         super();
      }
      
      private function addSupply(param1:DAAPISupplyInfoVO, param2:Boolean) : SupplyPanelItem
      {
         var _loc3_:SupplyPanelItem = this._classFactory.getComponent(Linkages.SUPPLY_PANEL_ITEM,SupplyPanelItem);
         if(param2)
         {
            ++this._allySuppliesCount;
            this.allySupplyMC.addChild(_loc3_);
         }
         else
         {
            this._enemyHasSupplies = true;
            ++this._enemySuppliesCount;
            this.enemySupplyMC.addChild(_loc3_);
         }
         _loc3_.data = param1;
         _loc3_.isCommander = this._isCommander;
         return _loc3_;
      }
      
      private function updateSupplies() : void
      {
         var _loc2_:uint = 0;
         var _loc5_:SupplyPanelItem = null;
         var _loc6_:int = 0;
         var _loc7_:SupplyPanelItem = null;
         var _loc1_:int = _BG_PADDING;
         _loc2_ = SupplyPanelItem.WIDTH;
         var _loc3_:int = _loc2_ + _ITEMS_OFFSET;
         var _loc4_:int = this.allyBackground.width - _loc2_ - _loc1_;
         for each(_loc5_ in this._allySupplies)
         {
            _loc5_.x = _loc4_;
            _loc4_ -= _loc3_;
         }
         _loc6_ = _loc1_;
         for each(_loc7_ in this._enemySupplies)
         {
            _loc7_.x = _loc6_;
            _loc6_ += _loc3_;
         }
      }
      
      private function updateBackground() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = this._stageWidth / 2;
         var _loc3_:Boolean = this.allyBackground.visible = this._allySuppliesCount > 0;
         if(_loc3_)
         {
            _loc1_ = this._allySuppliesCount * SupplyPanelItem.WIDTH + (this._allySuppliesCount - 1) * _ITEMS_OFFSET + 2 * _BG_PADDING;
            this.allyBackground.x = -this._allySupplyDistFromScreenCenter - _loc1_;
            this.allySupplyMC.x = this.allyBackground.x;
            this.allyBackground.width = _loc1_;
         }
         _loc3_ = this.enemyBackground.visible = this._enemyHasSupplies;
         if(_loc3_)
         {
            _loc1_ = this._enemySuppliesCount * SupplyPanelItem.WIDTH + (this._enemySuppliesCount - 1) * _ITEMS_OFFSET + 2 * _BG_PADDING;
            this.enemyBackground.x = this._enemySupplyDistFromScreenCenter;
            this.enemySupplyMC.x = this.enemyBackground.x;
            this.enemyBackground.width = _loc1_;
         }
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INVALID_SUPPLIES))
         {
            this.updateBackground();
            this.updateSupplies();
         }
      }
      
      override protected function onDispose() : void
      {
         this._classFactory = null;
         var _loc1_:SupplyPanelItem = null;
         for each(_loc1_ in this._allySupplies)
         {
            this.allySupplyMC.removeChild(_loc1_);
            _loc1_.dispose();
         }
         App.utils.data.cleanupDynamicObject(this._allySupplies);
         this._allySupplies = null;
         this.allySupplyMC = null;
         this.allyBackground = null;
         for each(_loc1_ in this._enemySupplies)
         {
            this.enemySupplyMC.removeChild(_loc1_);
            _loc1_.dispose();
         }
         App.utils.data.cleanupDynamicObject(this._enemySupplies);
         this._enemySupplies = null;
         this.enemySupplyMC = null;
         this.enemyBackground = null;
         super.onDispose();
      }
      
      public function updateStage(param1:Number, param2:Number) : void
      {
         this._stageWidth = param1;
         this._stageHeight = param2;
         invalidate(INVALID_SUPPLIES);
      }
      
      public function get allySupplyDistFromScreenCenter() : int
      {
         return this._allySupplyDistFromScreenCenter;
      }
      
      public function set allySupplyDistFromScreenCenter(param1:int) : void
      {
         this._allySupplyDistFromScreenCenter = param1;
         invalidate(INVALID_SUPPLIES);
      }
      
      public function get enemySupplyDistFromScreenCenter() : int
      {
         return this._enemySupplyDistFromScreenCenter;
      }
      
      public function set enemySupplyDistFromScreenCenter(param1:int) : void
      {
         this._enemySupplyDistFromScreenCenter = param1;
         invalidate(INVALID_SUPPLIES);
      }
      
      public function setRTSCommanderInfo(param1:DAAPICommanderInfoVO) : void
      {
      }
      
      public function setRTSCommanderData(param1:DAAPICommanderDataVO) : void
      {
      }
      
      public function setRTSOrder(param1:Number, param2:Number, param3:Boolean) : void
      {
      }
      
      public function setRTSCommanderMode(param1:Boolean) : void
      {
      }
      
      public function setRTSIsSpotted(param1:Number, param2:Boolean) : void
      {
      }
      
      public function setRTSVehicleDisabled(param1:int, param2:Boolean) : void
      {
      }
      
      public function setRTSPlayerCommander(param1:Boolean) : void
      {
         var _loc2_:SupplyPanelItem = null;
         if(param1 != this._isCommander)
         {
            this._isCommander = param1;
            for each(_loc2_ in this._allySupplies)
            {
               _loc2_.isCommander = param1;
            }
            invalidate(INVALID_SUPPLIES);
         }
      }
      
      public function setRTSSupplyData(param1:DAAPISuppliesDataVO) : void
      {
         var _loc2_:DAAPISupplyInfoVO = null;
         var _loc3_:String = "";
         var _loc4_:SupplyPanelItem = null;
         for each(_loc2_ in param1.leftSupplyInfos)
         {
            _loc3_ = _loc2_.supplyType;
            _loc4_ = this._allySupplies[_loc3_];
            if(!_loc4_)
            {
               this._allySupplies[_loc3_] = _loc4_ = this.addSupply(_loc2_,true);
            }
            _loc4_.data = _loc2_;
         }
         for each(_loc2_ in param1.rightSupplyInfos)
         {
            _loc3_ = _loc2_.supplyType;
            _loc4_ = this._enemySupplies[_loc3_];
            if(!_loc4_)
            {
               this._enemySupplies[_loc3_] = _loc4_ = this.addSupply(_loc2_,false);
            }
            _loc4_.data = _loc2_;
         }
         invalidate(INVALID_SUPPLIES);
      }
      
      public function setRTSVehicleGroup(param1:int, param2:int) : void
      {
      }
      
      public function setRTSVehicleInFocus(param1:int) : void
      {
      }
      
      public function setRTSVehiclesInFocus(param1:Vector.<int>, param2:Boolean) : void
      {
      }
      
      public function setRTSReloading(param1:int, param2:Number, param3:Number, param4:Number) : void
      {
      }
      
      public function setRTSSelectedVehicles(param1:Vector.<int>) : void
      {
      }
      
      public function setRTSSpeakingVehicle(param1:int, param2:Boolean) : void
      {
      }
      
      public function setRTSClipData(param1:int, param2:int, param3:int, param4:Boolean, param5:Boolean) : void
      {
      }
      
      public function setRTSVehicleModuleDamaged(param1:int, param2:String) : void
      {
      }
      
      public function setRTSVehicleModuleRepaired(param1:int, param2:String) : void
      {
      }
      
      public function setRTSCondition(param1:Number, param2:String) : void
      {
      }
   }
}
