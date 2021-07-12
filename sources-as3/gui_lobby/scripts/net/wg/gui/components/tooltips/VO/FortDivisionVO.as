package net.wg.gui.components.tooltips.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class FortDivisionVO extends DAAPIDataClass
   {
       
      
      public var name:String = "";
      
      public var descr:String = "";
      
      public var warning:String = "";
      
      public var params:Array = null;
      
      public function FortDivisionVO(param1:Object)
      {
         super(param1);
      }
   }
}
