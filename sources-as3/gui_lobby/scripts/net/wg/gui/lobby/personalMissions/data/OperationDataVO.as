package net.wg.gui.lobby.personalMissions.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class OperationDataVO extends DAAPIDataClass
   {
       
      
      public var id:int = -1;
      
      public var pmType:int = -1;
      
      public var state:String = "";
      
      public var icon:String = "";
      
      public var postponedTime:String = "";
      
      public var enabled:Boolean = true;
      
      public var tooltipAlias:String = "";
      
      public function OperationDataVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
