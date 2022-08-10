package net.wg.gui.lobby.battleResults.components
{
   import flash.text.TextField;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.lobby.battleResults.data.AlertMessageVO;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class AlertMessage extends UIComponentEx
   {
       
      
      public var icon:UILoaderAlt;
      
      public var textTF:TextField;
      
      public function AlertMessage()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.icon.dispose();
         this.icon = null;
         this.textTF = null;
         super.onDispose();
      }
      
      public function setData(param1:AlertMessageVO) : void
      {
         this.icon.source = param1.icon;
         this.textTF.htmlText = param1.text;
         App.utils.commons.updateTextFieldSize(this.textTF,false,true);
         height = actualHeight;
      }
   }
}
