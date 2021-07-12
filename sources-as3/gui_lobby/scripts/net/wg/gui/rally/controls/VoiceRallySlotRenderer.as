package net.wg.gui.rally.controls
{
   import flash.display.MovieClip;
   import net.wg.data.constants.UserTags;
   import net.wg.gui.components.controls.VoiceWave;
   import net.wg.infrastructure.events.VoiceChatEvent;
   
   public class VoiceRallySlotRenderer extends RallySimpleSlotRenderer
   {
       
      
      public var selfBg:MovieClip;
      
      public var voiceWave:VoiceWave = null;
      
      public function VoiceRallySlotRenderer()
      {
         super();
      }
      
      public function updateVoiceWave() : void
      {
         this.voiceWave.visible = App.voiceChatMgr.isVOIPEnabledS();
         this.voiceWave.setMuted(slotData && slotData.player ? Boolean(UserTags.isMuted(slotData.player.tags)) : Boolean(false));
      }
      
      public function setSpeakers(param1:Boolean, param2:Boolean = false) : void
      {
         if(param1)
         {
            param2 = false;
         }
         if(this.voiceWave is VoiceWave)
         {
            this.voiceWave.setSpeaking(param1,param2);
         }
         if(slotData && slotData.player)
         {
            slotData.player.isPlayerSpeaking = param1;
         }
      }
      
      public function onPlayerSpeak(param1:Number, param2:Boolean) : void
      {
         if(slotData && slotData.player && param1 == slotData.player.dbID)
         {
            this.setSpeakers(param2);
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.voiceWave.visible = App.voiceChatMgr.isVOIPEnabledS();
         App.voiceChatMgr.addEventListener(VoiceChatEvent.START_SPEAKING,this.speakHandler);
         App.voiceChatMgr.addEventListener(VoiceChatEvent.STOP_SPEAKING,this.speakHandler);
      }
      
      protected function speakHandler(param1:VoiceChatEvent) : void
      {
         this.onPlayerSpeak(param1.getAccountDBID(),param1.type == VoiceChatEvent.START_SPEAKING);
      }
      
      override protected function onDispose() : void
      {
         App.voiceChatMgr.removeEventListener(VoiceChatEvent.START_SPEAKING,this.speakHandler);
         App.voiceChatMgr.removeEventListener(VoiceChatEvent.STOP_SPEAKING,this.speakHandler);
         this.voiceWave.dispose();
         this.voiceWave = null;
         super.onDispose();
      }
   }
}
