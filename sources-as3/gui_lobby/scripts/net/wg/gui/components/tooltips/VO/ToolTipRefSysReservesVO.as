package net.wg.gui.components.tooltips.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ToolTipRefSysReservesVO extends DAAPIDataClass
   {
       
      
      public var moduleLabel:String = "";
      
      public var infoTitle:String = "";
      
      public var infoDescription:String = "";
      
      public var infoLevel:String = "";
      
      public var infoCount:String = "";
      
      public var infoDescription1:String = "";
      
      public var infoDescription2:String = "";
      
      public var infoDescription3:String = "";
      
      public var infoStatus:String = "";
      
      public var level:int = -1;
      
      public function ToolTipRefSysReservesVO(param1:Object)
      {
         super(param1);
      }
   }
}
