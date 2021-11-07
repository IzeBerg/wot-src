package net.wg.gui.battle.battleRoyale.views.components.fullStats.nationsVehiclesCounter.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import scaleform.clik.data.DataProvider;
   
   public class BattleRoyaleNationsVehiclesVO extends DAAPIDataClass
   {
      
      private static const _PLATOONS:String = "platoons";
       
      
      public var nation:String = "";
      
      private var _platoons:DataProvider = null;
      
      public function BattleRoyaleNationsVehiclesVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == _PLATOONS)
         {
            if(this._platoons && this._platoons.length > 0)
            {
               this._platoons.splice(0,this._platoons.length);
            }
            else
            {
               this._platoons = new DataProvider(param2 as Array);
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this._platoons)
         {
            this._platoons.splice(0,this._platoons.length);
            this._platoons = null;
         }
         super.onDispose();
      }
      
      public function get platoons() : DataProvider
      {
         return this._platoons;
      }
      
      public function get platoonsAlive() : String
      {
         var _loc2_:Object = null;
         var _loc1_:uint = 0;
         for each(_loc2_ in this._platoons)
         {
            if(!_loc2_.isDead)
            {
               _loc1_++;
            }
         }
         return _loc1_.toString();
      }
   }
}
