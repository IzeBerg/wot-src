package net.wg.gui.lobby.eventBoards.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class HeaderReloginBlockVO extends DAAPIDataClass
   {
       
      
      public var title:String = "";
      
      public var description:String = "";
      
      public var descriptionTooltip:String = "";
      
      public function HeaderReloginBlockVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
