package net.wg.gui.components.tooltips.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class FortClanCommonInfoVO extends DAAPIDataClass
   {
       
      
      public var clanName:String = "";
      
      public var slogan:String = "";
      
      public var statValues:String = "";
      
      public var statDescriptions:String = "";
      
      public var bottomInfoText:String = "";
      
      public var isClanActive:Boolean = false;
      
      public function FortClanCommonInfoVO(param1:Object)
      {
         super(param1);
      }
   }
}
