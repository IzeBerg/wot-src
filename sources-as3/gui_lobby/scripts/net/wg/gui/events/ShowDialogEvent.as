package net.wg.gui.events
{
   import flash.events.Event;
   
   public class ShowDialogEvent extends Event
   {
      
      public static const SHOW_MESSAGE_DIALOG:String = "showMessageDialog";
      
      public static const SHOW_BERTH_BUY_DIALOG:String = "showBerthBuyDialog";
      
      public static const SHOW_DISSMISS_TANKMAN_DIALOG:String = "showDismissTankmanDialog";
       
      
      public var id:String;
      
      public function ShowDialogEvent(param1:String, param2:String = "")
      {
         super(param1,true,true);
         this.id = param2;
      }
      
      override public function clone() : Event
      {
         return new ShowDialogEvent(type,this.id);
      }
   }
}
