package net.wg.gui.lobby.personalMissions.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class PawnedSheetVO extends DAAPIDataClass
   {
       
      
      public var taskText:String = "";
      
      public var descrText:String = "";
      
      public var taskId:String = "";
      
      public var animDelay:int = -1;
      
      public function PawnedSheetVO(param1:Object)
      {
         super(param1);
      }
   }
}
