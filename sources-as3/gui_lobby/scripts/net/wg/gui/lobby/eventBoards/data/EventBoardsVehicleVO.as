package net.wg.gui.lobby.eventBoards.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class EventBoardsVehicleVO extends DAAPIDataClass
   {
       
      
      public var id:Number = NaN;
      
      public var typeIconPath:String = "";
      
      public var nationIconPath:String = "";
      
      public var level:int = -1;
      
      public var vehicleName:String = "";
      
      public var smallVehicleIconPath:String = "";
      
      public var isInHangar:Boolean = false;
      
      public function EventBoardsVehicleVO(param1:Object)
      {
         super(param1);
      }
   }
}
