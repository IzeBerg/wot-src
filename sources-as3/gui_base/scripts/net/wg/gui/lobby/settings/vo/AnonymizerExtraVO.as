package net.wg.gui.lobby.settings.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class AnonymizerExtraVO extends DAAPIDataClass
   {
       
      
      public var checkBoxLabel:String = "";
      
      public var tooltip:String = "";
      
      public var visible:Boolean = false;
      
      public var enabled:Boolean = false;
      
      public function AnonymizerExtraVO(param1:Object)
      {
         super(param1);
      }
   }
}
