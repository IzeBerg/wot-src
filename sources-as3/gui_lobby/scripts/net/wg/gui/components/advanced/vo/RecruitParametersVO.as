package net.wg.gui.components.advanced.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class RecruitParametersVO extends DAAPIDataClass
   {
       
      
      public var enabled:Boolean;
      
      public var selectedIndex:int;
      
      public var data:Array;
      
      public function RecruitParametersVO(param1:Object)
      {
         super(param1);
      }
   }
}
