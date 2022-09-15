package net.wg.gui.lobby.vehiclePreview.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class VPPageBaseVO extends DAAPIDataClass
   {
       
      
      public var closeBtnLabel:String = "";
      
      public var backBtnLabel:String = "";
      
      public var backBtnDescrLabel:String = "";
      
      public var showCloseBtn:Boolean = true;
      
      public var showBackButton:Boolean = true;
      
      public function VPPageBaseVO(param1:Object)
      {
         super(param1);
      }
   }
}
