package net.wg.gui.lobby.badges.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class BadgeSuffixItemVO extends DAAPIDataClass
   {
       
      
      public var id:int = 0;
      
      public var label:String = "";
      
      public var activeLabel:String = "";
      
      public var tooltip:String = "";
      
      public var stripImg:String = "";
      
      public var img:String = "";
      
      public var hasFootnoteMark:Boolean = false;
      
      public function BadgeSuffixItemVO(param1:Object)
      {
         super(param1);
      }
   }
}
