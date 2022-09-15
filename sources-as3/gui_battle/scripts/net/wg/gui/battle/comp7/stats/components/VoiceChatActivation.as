package net.wg.gui.battle.comp7.stats.components
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.comp7.stats.components.data.VoiceChatActivationVO;
   import net.wg.gui.battle.comp7.stats.components.events.VoiceChatActivationEvent;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.utils.ICommons;
   
   public class VoiceChatActivation extends BattleUIComponent
   {
      
      public static const INACTIVE_STATE:String = "inactive";
      
      public static const ACTIVE_STATE:String = "active";
       
      
      public var textField:TextField = null;
      
      public var textFieldHover:TextField = null;
      
      public var hitMc:Sprite = null;
      
      private var _data:VoiceChatActivationVO = null;
      
      private var _isActive:Boolean = false;
      
      private var _commons:ICommons;
      
      public function VoiceChatActivation()
      {
         this._commons = App.utils.commons;
         super();
         visible = false;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.hitMc.addEventListener(MouseEvent.CLICK,this.onClickHandler);
         this.hitMc.addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         this.hitMc.addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this.hitMc.useHandCursor = this.hitMc.buttonMode = true;
         this.textField.visible = true;
         this.textFieldHover.visible = false;
      }
      
      override protected function draw() : void
      {
         var _loc1_:String = null;
         super.draw();
         if(this._data != null && isInvalid(InvalidationType.DATA))
         {
            gotoAndStop(!!this._isActive ? ACTIVE_STATE : INACTIVE_STATE);
            _loc1_ = !!this._isActive ? this._data.activeText : this._data.inactiveText;
            this.textField.htmlText = _loc1_;
            this.textFieldHover.htmlText = _loc1_;
            this._commons.updateTextFieldSize(this.textField,true,false);
            this._commons.updateTextFieldSize(this.textFieldHover,true,false);
            this.hitMc.width = this.textField.x + this.textField.textWidth | 0;
         }
      }
      
      override protected function onDispose() : void
      {
         this.hitMc.removeEventListener(MouseEvent.CLICK,this.onClickHandler);
         this.hitMc.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         this.hitMc.removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this.textField = null;
         this.textFieldHover = null;
         this.hitMc = null;
         this._data = null;
         this._commons = null;
         super.onDispose();
      }
      
      public function setData(param1:VoiceChatActivationVO) : void
      {
         if(this._data != param1 && param1 != null)
         {
            this._data = param1;
            invalidate(InvalidationType.DATA);
         }
      }
      
      public function setIsActive(param1:Boolean) : void
      {
         if(this._isActive != param1)
         {
            this._isActive = param1;
            invalidate(InvalidationType.DATA);
         }
      }
      
      private function onClickHandler(param1:MouseEvent) : void
      {
         dispatchEvent(new VoiceChatActivationEvent(VoiceChatActivationEvent.CONTROL_CLICKED));
      }
      
      private function onRollOverHandler(param1:MouseEvent) : void
      {
         this.textField.visible = false;
         this.textFieldHover.visible = true;
      }
      
      private function onRollOutHandler(param1:MouseEvent) : void
      {
         this.textField.visible = true;
         this.textFieldHover.visible = false;
      }
   }
}
