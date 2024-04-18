package net.wg.gui.lobby.missions.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class HeaderDescBlockVO extends DAAPIDataClass
   {
       
      
      public var descr:String = "";
      
      public var period:String = "";
      
      public var hasCalendarIcon:Boolean = false;
      
      public var isMultiline:Boolean = false;
      
      public function HeaderDescBlockVO(param1:Object)
      {
         super(param1);
      }
   }
}
