package net.wg.gui.battle.views.damagePanel.components.modules.chassis
{
   import net.wg.data.constants.generated.BATTLE_ITEM_STATES;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class MultitrackChassisState implements IDisposable
   {
       
      
      public var leftTrack0:PartState;
      
      public var rightTrack0:PartState;
      
      public var leftTrack1:PartState;
      
      public var rightTrack1:PartState;
      
      public var allTracks:Vector.<PartState>;
      
      private var _prevState:String = "normal";
      
      private var _currentState:String = "normal";
      
      private var _disposed:Boolean = false;
      
      public function MultitrackChassisState()
      {
         this.leftTrack0 = new PartState();
         this.rightTrack0 = new PartState();
         this.leftTrack1 = new PartState();
         this.rightTrack1 = new PartState();
         super();
         this.allTracks = new <PartState>[this.leftTrack0,this.leftTrack1,this.rightTrack0,this.rightTrack1];
      }
      
      protected function saveState(param1:String) : String
      {
         this._prevState = this._currentState;
         this._currentState = param1;
         return param1;
      }
      
      public function updateTrackState(param1:String, param2:String) : void
      {
         this[param1].updateState(param2);
      }
      
      public function updateRepairTime(param1:String, param2:int, param3:int) : void
      {
         this[param1].updateRepairTime(param2,param3);
      }
      
      public function reset() : void
      {
         this.leftTrack0.reset();
         this.leftTrack1.reset();
         this.rightTrack1.reset();
         this.rightTrack0.reset();
         this._prevState = BATTLE_ITEM_STATES.NORMAL;
         this._currentState = BATTLE_ITEM_STATES.NORMAL;
      }
      
      public function getChassisState() : String
      {
         if(this.leftTrack0.state == BATTLE_ITEM_STATES.DESTROYED && this.leftTrack1.state == BATTLE_ITEM_STATES.DESTROYED)
         {
            return this.saveState(BATTLE_ITEM_STATES.DESTROYED);
         }
         if(this.rightTrack0.state == BATTLE_ITEM_STATES.DESTROYED && this.rightTrack1.state == BATTLE_ITEM_STATES.DESTROYED)
         {
            return this.saveState(BATTLE_ITEM_STATES.DESTROYED);
         }
         if(this.leftTrack0.state == BATTLE_ITEM_STATES.DESTROYED || this.leftTrack1.state == BATTLE_ITEM_STATES.DESTROYED)
         {
            return this.saveState(BATTLE_ITEM_STATES.CRITICAL);
         }
         if(this.rightTrack0.state == BATTLE_ITEM_STATES.DESTROYED || this.rightTrack1.state == BATTLE_ITEM_STATES.DESTROYED)
         {
            return this.saveState(BATTLE_ITEM_STATES.CRITICAL);
         }
         if(this.leftTrack0.state == BATTLE_ITEM_STATES.REPAIRED && this.leftTrack1.state == BATTLE_ITEM_STATES.DESTROYED || this.rightTrack0.state == BATTLE_ITEM_STATES.REPAIRED && this.rightTrack1.state == BATTLE_ITEM_STATES.DESTROYED)
         {
            return this.saveState(BATTLE_ITEM_STATES.REPAIRED);
         }
         if(this.leftTrack1.state == BATTLE_ITEM_STATES.REPAIRED && this.leftTrack0.state == BATTLE_ITEM_STATES.DESTROYED || this.rightTrack1.state == BATTLE_ITEM_STATES.REPAIRED && this.rightTrack0.state == BATTLE_ITEM_STATES.DESTROYED)
         {
            return this.saveState(BATTLE_ITEM_STATES.REPAIRED);
         }
         if(this.leftTrack1.state == BATTLE_ITEM_STATES.REPAIRED && this.leftTrack1.prevState == BATTLE_ITEM_STATES.DESTROYED || this.rightTrack1.state == BATTLE_ITEM_STATES.REPAIRED && this.rightTrack1.prevState == BATTLE_ITEM_STATES.DESTROYED)
         {
            return this.saveState(BATTLE_ITEM_STATES.CRITICAL);
         }
         if(this.leftTrack0.state == BATTLE_ITEM_STATES.REPAIRED && this.leftTrack0.prevState == BATTLE_ITEM_STATES.DESTROYED || this.rightTrack0.state == BATTLE_ITEM_STATES.REPAIRED && this.rightTrack0.prevState == BATTLE_ITEM_STATES.DESTROYED)
         {
            return this.saveState(BATTLE_ITEM_STATES.CRITICAL);
         }
         if(this.leftTrack1.state == BATTLE_ITEM_STATES.CRITICAL || this.rightTrack1.state == BATTLE_ITEM_STATES.CRITICAL || this.leftTrack0.state == BATTLE_ITEM_STATES.CRITICAL || this.rightTrack0.state == BATTLE_ITEM_STATES.CRITICAL)
         {
            return this.saveState(BATTLE_ITEM_STATES.CRITICAL);
         }
         if(this.leftTrack1.state == BATTLE_ITEM_STATES.REPAIRED_FULL || this.rightTrack1.state == BATTLE_ITEM_STATES.REPAIRED_FULL || this.leftTrack0.state == BATTLE_ITEM_STATES.REPAIRED_FULL || this.rightTrack0.state == BATTLE_ITEM_STATES.REPAIRED_FULL)
         {
            return this.saveState(BATTLE_ITEM_STATES.REPAIRED_FULL);
         }
         return this.saveState(BATTLE_ITEM_STATES.NORMAL);
      }
      
      public function getRepairTimePart() : PartState
      {
         var _loc3_:PartState = null;
         var _loc4_:PartState = null;
         var _loc5_:Boolean = false;
         var _loc6_:Boolean = false;
         var _loc7_:PartState = null;
         var _loc8_:PartState = null;
         var _loc1_:Boolean = this.leftTrack0.repairTime > 0 && this.leftTrack1.repairTime > 0;
         var _loc2_:Boolean = this.rightTrack0.repairTime > 0 && this.rightTrack1.repairTime > 0;
         if(_loc1_ || _loc2_)
         {
            if(_loc1_)
            {
               _loc3_ = this.leftTrack0.repairTime > this.leftTrack1.repairTime ? this.leftTrack1 : this.leftTrack0;
               if(!_loc2_)
               {
                  return _loc3_;
               }
            }
            if(_loc2_)
            {
               _loc4_ = this.rightTrack0.repairTime > this.rightTrack1.repairTime ? this.rightTrack1 : this.rightTrack0;
               if(!_loc1_)
               {
                  return _loc4_;
               }
            }
            return _loc3_.repairTime > _loc4_.repairTime ? _loc3_ : _loc4_;
         }
         _loc5_ = this.leftTrack0.repairTime > 0 || this.leftTrack1.repairTime > 0;
         _loc6_ = this.rightTrack0.repairTime > 0 || this.rightTrack1.repairTime > 0;
         if(_loc5_ && _loc6_)
         {
            _loc3_ = this.leftTrack0.repairTime > this.leftTrack1.repairTime ? this.leftTrack0 : this.leftTrack1;
            _loc4_ = this.rightTrack0.repairTime > this.rightTrack1.repairTime ? this.rightTrack0 : this.rightTrack1;
            return _loc3_.repairTime < _loc4_.repairTime ? _loc3_ : _loc4_;
         }
         _loc7_ = this.allTracks[0];
         for each(_loc8_ in this.allTracks)
         {
            if(_loc7_.repairTime < _loc8_.repairTime)
            {
               _loc7_ = _loc8_;
            }
         }
         if(_loc7_.repairTime > 0)
         {
            return _loc7_;
         }
         return null;
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         this.allTracks.length = 0;
         this.allTracks = null;
         this.leftTrack0 = null;
         this.leftTrack1 = null;
         this.rightTrack0 = null;
         this.rightTrack1 = null;
      }
      
      public function hasSameState() : Boolean
      {
         return this._currentState == this._prevState;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
