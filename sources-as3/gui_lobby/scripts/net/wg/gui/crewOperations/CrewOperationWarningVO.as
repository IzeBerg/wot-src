package net.wg.gui.crewOperations
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class CrewOperationWarningVO extends DAAPIDataClass
   {
       
      
      public var operationAvailable:Boolean;
      
      public var tooltipId:String = "";
      
      public function CrewOperationWarningVO(param1:Object)
      {
         super(param1);
      }
   }
}
