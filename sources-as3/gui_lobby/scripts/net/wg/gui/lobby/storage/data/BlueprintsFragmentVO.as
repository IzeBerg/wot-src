package net.wg.gui.lobby.storage.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class BlueprintsFragmentVO extends DAAPIDataClass
   {
       
      
      public var iconSmall:String = "";
      
      public var iconBig:String = "";
      
      public var hasFragments:Boolean = false;
      
      public var label:String = "";
      
      public var tooltipData:uint = 0;
      
      public function BlueprintsFragmentVO(param1:Object)
      {
         super(param1);
      }
   }
}
