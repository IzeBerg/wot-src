package net.wg.gui.lobby.hangar.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class HeaderQuestsVO extends DAAPIDataClass
   {
       
      
      public var enable:Boolean = false;
      
      public var flag:String = "";
      
      public var flagDisabled:String = "";
      
      public var icon:String = "";
      
      public var stateIcon:String = "";
      
      public var label:String = "";
      
      public var questType:String = "";
      
      public var questID:String = "";
      
      public var isReward:Boolean = false;
      
      public var tooltip:String = "";
      
      public var isTooltipSpecial:Boolean = false;
      
      public var isTooltipWulf:Boolean = false;
      
      public function HeaderQuestsVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
