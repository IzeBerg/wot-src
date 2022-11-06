package net.wg.gui.lobby.techtree.data.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class TechTreeNationMenuItemVO extends DAAPIDataClass
   {
       
      
      public var label:String = "";
      
      public var tooltip:String = "";
      
      public var isTooltipSpecial:Boolean = false;
      
      public var hasDiscount:Boolean = false;
      
      public function TechTreeNationMenuItemVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
