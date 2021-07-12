package net.wg.gui.rally.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.interfaces.IRallyCandidateVO;
   import net.wg.gui.rally.interfaces.IRallySlotVO;
   
   public class RallySlotVO extends DAAPIDataClass implements IRallySlotVO
   {
      
      private static const RESTRICTIONS_FIELD:String = "restrictions";
      
      private static const PLAYER_FIELD:String = "player";
      
      private static const SELECTED_VEHICLE_FIELD:String = "selectedVehicle";
      
      private static const VEHICLE_FIELD:String = "vehicle";
       
      
      private var _isClosed:Boolean = false;
      
      private var _isFreezed:Boolean = false;
      
      private var _isDragNDropFreezed:Boolean = false;
      
      private var _compatibleVehiclesCount:int = 0;
      
      private var _restrictions:Array = null;
      
      private var _rallyIdx:Number;
      
      private var _isCommanderState:Boolean = false;
      
      private var _isCurrentUserInSlot:Boolean = false;
      
      private var _playerStatus:int;
      
      private var _slotLabel:String = "";
      
      private var _player:IRallyCandidateVO;
      
      private var _canBeTaken:Boolean = false;
      
      private var _selectedVehicle:VehicleVO = null;
      
      private var _selectedVehicleLevel:int = 0;
      
      private var _isEvent:Boolean = false;
      
      private var _isLegionaries:Boolean = false;
      
      private var _isLocked:Boolean = false;
      
      private var _rating:String = "";
      
      public var role:uint;
      
      public function RallySlotVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:* = undefined;
         var _loc5_:SettingRosterVO = null;
         if(param1 == RESTRICTIONS_FIELD)
         {
            this.restrictions = [];
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_,"Item \'restrictionsRaw\' must be Array");
            for each(_loc4_ in _loc3_)
            {
               if(_loc4_ && _loc4_.hasOwnProperty(VEHICLE_FIELD))
               {
                  this.restrictions.push(_loc4_.vehicle);
               }
               else if(_loc4_)
               {
                  _loc5_ = new SettingRosterVO(_loc4_);
                  this.restrictions.push(_loc5_);
               }
               else
               {
                  this.restrictions.push(null);
               }
            }
            return false;
         }
         if(param1 == PLAYER_FIELD)
         {
            this._player = Boolean(param2) ? this.initCandidateVO(param2) : null;
            return false;
         }
         if(param1 == SELECTED_VEHICLE_FIELD)
         {
            this.writeSelectedVehicle(param2);
            return false;
         }
         return true;
      }
      
      override protected function onDataRead(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:* = undefined;
         if(param1 == RESTRICTIONS_FIELD)
         {
            _loc3_ = [];
            for each(_loc4_ in this.restrictions)
            {
               if(_loc4_ is Number)
               {
                  _loc3_.push(_loc4_);
               }
               else
               {
                  _loc3_.push(_loc4_.toHash());
               }
            }
            param2[param1] = _loc3_;
            return false;
         }
         if(param1 == PLAYER_FIELD)
         {
            param2[param1] = Boolean(this._player) ? this._player.toHash() : null;
            return false;
         }
         if(param1 == SELECTED_VEHICLE_FIELD)
         {
            param2[param1] = Boolean(this._selectedVehicle) ? this._selectedVehicle.toHash() : null;
            return false;
         }
         return true;
      }
      
      override protected function onDispose() : void
      {
         if(this._player != null)
         {
            this._player.dispose();
            this._player = null;
         }
         if(this._selectedVehicle != null)
         {
            this._selectedVehicle.dispose();
            this._selectedVehicle = null;
         }
         this._restrictions.splice(0);
         this._restrictions = null;
         super.onDispose();
      }
      
      protected function writeSelectedVehicle(param1:Object) : void
      {
         this._selectedVehicle = Boolean(param1) ? new VehicleVO(param1) : null;
      }
      
      protected function initCandidateVO(param1:Object) : IRallyCandidateVO
      {
         return new RallyCandidateVO(param1);
      }
      
      public function get isClosedVal() : Boolean
      {
         return this._isClosed;
      }
      
      public function get playerStatus() : int
      {
         return this._playerStatus;
      }
      
      public function set playerStatus(param1:int) : void
      {
         this._playerStatus = param1;
      }
      
      public function get rating() : String
      {
         return this._rating;
      }
      
      public function set rating(param1:String) : void
      {
         this._rating = param1;
      }
      
      public function get selectedVehicle() : VehicleVO
      {
         return this._selectedVehicle;
      }
      
      public function set selectedVehicle(param1:VehicleVO) : void
      {
         this._selectedVehicle = param1;
      }
      
      public function get selectedVehicleLevel() : int
      {
         return this._selectedVehicleLevel;
      }
      
      public function set selectedVehicleLevel(param1:int) : void
      {
         this._selectedVehicleLevel = param1;
      }
      
      public function get isCurrentUserInSlot() : Boolean
      {
         return this._isCurrentUserInSlot;
      }
      
      public function set isCurrentUserInSlot(param1:Boolean) : void
      {
         this._isCurrentUserInSlot = param1;
      }
      
      public function get hasRestrictions() : Boolean
      {
         return this.restrictions[0] != null || this.restrictions[1] != null;
      }
      
      public function get slotLabel() : String
      {
         return this._slotLabel;
      }
      
      public function set slotLabel(param1:String) : void
      {
         this._slotLabel = param1;
      }
      
      public function get isCommanderState() : Boolean
      {
         return this._isCommanderState;
      }
      
      public function set isCommanderState(param1:Boolean) : void
      {
         this._isCommanderState = param1;
      }
      
      public function get canBeTaken() : Boolean
      {
         return this._canBeTaken;
      }
      
      public function set canBeTaken(param1:Boolean) : void
      {
         this._canBeTaken = param1;
      }
      
      public function get rallyIdx() : Number
      {
         return this._rallyIdx;
      }
      
      public function set rallyIdx(param1:Number) : void
      {
         this._rallyIdx = param1;
      }
      
      public function get player() : IRallyCandidateVO
      {
         return this._player;
      }
      
      public function set player(param1:IRallyCandidateVO) : void
      {
         this._player = param1;
      }
      
      public function get isClosed() : Boolean
      {
         return this._isClosed;
      }
      
      public function set isClosed(param1:Boolean) : void
      {
         this._isClosed = param1;
      }
      
      public function get isFreezed() : Boolean
      {
         return this._isFreezed;
      }
      
      public function set isFreezed(param1:Boolean) : void
      {
         this._isFreezed = param1;
      }
      
      public function get isDragNDropFreezed() : Boolean
      {
         return this._isDragNDropFreezed;
      }
      
      public function set isDragNDropFreezed(param1:Boolean) : void
      {
         this._isDragNDropFreezed = param1;
      }
      
      public function get compatibleVehiclesCount() : int
      {
         return this._compatibleVehiclesCount;
      }
      
      public function set compatibleVehiclesCount(param1:int) : void
      {
         this._compatibleVehiclesCount = param1;
      }
      
      public function get isEvent() : Boolean
      {
         return this._isEvent;
      }
      
      public function set isEvent(param1:Boolean) : void
      {
         this._isEvent = param1;
      }
      
      public function get isLegionaries() : Boolean
      {
         return this._isLegionaries;
      }
      
      public function set isLegionaries(param1:Boolean) : void
      {
         this._isLegionaries = param1;
      }
      
      public function get isLocked() : Boolean
      {
         return this._isLocked;
      }
      
      public function set isLocked(param1:Boolean) : void
      {
         this._isLocked = param1;
      }
      
      public function get restrictions() : Array
      {
         return this._restrictions;
      }
      
      public function set restrictions(param1:Array) : void
      {
         this._restrictions = param1;
      }
   }
}
