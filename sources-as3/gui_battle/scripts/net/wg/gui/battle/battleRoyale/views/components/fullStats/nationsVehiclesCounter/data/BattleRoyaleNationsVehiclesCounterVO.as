package net.wg.gui.battle.battleRoyale.views.components.fullStats.nationsVehiclesCounter.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class BattleRoyaleNationsVehiclesCounterVO extends DAAPIDataClass
   {
      
      private static const VEHICLES_FIELD:String = "vehicles";
       
      
      private var _vehicles:Vector.<BattleRoyaleNationsVehiclesVO> = null;
      
      public function BattleRoyaleNationsVehiclesCounterVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         if(param1 == VEHICLES_FIELD)
         {
            if(this._vehicles && this._vehicles.length > 0)
            {
               this._vehicles.splice(0,this._vehicles.length);
            }
            else
            {
               this._vehicles = new Vector.<BattleRoyaleNationsVehiclesVO>();
            }
            _loc3_ = param2 as Array;
            if(_loc3_ != null)
            {
               for each(_loc4_ in _loc3_)
               {
                  this._vehicles.push(new BattleRoyaleNationsVehiclesVO(_loc4_));
               }
            }
            else
            {
               App.utils.asserter.assert(param2 is Array,param1 + " must be an Array");
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this._vehicles)
         {
            this._vehicles.splice(0,this._vehicles.length);
            this._vehicles = null;
         }
         super.onDispose();
      }
      
      public function get vehicles() : Vector.<BattleRoyaleNationsVehiclesVO>
      {
         return this._vehicles;
      }
   }
}
