package net.wg.gui.lobby.components.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class PrimeTimeVO extends DAAPIDataClass
   {
       
      
      public var serverDDVisible:Boolean = false;
      
      public var status:String = "";
      
      public var serversDDEnabled:Boolean = false;
      
      public var warningIconSrc:String = "";
      
      public var serversText:String = "";
      
      public var timeText:String = "";
      
      public var showAlertBG:Boolean = false;
      
      public function PrimeTimeVO(param1:Object)
      {
         super(param1);
      }
   }
}
