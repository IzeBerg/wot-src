package net.wg.gui.lobby.settings.feedback.ribbons.data
{
   public class RibbonItemData
   {
       
      
      public var ribbonType:String = "";
      
      public var text:String = "";
      
      public var vehName:String = "";
      
      public var vehType:String = "";
      
      public var value:String = "";
      
      public function RibbonItemData(param1:String, param2:String, param3:String = "", param4:String = "", param5:String = "")
      {
         super();
         this.ribbonType = param1;
         this.text = param2;
         this.vehName = param4;
         this.vehType = param5;
         this.value = param3;
      }
   }
}
