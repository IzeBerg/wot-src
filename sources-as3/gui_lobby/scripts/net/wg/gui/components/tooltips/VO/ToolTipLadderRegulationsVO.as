package net.wg.gui.components.tooltips.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ToolTipLadderRegulationsVO extends DAAPIDataClass
   {
       
      
      public var name:String = "";
      
      public var thisRules:String = "";
      
      public var rulesName:String = "";
      
      public var allRules:String = "";
      
      public var info:String = "";
      
      public var hasRules:Boolean = false;
      
      public function ToolTipLadderRegulationsVO(param1:Object)
      {
         super(param1);
      }
   }
}
