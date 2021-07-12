package net.wg.gui.lobby.questsWindow.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class PersonalInfoVO extends DAAPIDataClass
   {
       
      
      public var text:String = "";
      
      public var statusText:String = "";
      
      public function PersonalInfoVO(param1:Object)
      {
         super(param1);
      }
   }
}
