package net.wg.gui.components.advanced.collapsingBar.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class CollapsingBarButtonVO extends DAAPIDataClass
   {
       
      
      public var id:int = -1;
      
      public var tooltip:String = "";
      
      public var label:String = "";
      
      public function CollapsingBarButtonVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
