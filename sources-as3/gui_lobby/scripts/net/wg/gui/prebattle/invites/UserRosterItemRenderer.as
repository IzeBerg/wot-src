package net.wg.gui.prebattle.invites
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import net.wg.data.constants.UserTags;
   import net.wg.gui.components.controls.SoundListItemRenderer;
   import net.wg.gui.components.controls.VoiceWave;
   import net.wg.gui.messenger.data.ContactVO;
   import net.wg.infrastructure.managers.ITooltipMgr;
   
   public class UserRosterItemRenderer extends SoundListItemRenderer
   {
      
      private static const DOTS_STR:String = "..";
      
      private static const STATE_UP:String = "up";
      
      private static const STATE_OVER:String = "over";
      
      private static const LABEL_IGNORED:String = "ignored";
      
      private static const LABEL_HIMSELF:String = "himself";
      
      private static const LABEL_ONLINE:String = "online";
      
      private static const LABEL_OFFLINE:String = "offline";
      
      private static const UPDATE_DATA:String = "update_data";
       
      
      public var focusIndicatorA:MovieClip;
      
      public var status:MovieClip;
      
      public var voiceWave:VoiceWave;
      
      private var _model:ContactVO = null;
      
      private var _textColor:uint = 0;
      
      private var _toolTipMgr:ITooltipMgr;
      
      public function UserRosterItemRenderer()
      {
         this._toolTipMgr = App.toolTipMgr;
         super();
         toggle = true;
         selectable = true;
         allowDeselect = false;
         this.visible = false;
         _state = STATE_UP;
      }
      
      override protected function handleMouseRollOver(param1:MouseEvent) : void
      {
         super.handleMouseRollOver(param1);
         if(this._model)
         {
            this._toolTipMgr.show(this._model.fullName);
         }
      }
      
      override protected function handleMouseRollOut(param1:MouseEvent) : void
      {
         super.handleMouseRollOut(param1);
         this._toolTipMgr.hide();
      }
      
      override protected function configUI() : void
      {
         if(this.focusIndicatorA)
         {
            focusIndicator = this.focusIndicatorA;
         }
         super.configUI();
         this.voiceWave.visible = App.voiceChatMgr.isVOIPEnabledS();
         this.voiceWave.validateNow();
      }
      
      override protected function onDispose() : void
      {
         this._toolTipMgr.hide();
         if(this.voiceWave)
         {
            this.voiceWave.dispose();
            this.voiceWave = null;
         }
         this._toolTipMgr = null;
         this.status = null;
         this.focusIndicatorA = null;
         this._model = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc2_:Point = null;
         var _loc1_:Boolean = isInvalid(UPDATE_DATA) && this._model;
         if(_loc1_ && enabled)
         {
            _loc2_ = new Point(mouseX,mouseY);
            _loc2_ = localToGlobal(_loc2_);
            if(hitTestPoint(_loc2_.x,_loc2_.y,true))
            {
               setState(STATE_OVER);
               App.soundMgr.playControlsSnd(state,soundType,soundId);
               dispatchEvent(new MouseEvent(MouseEvent.ROLL_OVER));
            }
         }
         super.draw();
         if(_loc1_)
         {
            this.afterSetData();
         }
      }
      
      override public function setData(param1:Object) : void
      {
         if(param1 == null)
         {
            this.visible = false;
            return;
         }
         this._model = new ContactVO(param1);
         if(this._model.dbID)
         {
            this.visible = true;
            invalidate(UPDATE_DATA);
         }
      }
      
      override public function set label(param1:String) : void
      {
         param1 = this.cutText(param1);
         super.label = param1;
      }
      
      private function afterSetData() : void
      {
         if(this.status == null)
         {
            return;
         }
         this.status.visible = false;
         if(!this._model)
         {
            return;
         }
         var _loc1_:String = this._model.fullName;
         var _loc2_:Array = this._model.tags;
         this.label = _loc1_;
         if(UserTags.isIgnored(_loc2_) || UserTags.isMuted(_loc2_))
         {
            this.status.gotoAndPlay(LABEL_IGNORED);
            this.status.visible = true;
            if(this._model.colors[1] != null)
            {
               textField.textColor = this._model.colors[1];
               this._textColor = this._model.colors[1];
            }
         }
         else
         {
            if(UserTags.isCurrentPlayer(_loc2_))
            {
               if(this._model.colors[0] != null)
               {
                  textField.textColor = this._model.colors[0];
                  this._textColor = this._model.colors[0];
               }
               this.status.gotoAndPlay(LABEL_HIMSELF);
            }
            else if(this._model.isOnline)
            {
               if(this._model.colors[0] != null)
               {
                  textField.textColor = this._model.colors[0];
                  this._textColor = this._model.colors[0];
               }
               this.status.gotoAndPlay(LABEL_ONLINE);
            }
            else
            {
               if(this._model.colors[1] != null)
               {
                  textField.textColor = this._model.colors[1];
                  this._textColor = this._model.colors[1];
               }
               this.status.gotoAndPlay(LABEL_OFFLINE);
            }
            this.status.visible = true;
         }
         this.updateVoiceWave();
         invalidate();
      }
      
      override protected function updateAfterStateChange() : void
      {
         var _loc1_:Array = null;
         var _loc2_:Boolean = false;
         var _loc3_:Boolean = false;
         if(this._model == null)
         {
            return;
         }
         if(!initialized || this._model == null)
         {
            return;
         }
         if(this._model)
         {
            _loc1_ = this._model.tags;
            _loc2_ = UserTags.isMuted(_loc1_);
            _loc3_ = UserTags.isIgnored(_loc1_);
            this.updateVoiceWave();
            if(_loc3_ || _loc2_)
            {
               if(this._model.colors[1] != null)
               {
                  textField.textColor = this._model.colors[1];
                  this._textColor = this._model.colors[1];
               }
            }
            else if(this._model.isOnline)
            {
               if(this._model.colors[0] != null)
               {
                  textField.textColor = this._model.colors[0];
                  this._textColor = this._model.colors[0];
               }
            }
            else if(this._model.colors[1] != null)
            {
               textField.textColor = this._model.colors[1];
               this._textColor = this._model.colors[1];
            }
         }
         super.updateAfterStateChange();
      }
      
      protected function updateVoiceWave() : void
      {
         this.voiceWave.visible = App.voiceChatMgr.isVOIPEnabledS();
         this.voiceWave.setMuted(UserTags.isMuted(this._model.tags));
         this.voiceWave.validateNow();
      }
      
      private function cutText(param1:String) : String
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         textField.htmlText = param1;
         if(textField.getLineLength(1) != -1)
         {
            _loc2_ = param1;
            _loc3_ = textField.getLineLength(0);
            _loc2_ = _loc2_.substr(0,_loc3_ - 2);
            _loc2_ += DOTS_STR;
            textField.textColor = this._textColor;
            textField.htmlText = _loc2_;
         }
         return textField.htmlText;
      }
      
      override protected function updateText() : void
      {
         if(label != null)
         {
            textField.htmlText = label;
            textField.textColor = this._textColor;
         }
      }
   }
}
