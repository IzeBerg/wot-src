package net.wg.gui.lobby.questsWindow.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class PaddingsVO extends DAAPIDataClass
   {
       
      
      public var left:int = 0;
      
      public var right:int = 0;
      
      public var top:int = 0;
      
      public var bottom:int = 0;
      
      public function PaddingsVO(param1:Object)
      {
         super(param1);
      }
   }
}
