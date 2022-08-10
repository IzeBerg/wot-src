package net.wg.gui.lobby.battleMatters.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class LinkedSetDetailsContainerVO extends DAAPIDataClass
   {
       
      
      public var title:String = "";
      
      public var linkage:String = "";
      
      public var bgWidth:int = -1;
      
      public var bgHeight:int = -1;
      
      public function LinkedSetDetailsContainerVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
