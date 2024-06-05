package net.wg.gui.lobby.profile.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class SectionInfoVO extends DAAPIDataClass
   {
       
      
      public var label:String = "";
      
      public var linkage:String = "";
      
      public var alias:String = "";
      
      public var tooltip:String = "";
      
      public var enabled:Boolean = true;
      
      public var id:String = "";
      
      public function SectionInfoVO(param1:Object)
      {
         super(param1);
      }
   }
}
