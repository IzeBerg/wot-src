package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.rally.views.room.BaseRallyRoomViewWithWaiting;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class CyberSportUnitMeta extends BaseRallyRoomViewWithWaiting
   {
       
      
      public var toggleFreezeRequest:Function;
      
      public var toggleStatusRequest:Function;
      
      public var showSettingsRoster:Function;
      
      public var resultRosterSlotsSettings:Function;
      
      public var cancelRosterSlotsSettings:Function;
      
      public var lockSlotRequest:Function;
      
      private var _array1:Array;
      
      private var _array2:Array;
      
      public function CyberSportUnitMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._array1)
         {
            this._array1.splice(0,this._array1.length);
            this._array1 = null;
         }
         if(this._array2)
         {
            this._array2.splice(0,this._array2.length);
            this._array2 = null;
         }
         super.onDispose();
      }
      
      public function toggleFreezeRequestS() : void
      {
         App.utils.asserter.assertNotNull(this.toggleFreezeRequest,"toggleFreezeRequest" + Errors.CANT_NULL);
         this.toggleFreezeRequest();
      }
      
      public function toggleStatusRequestS() : void
      {
         App.utils.asserter.assertNotNull(this.toggleStatusRequest,"toggleStatusRequest" + Errors.CANT_NULL);
         this.toggleStatusRequest();
      }
      
      public function showSettingsRosterS(param1:Object) : void
      {
         App.utils.asserter.assertNotNull(this.showSettingsRoster,"showSettingsRoster" + Errors.CANT_NULL);
         this.showSettingsRoster(param1);
      }
      
      public function resultRosterSlotsSettingsS(param1:Array) : void
      {
         App.utils.asserter.assertNotNull(this.resultRosterSlotsSettings,"resultRosterSlotsSettings" + Errors.CANT_NULL);
         this.resultRosterSlotsSettings(param1);
      }
      
      public function cancelRosterSlotsSettingsS() : void
      {
         App.utils.asserter.assertNotNull(this.cancelRosterSlotsSettings,"cancelRosterSlotsSettings" + Errors.CANT_NULL);
         this.cancelRosterSlotsSettings();
      }
      
      public function lockSlotRequestS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.lockSlotRequest,"lockSlotRequest" + Errors.CANT_NULL);
         this.lockSlotRequest(param1);
      }
      
      public final function as_updateSlotSettings(param1:Array) : void
      {
         var _loc2_:Array = this._array1;
         this._array1 = param1;
         this.updateSlotSettings(this._array1);
         if(_loc2_)
         {
            _loc2_.splice(0,_loc2_.length);
         }
      }
      
      public final function as_lockUnit(param1:Boolean, param2:Array) : void
      {
         var _loc3_:Array = this._array2;
         this._array2 = param2;
         this.lockUnit(param1,this._array2);
         if(_loc3_)
         {
            _loc3_.splice(0,_loc3_.length);
         }
      }
      
      protected function updateSlotSettings(param1:Array) : void
      {
         var _loc2_:String = "as_updateSlotSettings" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function lockUnit(param1:Boolean, param2:Array) : void
      {
         var _loc3_:String = "as_lockUnit" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc3_);
         throw new AbstractException(_loc3_);
      }
   }
}
