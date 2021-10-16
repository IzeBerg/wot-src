package net.wg.gui.battle.views.damagePanel.components
{
   import flash.text.TextField;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.generated.BATTLE_ITEM_STATES;
   import scaleform.gfx.TextFieldEx;
   
   public class FireIndicator extends DamagePanelItemFrameStates
   {
       
      
      public var fireMessage:TextField;
      
      private var _text:String = "";
      
      public function FireIndicator()
      {
         super();
         TextFieldEx.setNoTranslate(this.fireMessage,true);
      }
      
      override protected function onDispose() : void
      {
         this.fireMessage = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            if(state == BATTLE_ITEM_STATES.NORMAL)
            {
               gotoAndStop(1);
            }
         }
         if(isInvalid(InvalidationType.STATE) && this.fireMessage != null)
         {
            this.fireMessage.text = this._text;
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         gotoAndStop(1);
         var _loc1_:int = totalFrames - 2;
         addFrameScript(_loc1_,this.hide);
      }
      
      private function hide() : void
      {
         visible = false;
      }
      
      public function get text() : String
      {
         return this._text;
      }
      
      public function set text(param1:String) : void
      {
         this._text = param1;
         invalidateData();
      }
   }
}
