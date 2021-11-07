package net.wg.gui.lobby.vehicleCompare.data
{
   import net.wg.data.constants.Errors;
   
   public class VehicleCompareConfiguratorVO extends VehicleCompareConfiguratorInitDataVO
   {
      
      private static const CREW_LEVELS:String = "crewLevels";
       
      
      public var enableTopModules:Boolean = false;
      
      public var enableCamo:Boolean = true;
      
      public var showAttentionIcon:Boolean = false;
      
      private var _crewLevels:Vector.<VehCompareCrewLevelVO>;
      
      public function VehicleCompareConfiguratorVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(param1 == CREW_LEVELS)
         {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_,CREW_LEVELS + Errors.CANT_NULL);
            _loc4_ = _loc3_.length;
            this.clearCrewLevels();
            this._crewLevels = new Vector.<VehCompareCrewLevelVO>(_loc4_,true);
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               this._crewLevels[_loc5_] = new VehCompareCrewLevelVO(_loc3_[_loc5_]);
               _loc5_++;
            }
            return false;
         }
         return true;
      }
      
      override protected function onDispose() : void
      {
         this.clearCrewLevels();
         super.onDispose();
      }
      
      private function clearCrewLevels() : void
      {
         if(this._crewLevels)
         {
            this._crewLevels.fixed = false;
            this._crewLevels.splice(0,this._crewLevels.length);
            this._crewLevels = null;
         }
      }
      
      public function get crewLevels() : Vector.<VehCompareCrewLevelVO>
      {
         return this._crewLevels;
      }
   }
}
