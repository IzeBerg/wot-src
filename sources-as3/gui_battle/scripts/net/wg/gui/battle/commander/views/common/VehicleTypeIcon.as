package net.wg.gui.battle.commander.views.common
{
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.Values;
   import net.wg.gui.battle.components.BattleUIComponent;
   
   public class VehicleTypeIcon extends BattleUIComponent
   {
      
      public static const TYPE_SUPPLY_DOT:String = "dot";
      
      public static const TYPE_SUPPLY_GUN:String = "gun";
      
      public static const TYPE_SUPPLY_WATCH_TOWER:String = "watchTower";
      
      private static const TEAM_ALLY:String = "_ally";
      
      private static const TEAM_ENEMY:String = "_enemy";
      
      private static const SUFFIX_DEAD:String = "_dead";
      
      private static const SUFFIX_SPOTTED:String = "_spotted";
       
      
      private var _vehicleType:String = "";
      
      private var _isAlive:Boolean = false;
      
      private var _isSpotted:Boolean = false;
      
      private var _isAlly:Boolean = false;
      
      public function VehicleTypeIcon()
      {
         super();
         mouseChildren = false;
      }
      
      public function get isSupply() : Boolean
      {
         return this._vehicleType == TYPE_SUPPLY_DOT || this._vehicleType == TYPE_SUPPLY_GUN || this._vehicleType == TYPE_SUPPLY_WATCH_TOWER;
      }
      
      public function set isAlly(param1:Boolean) : void
      {
         if(this._isAlly != param1)
         {
            this._isAlly = param1;
            invalidateData();
         }
      }
      
      public function get isAlly() : Boolean
      {
         return this._isAlly;
      }
      
      public function set vehicleType(param1:String) : void
      {
         if(this._vehicleType != param1)
         {
            this._vehicleType = param1;
            invalidateData();
         }
      }
      
      public function get vehicleType() : String
      {
         return this._vehicleType;
      }
      
      public function set isAlive(param1:Boolean) : void
      {
         if(this._isAlive != param1)
         {
            this._isAlive = param1;
            invalidateData();
         }
      }
      
      public function get isAlive() : Boolean
      {
         return this._isAlive;
      }
      
      public function set isSpotted(param1:Boolean) : void
      {
         if(this._isSpotted != param1)
         {
            this._isSpotted = param1;
            invalidateData();
         }
      }
      
      public function get isSpotted() : Boolean
      {
         return this._isSpotted;
      }
      
      private function getIconFrame() : String
      {
         var _loc1_:String = this.vehicleType + (!!this.isAlly ? TEAM_ALLY : TEAM_ENEMY);
         if(this.isAlive)
         {
            if(!this.isSupply && this.isSpotted)
            {
               _loc1_ += SUFFIX_SPOTTED;
            }
         }
         else
         {
            _loc1_ += SUFFIX_DEAD;
         }
         return _loc1_;
      }
      
      override protected function draw() : void
      {
         var _loc1_:String = null;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            visible = this.vehicleType != Values.EMPTY_STR;
            if(visible)
            {
               _loc1_ = this.getIconFrame();
               if(currentFrameLabel != _loc1_)
               {
                  gotoAndStop(_loc1_);
               }
            }
         }
      }
   }
}
