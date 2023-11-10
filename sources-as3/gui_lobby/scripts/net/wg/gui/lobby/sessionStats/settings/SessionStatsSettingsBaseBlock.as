package net.wg.gui.lobby.sessionStats.settings
{
   import flash.text.TextField;
   import net.wg.gui.components.advanced.DashLine;
   import net.wg.gui.lobby.sessionStats.helpers.SessionStatsHelper;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class SessionStatsSettingsBaseBlock extends UIComponentEx
   {
       
      
      public var title:TextField = null;
      
      public var dashLine:DashLine = null;
      
      public function SessionStatsSettingsBaseBlock()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         if(this.dashLine != null)
         {
            this.dashLine.x = 0;
            this.dashLine.width = SessionStatsHelper.TOTAL_WIDTH;
         }
      }
      
      override protected function onDispose() : void
      {
         if(this.dashLine != null)
         {
            this.dashLine.dispose();
            this.dashLine = null;
         }
         this.title = null;
         super.onDispose();
      }
   }
}
