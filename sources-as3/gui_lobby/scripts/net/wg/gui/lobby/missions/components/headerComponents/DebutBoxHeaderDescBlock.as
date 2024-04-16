package net.wg.gui.lobby.missions.components.headerComponents
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.lobby.missions.event.MissionHeaderEvent;
   import scaleform.clik.constants.InvalidationType;
   
   public class DebutBoxHeaderDescBlock extends HeaderDescBlock
   {
      
      private static const TF1_NAME:String = "captionTF1";
      
      private static const TF2_NAME:String = "captionTF2";
      
      private static const TF3_NAME:String = "captionTF3";
      
      private static const DISABLED_TF_NAME:String = "captionDisabledTF";
       
      
      public var captionContainer:MovieClip;
      
      public var disabledContainer:MovieClip;
      
      public var infoBtn:SoundButtonEx;
      
      private var _captionTF1:TextField;
      
      private var _captionTF2:TextField;
      
      private var _captionTF3:TextField;
      
      private var _captionDisabledTF:TextField;
      
      private var _isEnabled:Boolean;
      
      public function DebutBoxHeaderDescBlock()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.infoBtn.removeEventListener(MouseEvent.CLICK,this.onInfoMouseButtonClick);
         this.infoBtn.dispose();
         this.infoBtn = null;
         this.captionContainer = null;
         this._captionTF1 = null;
         this._captionTF2 = null;
         this._captionTF3 = null;
         this.disabledContainer = null;
         this._captionDisabledTF = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.captionContainer.mouseEnabled = this.captionContainer.mouseChildren = false;
         this.infoBtn.constraintsDisabled = true;
         this.infoBtn.buttonMode = true;
         this.infoBtn.addEventListener(MouseEvent.CLICK,this.onInfoMouseButtonClick);
         this.infoBtn.label = QUESTS.DEBUTBOXES_MISSIONS_HEADER_INFO;
         this._captionTF1 = this.captionContainer.getChildByName(TF1_NAME) as TextField;
         this._captionTF2 = this.captionContainer.getChildByName(TF2_NAME) as TextField;
         this._captionTF3 = this.captionContainer.getChildByName(TF3_NAME) as TextField;
         this._captionDisabledTF = this.disabledContainer.getChildByName(DISABLED_TF_NAME) as TextField;
         this._captionTF1.text = QUESTS.DEBUTBOXES_MISSIONS_HEADER_CAPTION1;
         this._captionTF2.text = QUESTS.DEBUTBOXES_MISSIONS_HEADER_CAPTION2;
         this._captionTF3.text = QUESTS.DEBUTBOXES_MISSIONS_HEADER_CAPTION3;
         this._captionDisabledTF.text = QUESTS.DEBUTBOXES_MISSIONS_HEADER_DISABLED;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.captionContainer.visible = this.infoBtn.visible = calendar.visible = descText.visible = this._isEnabled;
            this.disabledContainer.visible = !this._isEnabled;
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.captionContainer.x = width - this.captionContainer.width >> 1;
            this.disabledContainer.x = width - this.disabledContainer.width >> 1;
            this.infoBtn.x = this.captionContainer.x;
         }
      }
      
      public function set isEnabled(param1:Boolean) : void
      {
         if(this._isEnabled != param1)
         {
            this._isEnabled = param1;
            invalidateData();
         }
      }
      
      private function onInfoMouseButtonClick(param1:MouseEvent) : void
      {
         dispatchEvent(new MissionHeaderEvent(MissionHeaderEvent.OPEN_INFO_PAGE,true));
      }
   }
}
