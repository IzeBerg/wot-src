package net.wg.gui.cyberSport.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class CSIndicatorData extends DAAPIDataClass
   {
       
      
      public var value:String = "";
      
      public var description:String = "";
      
      public var iconSource:String = "";
      
      public var tooltip:String = "";
      
      public var enabled:Boolean = true;
      
      public function CSIndicatorData(param1:Object)
      {
         super(param1);
      }
   }
}
