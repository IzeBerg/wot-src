package net.wg.gui.prebattle.controls
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import net.wg.data.constants.UserTags;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.SoundListItemRenderer;
   import net.wg.gui.components.controls.VoiceWave;
   import net.wg.gui.prebattle.constants.PrebattleStateString;
   import net.wg.gui.prebattle.data.PlayerPrbInfoVO;
   import net.wg.infrastructure.events.VoiceChatEvent;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.utils.Constraints;
   
   public class TeamMemberRendererBase extends SoundListItemRenderer
   {
      
      private static var UPDATE_STATUS:String = "updateStatus";
       
      
      public var vehicleLevelField:TextField;
      
      public var status:MovieClip;
      
      public var vehicleNameField:TextField;
      
      public var voiceWave:VoiceWave;
      
      private var _statusString:String = null;
      
      private var _playerNameStr:String = "";
      
      private var currentDbID:Number = -1;
      
      private const NEXT_LINE_TOOLTIP:String = "\n\n";
      
      public function TeamMemberRendererBase()
      {
         super();
         soundType = "squads";
      }
      
      override public function setData(param1:Object) : void
      {
         if(param1 == null)
         {
            this.setSpeakers(false,true);
            visible = false;
         }
         else
         {
            if(this.data && this.currentDbID == param1.dbID)
            {
               param1.isPlayerSpeaking = this.data.isPlayerSpeaking;
            }
            this.currentDbID = param1.dbID;
            if(!visible)
            {
               visible = true;
            }
         }
         this.data = param1;
         invalidate(UPDATE_STATUS);
      }
      
      override protected function updateText() : void
      {
         var _loc1_:TextFormat = textField.getTextFormat();
         var _loc2_:Object = _loc1_.size;
         var _loc3_:String = _loc1_.font;
         var _loc4_:String = _loc1_.align;
         textField.htmlText = this._playerNameStr;
         _loc1_.size = _loc2_;
         _loc1_.font = _loc3_;
         _loc1_.align = _loc4_;
         textField.setTextFormat(_loc1_);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.voiceWave.visible = App.voiceChatMgr.isVOIPEnabledS();
         App.voiceChatMgr.addEventListener(VoiceChatEvent.START_SPEAKING,this.speakHandler);
         App.voiceChatMgr.addEventListener(VoiceChatEvent.STOP_SPEAKING,this.speakHandler);
         constraints.addElement("status",this.status,Constraints.ALL);
         constraints.addElement("vehicleNameField",this.vehicleNameField,Constraints.ALL);
      }
      
      override protected function onDispose() : void
      {
         App.voiceChatMgr.removeEventListener(VoiceChatEvent.START_SPEAKING,this.speakHandler);
         App.voiceChatMgr.removeEventListener(VoiceChatEvent.STOP_SPEAKING,this.speakHandler);
         this.vehicleLevelField = null;
         this.status = null;
         this.vehicleNameField = null;
         this.voiceWave.dispose();
         this.voiceWave = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(UPDATE_STATUS))
         {
            this.afterSetData();
         }
      }
      
      override protected function updateAfterStateChange() : void
      {
         super.updateAfterStateChange();
         if(!initialized)
         {
            return;
         }
         if(this.model && this.model.vLevel != null && this.model.vLevel != Values.EMPTY_STR)
         {
            this.vehicleLevelField.text = this.model.vLevel;
         }
         else
         {
            this.vehicleLevelField.text = Values.EMPTY_STR;
         }
         this.vehicleNameField.htmlText = this.model && this.model.vShortName ? this.model.vShortName : Values.EMPTY_STR;
         this.updateVoiceWave();
         var _loc1_:Number = Boolean(this.model) ? Number(this.model.getCurrentColor()) : Number(Number.NaN);
         if(!isNaN(_loc1_))
         {
            textField.textColor = _loc1_;
            this.vehicleNameField.textColor = _loc1_;
            this.vehicleLevelField.textColor = _loc1_;
         }
      }
      
      public function onPlayerSpeak(param1:Number, param2:Boolean) : void
      {
         if(this.model && param1 == this.model.dbID)
         {
            if(data && this.model && this.currentDbID == data.dbID)
            {
               this.model.isPlayerSpeaking = param2;
            }
            this.setSpeakers(param2);
         }
      }
      
      protected function updatePlayerName() : void
      {
         if(this.model && this.model.dbID != -1)
         {
            App.utils.commons.formatPlayerName(textField,App.utils.commons.getUserProps(this.model.userName,this.model.clanAbbrev,this.model.region,this.model.igrType,this.model.tags));
         }
         else if(this.model)
         {
            textField.text = this.model.fullName;
         }
         else
         {
            textField.text = Values.EMPTY_STR;
         }
         this._playerNameStr = textField.htmlText;
      }
      
      protected function afterSetData() : void
      {
         this.updatePlayerName();
         if(this.status)
         {
            this.status.visible = false;
            if(this.model == null)
            {
               return;
            }
            this.setSpeakers(this.model.isPlayerSpeaking,true);
            textField.alpha = this.vehicleNameField.alpha = 1;
            var _loc1_:String = this.model.getStateString();
            if(_loc1_ != PrebattleStateString.UNKNOWN)
            {
               this._statusString = _loc1_;
               this.status.gotoAndPlay(_loc1_);
               if(this.model.isOffline())
               {
                  textField.alpha = this.vehicleNameField.alpha = 0.9;
               }
               this.status.visible = true;
               if(this.hitTestPoint(mouseX,mouseY,true))
               {
                  this.showToolTips();
               }
            }
            var _loc2_:Number = 4290295975;
            var _loc3_:Number = _loc2_;
            this.updateVoiceWave();
            _loc3_ = this.model.getCurrentColor();
            if(!isNaN(_loc3_))
            {
               textField.textColor = _loc3_;
               this.vehicleNameField.textColor = _loc3_;
               this.vehicleLevelField.textColor = _loc3_;
            }
            if(this.model.vLevel != null && this.model.vLevel != Values.EMPTY_STR)
            {
               this.vehicleLevelField.text = this.model.vLevel;
            }
            else
            {
               this.vehicleLevelField.text = Values.EMPTY_STR;
            }
            this.updateAfterStateChange();
            return;
         }
      }
      
      protected function showToolTips() : void
      {
         var _loc1_:String = this.model.accID == -1 ? MESSENGER.DIALOGS_TEAMCHANNEL_BUTTONS_INVITE : this.getToolTipData();
         if(_loc1_ && _loc1_.length > 0)
         {
            App.toolTipMgr.show(_loc1_);
         }
      }
      
      protected function getToolTipData() : String
      {
         var _loc1_:String = Values.EMPTY_STR;
         if(StringUtils.isNotEmpty(this._statusString))
         {
            if(this._statusString == PrebattleStateString.OFFLINE_READY)
            {
               this._statusString = PrebattleStateString.OFFLINE;
            }
            _loc1_ = App.utils.locale.makeString(MESSENGER.getSquadChannelTooltipsStatus(this._statusString));
            if(this.model.isExperimentalModule)
            {
               _loc1_ += this.NEXT_LINE_TOOLTIP + App.utils.locale.makeString(MESSENGER.DIALOGS_SQUADCHANNEL_TOOLTIPS_MODULE,{"name":this.model.experimentalModuleName});
            }
         }
         return _loc1_;
      }
      
      protected function updateVoiceWave() : void
      {
         this.voiceWave.visible = App.voiceChatMgr.isVOIPEnabledS();
         this.voiceWave.setMuted(Boolean(this.model) ? Boolean(UserTags.isMuted(this.model.tags)) : Boolean(false));
      }
      
      protected function setSpeakers(param1:Boolean, param2:Boolean = false) : void
      {
         if(param1)
         {
            param2 = false;
         }
         if(this.voiceWave is VoiceWave)
         {
            this.voiceWave.setSpeaking(param1,param2);
         }
      }
      
      public function get model() : PlayerPrbInfoVO
      {
         return data as PlayerPrbInfoVO;
      }
      
      override protected function handleMouseRollOver(param1:MouseEvent) : void
      {
         super.handleMouseRollOver(param1);
         this.showToolTips();
      }
      
      override protected function handleMouseRollOut(param1:MouseEvent) : void
      {
         super.handleMouseRollOut(param1);
         App.toolTipMgr.hide();
      }
      
      private function speakHandler(param1:VoiceChatEvent) : void
      {
         this.onPlayerSpeak(param1.getAccountDBID(),param1.type == VoiceChatEvent.START_SPEAKING);
      }
      
      public function set statusString(param1:String) : void
      {
         this._statusString = param1;
      }
   }
}
