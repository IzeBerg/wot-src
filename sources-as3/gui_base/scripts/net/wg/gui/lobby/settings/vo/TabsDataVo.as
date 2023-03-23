package net.wg.gui.lobby.settings.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class TabsDataVo extends DAAPIDataClass
   {
       
      
      public var label:String = "";
      
      public var linkage:String = "";
      
      public var alias:String = "";
      
      public function TabsDataVo(param1:Object)
      {
         super(param1);
      }
   }
}
