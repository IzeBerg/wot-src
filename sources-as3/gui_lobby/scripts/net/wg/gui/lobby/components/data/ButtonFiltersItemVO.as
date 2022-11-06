package net.wg.gui.lobby.components.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ButtonFiltersItemVO extends DAAPIDataClass
   {
       
      
      public var icon:String = "";
      
      public var filterValue:int = -1;
      
      public var selected:Boolean = true;
      
      public var tooltip:String = "";
      
      public var label:String = "";
      
      public function ButtonFiltersItemVO(param1:Object)
      {
         super(param1);
      }
   }
}
