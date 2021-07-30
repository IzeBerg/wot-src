package net.wg.gui.battle.views.ammunitionPanel
{
   import flash.events.Event;
   
   public class PrbAmmunitionPanelEvent extends Event
   {
      
      public static const VIEW_HIDDEN:String = "onViewHidden";
      
      public static const VIEW_SHOWN:String = "onViewShown";
       
      
      public var useAnim:Boolean = false;
      
      public function PrbAmmunitionPanelEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.useAnim = param2;
      }
      
      override public function clone() : Event
      {
         return new PrbAmmunitionPanelEvent(type,this.useAnim,bubbles,cancelable);
      }
   }
}
