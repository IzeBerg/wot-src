package net.wg.gui.lobby.eventBoards.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.data.DataProvider;
   
   public class EventBoardsVehiclesOverlayVO extends DAAPIDataClass
   {
      
      private static const VEHICLES:String = "vehicles";
       
      
      public var bgPath:String = "";
      
      public var title:String = "";
      
      private var _vehicles:DataProvider = null;
      
      public function EventBoardsVehiclesOverlayVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc4_:Object = null;
         var _loc3_:Object = null;
         if(param1 == VEHICLES)
         {
            this._vehicles = new DataProvider();
            for each(_loc4_ in param2)
            {
               this._vehicles.push(new EventBoardsVehicleVO(_loc4_));
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         if(this._vehicles)
         {
            for each(_loc1_ in this._vehicles)
            {
               _loc1_.dispose();
            }
            this._vehicles.cleanUp();
            this._vehicles = null;
         }
         super.onDispose();
      }
      
      public function get vehicles() : DataProvider
      {
         return this._vehicles;
      }
   }
}
