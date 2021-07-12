package net.wg.data.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ButtonPropertiesVO extends DAAPIDataClass
   {
       
      
      public var btnVisible:Boolean = false;
      
      public var btnEnabled:Boolean = false;
      
      public var btnTooltip:String = "";
      
      public var btnLabel:String = "";
      
      public var btnIcon:String = "";
      
      public function ButtonPropertiesVO(param1:Object)
      {
         super(param1);
      }
   }
}
