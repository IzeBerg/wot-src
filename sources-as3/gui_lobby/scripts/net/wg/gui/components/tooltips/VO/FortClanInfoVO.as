package net.wg.gui.components.tooltips.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class FortClanInfoVO extends DAAPIDataClass
   {
       
      
      public var headerText:String = "";
      
      public var infoText:String = "";
      
      public var fullClanName:String = "";
      
      public var fortCreationDate:String = "";
      
      public var sloganText:String = "";
      
      public var infoDescriptionBottomText:String = "";
      
      public var infoDescriptionTopText:String = "";
      
      public var infoTopText:String = "";
      
      public var infoBottomText:String = "";
      
      public var protectionHeaderText:String = "";
      
      public function FortClanInfoVO(param1:Object)
      {
         super(param1);
      }
   }
}
