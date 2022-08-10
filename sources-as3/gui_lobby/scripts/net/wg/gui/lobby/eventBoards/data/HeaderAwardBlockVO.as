package net.wg.gui.lobby.eventBoards.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class HeaderAwardBlockVO extends DAAPIDataClass
   {
       
      
      public var title:String = "";
      
      public var uiIcon:String = "";
      
      public var label:String = "";
      
      public var iconTooltip:String = "";
      
      public var buttonTooltip:String = "";
      
      public function HeaderAwardBlockVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
