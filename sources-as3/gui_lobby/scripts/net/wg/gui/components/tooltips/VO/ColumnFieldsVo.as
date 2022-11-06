package net.wg.gui.components.tooltips.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ColumnFieldsVo extends DAAPIDataClass
   {
       
      
      public var name:String = "";
      
      public var columns:Array = null;
      
      public function ColumnFieldsVo(param1:Object)
      {
         super(param1);
      }
   }
}
