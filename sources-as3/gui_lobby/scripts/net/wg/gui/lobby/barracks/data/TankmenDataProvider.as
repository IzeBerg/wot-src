package net.wg.gui.lobby.barracks.data
{
   import net.wg.data.daapi.base.DAAPIDataProvider;
   
   public class TankmenDataProvider extends DAAPIDataProvider
   {
       
      
      public function TankmenDataProvider()
      {
         super();
      }
      
      override public function requestItemAt(param1:uint, param2:Function = null) : Object
      {
         var _loc3_:Object = super.requestItemAt(param1,param2);
         return new BarracksTankmanVO(_loc3_);
      }
      
      override public function requestItemRange(param1:int, param2:int, param3:Function = null) : Array
      {
         var _loc6_:Object = null;
         var _loc4_:Array = super.requestItemRange(param1,param2);
         var _loc5_:Array = [];
         for each(_loc6_ in _loc4_)
         {
            _loc5_.push(new BarracksTankmanVO(_loc6_));
         }
         if(param3 != null)
         {
            param3(_loc5_);
         }
         return _loc5_;
      }
   }
}
