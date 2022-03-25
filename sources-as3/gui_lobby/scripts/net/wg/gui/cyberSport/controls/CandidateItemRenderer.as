package net.wg.gui.cyberSport.controls
{
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.Cursors;
   import net.wg.data.constants.UserTags;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.advanced.InviteIndicator;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.components.controls.SoundListItemRenderer;
   import net.wg.gui.components.controls.UserNameField;
   import net.wg.gui.components.controls.VoiceWave;
   import net.wg.gui.rally.events.RallyViewsEvent;
   import net.wg.gui.rally.vo.RallyCandidateVO;
   import net.wg.infrastructure.events.VoiceChatEvent;
   import net.wg.infrastructure.interfaces.entity.IDropItem;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.infrastructure.managers.IVoiceChatManager;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   
   public class CandidateItemRenderer extends SoundListItemRenderer implements IDropItem, IUpdatable
   {
      
      private static const BADGE_OFFSET_Y:int = -2;
       
      
      public var inviteIndicator:InviteIndicator = null;
      
      public var candidateName:UserNameField = null;
      
      public var candidateRating:TextField = null;
      
      public var voiceWave:VoiceWave = null;
      
      public var statusIcon:Image = null;
      
      private var _cadidateData:RallyCandidateVO = null;
      
      private var _voiceChatMgr:IVoiceChatManager = null;
      
      private var _tooltipMgr:ITooltipMgr = null;
      
      private var _candidateNameY:int = -1;
      
      private var _candidateWitdBadgeY:int = -1;
      
      public function CandidateItemRenderer()
      {
         super();
         this._voiceChatMgr = App.voiceChatMgr;
         this._tooltipMgr = App.toolTipMgr;
         this.inviteIndicator.visible = false;
         this.candidateRating.visible = false;
         this.candidateName.visible = false;
         if(this.statusIcon != null)
         {
            this.statusIcon.visible = false;
         }
         this.doubleClickEnabled = true;
         this._candidateNameY = this.candidateName.y;
         this._candidateWitdBadgeY = this._candidateNameY + BADGE_OFFSET_Y;
      }
      
      override public function setData(param1:Object) : void
      {
         super.setData(param1);
         this._cadidateData = RallyCandidateVO(param1);
         invalidateData();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.voiceWave.visible = App.voiceChatMgr.isVOIPEnabledS();
         this._voiceChatMgr.addEventListener(VoiceChatEvent.START_SPEAKING,this.onVoiceChatMgrStartSpeakingHandler);
         this._voiceChatMgr.addEventListener(VoiceChatEvent.STOP_SPEAKING,this.onVoiceChatMgrStopSpeakingHandler);
         addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         addEventListener(MouseEvent.DOUBLE_CLICK,this.onDoubleClickHandler);
      }
      
      override protected function onDispose() : void
      {
         this._voiceChatMgr.removeEventListener(VoiceChatEvent.START_SPEAKING,this.onVoiceChatMgrStartSpeakingHandler);
         this._voiceChatMgr.removeEventListener(VoiceChatEvent.STOP_SPEAKING,this.onVoiceChatMgrStopSpeakingHandler);
         removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         removeEventListener(MouseEvent.DOUBLE_CLICK,this.onDoubleClickHandler);
         this.voiceWave.dispose();
         this.voiceWave = null;
         this.inviteIndicator.dispose();
         this.inviteIndicator = null;
         this.candidateName.dispose();
         this.candidateName = null;
         this.candidateRating = null;
         if(this.statusIcon != null)
         {
            this.statusIcon.dispose();
            this.statusIcon = null;
         }
         this._cadidateData = null;
         this._voiceChatMgr = null;
         this._tooltipMgr = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            visible = this._cadidateData != null;
            this.voiceWave.visible = App.voiceChatMgr.isVOIPEnabledS();
            if(this._cadidateData)
            {
               this.inviteIndicator.visible = this._cadidateData.isInvite;
               if(this.statusIcon != null)
               {
                  this.statusIcon.visible = visible;
                  this.statusIcon.source = !!visible ? this.data.statusIcon : Values.EMPTY_STR;
               }
               if(this._cadidateData.isRatingAvailable)
               {
                  this.candidateRating.visible = true;
                  this.candidateRating.text = this._cadidateData.rating;
               }
               else
               {
                  this.candidateRating.visible = false;
               }
               this.candidateName.userVO = this._cadidateData;
               this.candidateName.visible = true;
               this.setSpeakers(this._cadidateData.isPlayerSpeaking,true);
               this.voiceWave.setMuted(UserTags.isMuted(this._cadidateData.tags));
            }
            else
            {
               this.setSpeakers(false,true);
               this.voiceWave.setMuted(false);
            }
         }
      }
      
      public function onPlayerSpeak(param1:Number, param2:Boolean) : void
      {
         if(data && param1 == data.uid)
         {
            this.setSpeakers(param2);
         }
      }
      
      public function update(param1:Object) : void
      {
         this.setData(param1);
      }
      
      protected function setSpeakers(param1:Boolean, param2:Boolean = false) : void
      {
         if(!visible)
         {
            return;
         }
         if(param1)
         {
            param2 = false;
         }
         if(this.voiceWave is VoiceWave)
         {
            this.voiceWave.setSpeaking(param1,param2);
         }
         if(data)
         {
            data.isPlayerSpeaking = param1;
         }
      }
      
      override public function set data(param1:Object) : void
      {
         if(param1 == Values.EMPTY_STR)
         {
            return;
         }
         super.data = param1;
      }
      
      public function get getCursorType() : String
      {
         return Cursors.DRAG_OPEN;
      }
      
      private function onVoiceChatMgrStartSpeakingHandler(param1:VoiceChatEvent) : void
      {
         this.onPlayerSpeak(param1.getAccountDBID(),true);
      }
      
      private function onVoiceChatMgrStopSpeakingHandler(param1:VoiceChatEvent) : void
      {
         this.onPlayerSpeak(param1.getAccountDBID(),false);
      }
      
      private function onRollOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(this._cadidateData && this._cadidateData.getToolTip() != Values.EMPTY_STR)
         {
            _loc2_ = this._cadidateData.getToolTip();
            if(StringUtils.isNotEmpty(_loc2_))
            {
               this._tooltipMgr.show(_loc2_);
            }
         }
      }
      
      private function onRollOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
      
      private function onDoubleClickHandler(param1:MouseEvent) : void
      {
         if(this._cadidateData)
         {
            dispatchEvent(new RallyViewsEvent(RallyViewsEvent.ASSIGN_FREE_SLOT_REQUEST,this._cadidateData.dbID));
         }
      }
   }
}
