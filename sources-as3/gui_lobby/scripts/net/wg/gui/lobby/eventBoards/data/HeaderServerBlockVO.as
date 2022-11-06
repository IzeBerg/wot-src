package net.wg.gui.lobby.eventBoards.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class HeaderServerBlockVO extends DAAPIDataClass
   {
       
      
      public var title:String = "";
      
      public var buttons:Array;
      
      public function HeaderServerBlockVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
