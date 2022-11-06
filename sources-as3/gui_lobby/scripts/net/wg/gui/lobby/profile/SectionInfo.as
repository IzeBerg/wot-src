package net.wg.gui.lobby.profile
{
   public class SectionInfo
   {
       
      
      public var label:String = "";
      
      public var linkage:String = "";
      
      public var alias:String = "";
      
      public var tooltip:String = "";
      
      public var enabled:Boolean = true;
      
      public function SectionInfo(param1:String, param2:String, param3:String, param4:String, param5:Boolean)
      {
         super();
         this.label = param3;
         this.linkage = param2;
         this.alias = param1;
         this.tooltip = param4;
         this.enabled = param5;
      }
   }
}
