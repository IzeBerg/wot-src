package net.wg.gui.battle.battleRoyale.views.components.fullStats.nationsVehiclesCounter.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class BattleRoyaleNationsVehiclesCounterVO extends DAAPIDataClass
   {
      
      private static const NATIONS_VEHICLES:String = "nationsVehicles";
       
      
      private var _nationsVehicles:Vector.<BattleRoyaleNationsVehiclesVO> = null;
      
      public function BattleRoyaleNationsVehiclesCounterVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         if(param1 == NATIONS_VEHICLES)
         {
            if(this._nationsVehicles && this._nationsVehicles.length > 0)
            {
               this._nationsVehicles.splice(0,this._nationsVehicles.length);
            }
            else
            {
               this._nationsVehicles = new Vector.<BattleRoyaleNationsVehiclesVO>();
            }
            _loc3_ = param2 as Array;
            if(_loc3_ != null)
            {
               for each(_loc4_ in _loc3_)
               {
                  this._nationsVehicles.push(new BattleRoyaleNationsVehiclesVO(_loc4_));
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
         if(this._nationsVehicles)
         {
            this._nationsVehicles.splice(0,this._nationsVehicles.length);
            this._nationsVehicles = null;
         }
         super.onDispose();
      }
      
      public function get nationsVehicles() : Vector.<BattleRoyaleNationsVehiclesVO>
      {
         return this._nationsVehicles;
      }
   }
}
