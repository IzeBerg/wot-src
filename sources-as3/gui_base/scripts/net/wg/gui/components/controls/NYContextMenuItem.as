package net.wg.gui.components.controls
{
   import flash.display.Sprite;
   import net.wg.data.constants.generated.CONTACTS_ACTION_CONSTS;
   
   public class NYContextMenuItem extends ContextMenuItem
   {
      
      private static const TF_COLOR_NY:uint = 13434879;
       
      
      public var nyBg:Sprite;
      
      public function NYContextMenuItem()
      {
         super();
         this.nyBg.visible = false;
      }
      
      override public function setData(param1:Object) : void
      {
         super.setData(param1);
         invalidateData();
      }
      
      override protected function setMainState() : void
      {
         super.setMainState();
         this.nyBg.visible = id == CONTACTS_ACTION_CONSTS.NY_SEND_GIFT;
      }
      
      override protected function onDispose() : void
      {
         this.nyBg = null;
         super.onDispose();
      }
      
      override public function set id(param1:String) : void
      {
         super.id = param1;
         if(id == CONTACTS_ACTION_CONSTS.NY_SEND_GIFT)
         {
            this.nyBg.visible = true;
            textColor = TF_COLOR_NY;
         }
      }
   }
}
