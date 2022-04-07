package net.wg.gui.lobby.battleResults.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class TabInfoVO extends DAAPIDataClass
   {
       
      
      public var label:String = "";
      
      public var linkage:String = "";
      
      public var viewId:String = "";
      
      public var showWndBg:Boolean = false;
      
      public function TabInfoVO(param1:Object)
      {
         super(param1);
      }
   }
}
