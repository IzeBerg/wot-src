package net.wg.gui.battle.mapsTraining.views.mapsTrainingMessagesPanel
{
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import net.wg.gui.battle.views.gameMessagesPanel.GameMessagesPanel;
   import net.wg.gui.battle.views.gameMessagesPanel.components.EndGameMessage;
   import net.wg.gui.battle.views.gameMessagesPanel.components.MessageContainerBase;
   import net.wg.infrastructure.base.meta.IGameMessagesPanelMeta;
   
   public class MapsTrainingMessagesPanel extends GameMessagesPanel implements IGameMessagesPanelMeta
   {
      
      private static const MAX_WIDTH:int = 900;
      
      private static const FONT_SIZE:int = 73;
       
      
      public function MapsTrainingMessagesPanel()
      {
         super();
      }
      
      private static function layoutFunc(param1:TextField) : void
      {
         param1.width = MAX_WIDTH;
         var _loc2_:TextFormat = param1.getTextFormat();
         _loc2_.size = FONT_SIZE;
         param1.setTextFormat(_loc2_);
         param1.multiline = true;
         param1.autoSize = TextFieldAutoSize.CENTER;
         App.utils.commons.updateTextFieldSize(param1,true,false);
         param1.x = -(param1.width >> 1);
      }
      
      override protected function layoutMessage(param1:MessageContainerBase) : void
      {
         super.layoutMessage(param1);
         var _loc2_:EndGameMessage = param1 as EndGameMessage;
         if(_loc2_)
         {
            _loc2_.layoutMessage(layoutFunc);
         }
      }
   }
}
