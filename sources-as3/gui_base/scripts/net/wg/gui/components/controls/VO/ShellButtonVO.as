package net.wg.gui.components.controls.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ShellButtonVO extends DAAPIDataClass
   {
       
      
      public var id:String = "";
      
      public var enabled:Boolean = true;
      
      public var type:String = "";
      
      public var icon:String = "";
      
      public var count:int = -1;
      
      public var inventoryCount:int = 0;
      
      public var label:String = "";
      
      public var tooltip:String = "";
      
      public var tooltipType:String = "";
      
      public function ShellButtonVO(param1:Object)
      {
         super(param1);
      }
   }
}
