package net.wg.gui.battle.battleloading.data
{
   import flash.events.Event;
   import net.wg.data.VO.daapi.DAAPIInvitationStatusVO;
   import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
   import net.wg.data.VO.daapi.DAAPIVehicleStatsVO;
   import net.wg.data.VO.daapi.DAAPIVehicleUserTagsVO;
   import net.wg.gui.battle.battleloading.interfaces.IVehiclesDataProvider;
   import net.wg.infrastructure.events.ListDataProviderEvent;
   import scaleform.clik.data.DataProvider;
   
   public class VehiclesDataProvider extends DataProvider implements IVehiclesDataProvider
   {
      
      private static const ERROR_VEHICLE_MISSING:String = "Vehicle not found in dataProvider";
       
      
      protected var vehicleIDs:Vector.<Number>;
      
      private var _updatedItems:Vector.<int>;
      
      public function VehiclesDataProvider(param1:Array = null)
      {
         super(param1);
      }
      
      override public function cleanUp() : void
      {
         var _loc1_:DAAPIVehicleInfoVO = null;
         App.stage.removeEventListener(Event.ENTER_FRAME,this.onValidateHandler);
         for each(_loc1_ in this)
         {
            _loc1_.dispose();
         }
         if(this._updatedItems)
         {
            this._updatedItems.length = 0;
            this._updatedItems = null;
         }
         super.cleanUp();
      }
      
      override public function invalidate(param1:uint = 0) : void
      {
         App.stage.addEventListener(Event.ENTER_FRAME,this.onValidateHandler);
      }
      
      override protected function parseSource(param1:Array) : void
      {
         var _loc5_:DAAPIVehicleInfoVO = null;
         var _loc2_:int = this.length;
         this.cleanUp();
         this.vehicleIDs = new Vector.<Number>(0);
         this._updatedItems = new Vector.<int>(0);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            this._updatedItems[_loc3_] = _loc3_;
            _loc3_++;
         }
         if(param1 == null)
         {
            return;
         }
         var _loc4_:uint = param1.length;
         var _loc6_:uint = 0;
         while(_loc6_ < _loc4_)
         {
            _loc5_ = this.makeVO(param1[_loc6_]);
            this[_loc6_] = _loc5_;
            this.vehicleIDs.push(_loc5_.vehicleID);
            this.addUpdatedIndex(_loc6_);
            _loc6_++;
         }
      }
      
      public function addVehiclesInfo(param1:Vector.<DAAPIVehicleInfoVO>, param2:Vector.<Number>) : Boolean
      {
         var _loc3_:DAAPIVehicleInfoVO = null;
         if(param1 == null || param2 == null)
         {
            return false;
         }
         for each(_loc3_ in param1)
         {
            this.addUpdatedIndex(push(this.makeVO(_loc3_)) - 1);
         }
         this.setSorting(param2);
         return true;
      }
      
      public function setPlayerStatus(param1:Number, param2:Number) : Boolean
      {
         var _loc3_:int = this.vehicleIDs.indexOf(param1);
         var _loc4_:DAAPIVehicleInfoVO = this[_loc3_] as DAAPIVehicleInfoVO;
         if(_loc4_ != null && _loc4_.playerStatus != param2)
         {
            _loc4_.playerStatus = param2;
            this.addUpdatedIndex(_loc3_);
            return true;
         }
         return false;
      }
      
      public function setSorting(param1:Vector.<Number>) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         this.vehicleIDs.splice(0,this.vehicleIDs.length);
         this.vehicleIDs = param1.slice();
         sort(this.compare);
         return true;
      }
      
      public function setSpeaking(param1:Number, param2:Boolean) : Boolean
      {
         var _loc3_:DAAPIVehicleInfoVO = null;
         for each(_loc3_ in this)
         {
            if(_loc3_.accountDBID == param1)
            {
               if(_loc3_.isSpeaking != param2)
               {
                  _loc3_.isSpeaking = param2;
                  this.addUpdatedIndex(indexOf(_loc3_));
                  return true;
               }
               return false;
            }
         }
         return false;
      }
      
      public function setUserTags(param1:Vector.<DAAPIVehicleUserTagsVO>) : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc3_:DAAPIVehicleUserTagsVO = null;
         var _loc4_:int = 0;
         var _loc5_:DAAPIVehicleInfoVO = null;
         for each(_loc3_ in param1)
         {
            _loc4_ = this.vehicleIDs.indexOf(_loc3_.vehicleID);
            _loc5_ = this[_loc4_] as DAAPIVehicleInfoVO;
            if(_loc5_ != null)
            {
               _loc5_.userTags = Boolean(_loc3_.userTags) ? _loc3_.userTags.concat() : null;
               _loc2_ = true;
               this.addUpdatedIndex(_loc4_);
            }
         }
         return _loc2_;
      }
      
      public function setVehicleStatus(param1:Number, param2:Number) : Boolean
      {
         var _loc3_:int = this.vehicleIDs.indexOf(param1);
         var _loc4_:DAAPIVehicleInfoVO = this[_loc3_] as DAAPIVehicleInfoVO;
         if(_loc4_ != null && _loc4_.vehicleStatus != param2)
         {
            _loc4_.vehicleStatus = param2;
            this.addUpdatedIndex(_loc3_);
            return true;
         }
         return false;
      }
      
      public function updateFrags(param1:Vector.<DAAPIVehicleStatsVO>) : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc3_:DAAPIVehicleStatsVO = null;
         var _loc4_:int = 0;
         var _loc5_:DAAPIVehicleInfoVO = null;
         for each(_loc3_ in param1)
         {
            _loc4_ = this.vehicleIDs.indexOf(_loc3_.vehicleID);
            _loc5_ = this[_loc4_] as DAAPIVehicleInfoVO;
            if(_loc5_ != null && _loc5_.frags != _loc3_.frags)
            {
               _loc5_.frags = _loc3_.frags;
               _loc2_ = true;
               this.addUpdatedIndex(_loc4_);
            }
         }
         return _loc2_;
      }
      
      public function updateInvitationsStatuses(param1:Vector.<DAAPIInvitationStatusVO>) : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc3_:DAAPIInvitationStatusVO = null;
         var _loc4_:int = 0;
         var _loc5_:DAAPIVehicleInfoVO = null;
         for each(_loc3_ in param1)
         {
            _loc4_ = this.vehicleIDs.indexOf(_loc3_.vehicleID);
            _loc5_ = this[_loc4_] as DAAPIVehicleInfoVO;
            if(_loc5_ != null && _loc5_.invitationStatus != _loc3_.status)
            {
               _loc5_.invitationStatus = _loc3_.status;
               _loc2_ = true;
               this.addUpdatedIndex(_loc4_);
            }
         }
         return _loc2_;
      }
      
      public function updateVehiclesInfo(param1:Vector.<DAAPIVehicleInfoVO>) : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc3_:DAAPIVehicleInfoVO = null;
         var _loc4_:int = 0;
         for each(_loc3_ in param1)
         {
            _loc4_ = this.vehicleIDs.indexOf(_loc3_.vehicleID);
            if(this[_loc4_])
            {
               this[_loc4_].update(_loc3_);
               _loc2_ = true;
               this.addUpdatedIndex(_loc4_);
            }
            else
            {
               DebugUtils.LOG_ERROR(ERROR_VEHICLE_MISSING,_loc3_);
            }
         }
         return _loc2_;
      }
      
      protected function makeVO(param1:Object) : DAAPIVehicleInfoVO
      {
         return DAAPIVehicleInfoVO(param1).clone();
      }
      
      protected function addUpdatedIndex(param1:int) : void
      {
         if(this._updatedItems.indexOf(param1) == -1)
         {
            this._updatedItems.push(param1);
         }
      }
      
      private function compare(param1:DAAPIVehicleInfoVO, param2:DAAPIVehicleInfoVO) : Number
      {
         var _loc3_:int = this.vehicleIDs.indexOf(param1.vehicleID);
         var _loc4_:int = this.vehicleIDs.indexOf(param2.vehicleID);
         if(_loc3_ > _loc4_)
         {
            this.addUpdatedIndex(_loc3_);
            this.addUpdatedIndex(_loc4_);
            return 1;
         }
         if(_loc3_ < _loc4_)
         {
            this.addUpdatedIndex(_loc3_);
            this.addUpdatedIndex(_loc4_);
            return -1;
         }
         return 0;
      }
      
      private function onValidateHandler(param1:Event) : void
      {
         App.stage.removeEventListener(Event.ENTER_FRAME,this.onValidateHandler);
         if(this._updatedItems.length > 0)
         {
            dispatchEvent(new ListDataProviderEvent(ListDataProviderEvent.VALIDATE_ITEMS,-1,this._updatedItems));
            this._updatedItems.length = 0;
         }
      }
   }
}
