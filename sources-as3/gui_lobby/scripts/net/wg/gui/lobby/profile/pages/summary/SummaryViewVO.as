package net.wg.gui.lobby.profile.pages.summary
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class SummaryViewVO extends DAAPIDataClass
   {
       
      
      public var description:String = "";
      
      public var icon:String = "";
      
      public function SummaryViewVO(param1:Object)
      {
         super(param1);
      }
   }
}
