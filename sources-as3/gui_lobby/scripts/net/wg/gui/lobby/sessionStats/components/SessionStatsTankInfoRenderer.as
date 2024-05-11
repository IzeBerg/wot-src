package net.wg.gui.lobby.sessionStats.components
{
   import flash.events.Event;
   import flash.text.TextField;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.lobby.sessionStats.data.SessionStatsTankInfoParamVO;
   import scaleform.clik.controls.ListItemRenderer;
   
   public class SessionStatsTankInfoRenderer extends ListItemRenderer
   {
       
      
      public var icon:Image = null;
      
      public var textTf:TextField = null;
      
      public function SessionStatsTankInfoRenderer()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.icon.addEventListener(Event.CHANGE,this.onIconChangeHandler);
      }
      
      override public function setData(param1:Object) : void
      {
         super.setData(param1);
         var _loc2_:SessionStatsTankInfoParamVO = SessionStatsTankInfoParamVO(param1);
         this.icon.source = _loc2_.icon;
         this.textTf.htmlText = _loc2_.text;
      }
      
      override protected function onDispose() : void
      {
         this.icon.removeEventListener(Event.CHANGE,this.onIconChangeHandler);
         this.icon.dispose();
         this.icon = null;
         this.textTf = null;
         super.onDispose();
      }
      
      private function onIconChangeHandler(param1:Event) : void
      {
         this.icon.x = -this.icon.width >> 1;
         this.icon.y = height - this.icon.height >> 1;
      }
   }
}
