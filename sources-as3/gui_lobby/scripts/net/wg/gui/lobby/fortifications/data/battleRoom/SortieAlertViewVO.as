package net.wg.gui.lobby.fortifications.data.battleRoom
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class SortieAlertViewVO extends DAAPIDataClass
   {
       
      
      public var icon:String = "";
      
      public var titleMsg:String = "";
      
      public var bodyMsg:String = "";
      
      public var buttonLbl:String = "";
      
      public function SortieAlertViewVO(param1:Object)
      {
         super(param1);
      }
   }
}
