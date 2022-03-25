package net.wg.gui.battle.commander.views.commanderHelp
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.components.BattleUIComponent;
   
   public class ButtonKeyContainer extends BattleUIComponent
   {
      
      private static const MIN_KEY_BG_WIDTH:uint = 25;
      
      private static const TEXTFIELD_PADDING:uint = 15;
      
      private static const PLUS_SECOND_KEY_OFFSET:uint = 4;
      
      private static const MULTI_KEY_CONTENT_WIDTH_PADDING:uint = 21;
       
      
      public var regularKeyTF:TextField = null;
      
      public var activeKeyTF:TextField = null;
      
      public var regularKeyBG:MovieClip = null;
      
      public var activeKeyBG:MovieClip = null;
      
      public var secondKeyMC:MovieClip = null;
      
      private var _primaryKeyValueID:uint = 4.294967295E9;
      
      private var _primaryKeyText:String = "";
      
      private var _multiKeySupport:Boolean = false;
      
      private var _isActiveState:Boolean = false;
      
      public function ButtonKeyContainer()
      {
         super();
         mouseEnabled = false;
         this.regularKeyTF.autoSize = TextFieldAutoSize.LEFT;
         this.activeKeyTF.autoSize = TextFieldAutoSize.LEFT;
      }
      
      override protected function onDispose() : void
      {
         this.regularKeyTF = null;
         this.activeKeyTF = null;
         this.regularKeyBG = null;
         this.activeKeyBG = null;
         this.secondKeyMC = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:uint = 0;
         super.draw();
         if(isInvalid(InvalidationType.STATE))
         {
            this.regularKeyTF.visible = !this._isActiveState;
            this.regularKeyBG.visible = !this._isActiveState;
            this.activeKeyTF.visible = this._isActiveState;
            this.activeKeyBG.visible = this._isActiveState;
            this.secondKeyMC.visible = this._multiKeySupport;
         }
         if(isInvalid(InvalidationType.DATA))
         {
            if(this._primaryKeyText != "")
            {
               this.activeKeyTF.text = this.regularKeyTF.text = this._primaryKeyText;
            }
            else
            {
               this.activeKeyTF.text = this.regularKeyTF.text = App.utils.commons.keyToString(this._primaryKeyValueID).keyName;
            }
            App.utils.commons.updateTextFieldSize(this.activeKeyTF);
            App.utils.commons.updateTextFieldSize(this.regularKeyTF);
            _loc1_ = Math.max(MIN_KEY_BG_WIDTH,this.activeKeyTF.textWidth + TEXTFIELD_PADDING | 0);
            this.activeKeyBG.width = this.regularKeyBG.width = _loc1_;
            if(this._multiKeySupport)
            {
               this.activeKeyBG.x = this.regularKeyBG.x = -(_loc1_ + MULTI_KEY_CONTENT_WIDTH_PADDING >> 1);
               this.activeKeyTF.x = this.regularKeyTF.x = this.activeKeyBG.x + (_loc1_ - this.activeKeyTF.textWidth >> 1);
               this.secondKeyMC.x = this.activeKeyBG.x + _loc1_ + PLUS_SECOND_KEY_OFFSET;
            }
            else
            {
               this.activeKeyBG.x = this.regularKeyBG.x = -(_loc1_ >> 1);
               this.activeKeyTF.x = this.regularKeyTF.x = -(this.regularKeyTF.textWidth >> 1);
            }
         }
      }
      
      public function setActiveState(param1:Boolean) : void
      {
         if(this._isActiveState == param1)
         {
            return;
         }
         this._isActiveState = param1;
         invalidateState();
      }
      
      public function setKeyValue(param1:uint, param2:String, param3:Boolean) : void
      {
         this._primaryKeyValueID = param1;
         this._primaryKeyText = param2;
         this._multiKeySupport = param3;
         invalidateData();
         invalidateState();
      }
   }
}
