package net.wg.gui.lobby.modulesPanel.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ListOverlayVO extends DAAPIDataClass
   {
       
      
      public var iconSmall:String = "";
      
      public var iconBig:String = "";
      
      public var titleText:String = "";
      
      public var descText:String = "";
      
      public var okBtnLabel:String = "";
      
      public var displayOkBtn:Boolean = true;
      
      public var isClickEnabled:Boolean = true;
      
      public function ListOverlayVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
