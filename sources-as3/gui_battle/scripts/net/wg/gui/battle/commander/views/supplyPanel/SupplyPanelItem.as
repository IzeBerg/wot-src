package net.wg.gui.battle.commander.views.supplyPanel
{
   import flash.text.TextField;
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.commander.VO.daapi.DAAPISupplyInfoVO;
   import net.wg.gui.battle.commander.views.common.VehicleTypeIcon;
   import net.wg.gui.battle.components.BattleUIComponent;
   
   public class SupplyPanelItem extends BattleUIComponent
   {
      
      public static const WIDTH:uint = 57;
      
      private static const INVALID_IS_COMMANDER:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 1;
      
      private static const INVALID_COUNT:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 2;
      
      private static const INVALID_TYPE:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 3;
       
      
      public var icon:VehicleTypeIcon = null;
      
      public var status:TextField = null;
      
      private var _supplyType:String = "";
      
      private var _alive:int = -1;
      
      private var _total:int = -1;
      
      private var _isCommander:Boolean = false;
      
      public function SupplyPanelItem()
      {
         super();
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         super.draw();
         if(isInvalid(INVALID_IS_COMMANDER))
         {
            this.icon.isAlly = this._isCommander;
         }
         if(isInvalid(INVALID_COUNT))
         {
            _loc1_ = this._alive;
            _loc2_ = this._total;
            this.icon.isAlive = _loc1_ || !_loc2_;
            this.status.text = _loc1_ + " / " + _loc2_;
         }
         if(isInvalid(INVALID_TYPE))
         {
            this.icon.vehicleType = this._supplyType;
         }
      }
      
      override protected function onDispose() : void
      {
         this.icon.dispose();
         this.icon = null;
         this.status = null;
         super.onDispose();
      }
      
      public function set data(param1:DAAPISupplyInfoVO) : void
      {
         if(this._supplyType != param1.supplyType)
         {
            this._supplyType = param1.supplyType;
            invalidate(INVALID_TYPE);
         }
         if(this._alive != param1.alive)
         {
            this._alive = param1.alive;
            invalidate(INVALID_COUNT);
         }
         if(this._total != param1.all)
         {
            this._total = param1.all;
            invalidate(INVALID_COUNT);
         }
      }
      
      public function set isCommander(param1:Boolean) : void
      {
         if(param1 != this._isCommander)
         {
            this._isCommander = param1;
            invalidate(INVALID_IS_COMMANDER);
         }
      }
   }
}
