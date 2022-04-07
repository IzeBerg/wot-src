package net.wg.gui.lobby.window
{
   import flash.text.TextField;
   import net.wg.infrastructure.base.meta.IPunishmentDialogMeta;
   import net.wg.infrastructure.base.meta.impl.PunishmentDialogMeta;
   
   public class PunishmentDialog extends PunishmentDialogMeta implements IPunishmentDialogMeta
   {
       
      
      public var msgTitle:TextField;
      
      public function PunishmentDialog()
      {
         super();
      }
      
      public function as_setMsgTitle(param1:String) : void
      {
         this.msgTitle.text = param1;
      }
   }
}
