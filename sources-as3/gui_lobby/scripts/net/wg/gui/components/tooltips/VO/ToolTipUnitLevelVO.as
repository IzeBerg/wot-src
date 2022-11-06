package net.wg.gui.components.tooltips.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ToolTipUnitLevelVO extends DAAPIDataClass
   {
       
      
      public var statusMsg:String = "";
      
      public var statusLevel:String = "";
      
      public var header:String = "";
      
      public var description:String = "";
      
      public var level:String = "";
      
      public var icon:String = "";
      
      public var levelDescription:String = "";
      
      public function ToolTipUnitLevelVO(param1:Object)
      {
         super(param1);
      }
   }
}
