package net.wg.gui.lobby.personalMissions.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class SheetsInfoBlockVO extends DAAPIDataClass
   {
       
      
      public var imgSource:String = "";
      
      public var titleText:String = "";
      
      public var descrText:String = "";
      
      public function SheetsInfoBlockVO(param1:Object)
      {
         super(param1);
      }
   }
}
