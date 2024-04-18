package net.wg.gui.lobby.sessionStats.components
{
   import flash.text.TextField;
   import net.wg.gui.components.controls.Image;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class SessionStatsRateComponent extends UIComponentEx
   {
       
      
      public var txtValue:TextField = null;
      
      public var txtDelta:TextField = null;
      
      public var imgRate:Image = null;
      
      public function SessionStatsRateComponent()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.imgRate.dispose();
         this.imgRate = null;
         this.txtValue = null;
         this.txtDelta = null;
         super.onDispose();
      }
      
      public function set value(param1:String) : void
      {
         this.txtValue.htmlText = param1;
      }
      
      public function set delta(param1:String) : void
      {
         this.txtDelta.htmlText = param1;
      }
      
      public function set icon(param1:String) : void
      {
         this.imgRate.source = param1;
      }
   }
}
