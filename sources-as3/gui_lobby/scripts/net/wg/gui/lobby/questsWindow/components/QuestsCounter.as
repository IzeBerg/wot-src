package net.wg.gui.lobby.questsWindow.components
{
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class QuestsCounter extends UIComponentEx
   {
       
      
      public var textField:TextField;
      
      public function QuestsCounter()
      {
         super();
      }
      
      private static function showCounterTooltip(param1:MouseEvent) : void
      {
         App.toolTipMgr.show(TOOLTIPS.QUESTS_COUNTER_LABEL);
      }
      
      private static function hideTooltip(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(MouseEvent.CLICK,hideTooltip);
         addEventListener(MouseEvent.ROLL_OUT,hideTooltip);
         addEventListener(MouseEvent.ROLL_OVER,showCounterTooltip);
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.CLICK,hideTooltip);
         removeEventListener(MouseEvent.ROLL_OUT,hideTooltip);
         removeEventListener(MouseEvent.ROLL_OVER,showCounterTooltip);
         this.textField = null;
         super.onDispose();
      }
   }
}
